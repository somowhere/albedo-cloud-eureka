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

package com.albedo.java.modules.sys.service;

import com.albedo.java.common.persistence.service.TreeVoService;
import com.albedo.java.modules.sys.vo.DeptDataVo;
import com.albedo.java.modules.sys.vo.DeptTree;
import com.albedo.java.modules.sys.entity.Dept;
import com.albedo.java.modules.sys.repository.DeptRepository;

import java.util.List;

/**
 * <p>
 * 部门管理 服务类
 * </p>
 *
 * @author lengleng
 * @since 2019/2/1
 */
public interface DeptService  extends TreeVoService<DeptRepository, Dept, DeptDataVo> {

	/**
	 * 查询部门树菜单
	 *
	 * @return 树
	 */
	List<DeptTree> listDeptTrees();

	/**
	 * 查询用户部门树
	 *
	 * @return
	 */
	List<DeptTree> listCurrentUserDeptTrees(String deptId) ;

	/**
	 * 添加信息部门
	 *
	 * @param dept
	 * @return
	 */
	Boolean saveDept(Dept dept);

	/**
	 * 删除部门
	 *
	 * @param id 部门 ID
	 * @return 成功、失败
	 */
	Boolean removeDeptById(Integer id);

	/**
	 * 更新部门
	 *
	 * @param dept 部门信息
	 * @return 成功、失败
	 */
	Boolean updateDeptById(Dept dept);

}
