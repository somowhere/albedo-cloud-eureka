/*
 *  Copyright (c) 2019-2020, 冷冷 (somewhere0813@gmail.com).
 *  <p>
 *  Licensed under the GNU Lesser General Public License 3.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *  <p>
 * https://www.gnu.org/licenses/lgpl.html
 *  <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.albedo.java.modules.sys.service.impl;

import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.modules.sys.dto.DeptTree;
import com.albedo.java.modules.sys.entity.Dept;
import com.albedo.java.modules.sys.entity.DeptRelation;
import com.albedo.java.modules.sys.repository.DeptRepository;
import com.albedo.java.modules.sys.service.DeptRelationService;
import com.albedo.java.modules.sys.service.DeptService;
import com.albedo.java.modules.sys.vo.TreeUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.AllArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

/**
 * <p>
 * 部门管理 服务实现类
 * </p>
 *
 * @author lengleng
 * @since 2019/2/1
 */
@Service
@AllArgsConstructor
public class DeptServiceImpl extends ServiceImpl<DeptRepository, Dept> implements DeptService {
	private final DeptRelationService deptRelationService;

	/**
	 * 添加信息部门
	 *
	 * @param dept 部门
	 * @return
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public Boolean saveDept(Dept dept) {
		Dept sysDept = new Dept();
		BeanUtils.copyProperties(dept, sysDept);
		this.save(sysDept);
		deptRelationService.saveDeptRelation(sysDept);
		return Boolean.TRUE;
	}


	/**
	 * 删除部门
	 *
	 * @param id 部门 ID
	 * @return 成功、失败
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public Boolean removeDeptById(Integer id) {
		//级联删除部门
		List<String> idList = deptRelationService
			.list(Wrappers.<DeptRelation>query().lambda()
				.eq(DeptRelation::getAncestor, id))
			.stream()
			.map(DeptRelation::getDescendant)
			.collect(Collectors.toList());

		if (CollUtil.isNotEmpty(idList)) {
			this.removeByIds(idList);
		}

		//删除部门级联关系
		deptRelationService.removeDeptRelationById(id);
		return Boolean.TRUE;
	}

	/**
	 * 更新部门
	 *
	 * @param dept 部门信息
	 * @return 成功、失败
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public Boolean updateDeptById(Dept dept) {
		//更新部门状态
		this.updateById(dept);
		//更新部门关系
		DeptRelation relation = new DeptRelation();
		relation.setAncestor(dept.getParentId());
		relation.setDescendant(dept.getId());
		deptRelationService.updateDeptRelation(relation);
		return Boolean.TRUE;
	}

	/**
	 * 查询全部部门树
	 *
	 * @return 树
	 */
	@Override
	public List<DeptTree> listDeptTrees() {
		return getDeptTree(this.list(Wrappers.emptyWrapper()));
	}

	/**
	 * 查询用户部门树
	 *
	 * @return
	 */
	@Override
	public List<DeptTree> listCurrentUserDeptTrees(String deptId) {
		List<String> descendantIdList = deptRelationService
			.list(Wrappers.<DeptRelation>query().lambda()
				.eq(DeptRelation::getAncestor, deptId))
			.stream().map(DeptRelation::getDescendant)
			.collect(Collectors.toList());

		List<Dept> deptList = baseMapper.selectBatchIds(descendantIdList);
		return getDeptTree(deptList);
	}

	/**
	 * 构建部门树
	 *
	 * @param depts 部门
	 * @return
	 */
	private List<DeptTree> getDeptTree(List<Dept> depts) {
		List<DeptTree> treeList = depts.stream()
			.filter(dept -> !dept.getId().equals(dept.getParentId()))
			.map(dept -> {
				DeptTree node = new DeptTree();
				node.setId(dept.getId());
				node.setParentId(dept.getParentId());
				node.setName(dept.getName());
				return node;
			}).collect(Collectors.toList());
		return TreeUtil.buildByLoop(treeList, 0);
	}
}
