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

package com.albedo.java.modules.admin.service.impl;

import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.persistence.service.impl.DataVoServiceImpl;
import com.albedo.java.modules.admin.domain.RoleDeptEntity;
import com.albedo.java.modules.admin.service.RoleDeptService;
import com.albedo.java.modules.admin.service.RoleMenuService;
import com.albedo.java.modules.admin.vo.RoleDataVo;
import com.albedo.java.modules.admin.domain.RoleEntity;
import com.albedo.java.modules.admin.domain.RoleMenuEntity;
import com.albedo.java.modules.admin.repository.RoleRepository;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.albedo.java.modules.admin.service.RoleService;
import lombok.AllArgsConstructor;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
@Service
@AllArgsConstructor
public class RoleServiceImpl extends
	DataVoServiceImpl<RoleRepository, RoleEntity, String, RoleDataVo> implements RoleService {
	private RoleMenuService roleMenuService;
	private RoleDeptService roleDeptService;
	private final CacheManager cacheManager;

	@Override
	public RoleDataVo findOneVo(String id) {
		RoleDataVo oneVo = super.findOneVo(id);
		oneVo.setMenuIdList(roleMenuService.list(Wrappers
			.<RoleMenuEntity>query().lambda()
			.eq(RoleMenuEntity::getRoleId, id)).stream().map(RoleMenuEntity::getMenuId).collect(Collectors.toList()));
		oneVo.setDeptIdList(roleDeptService.list(Wrappers
			.<RoleDeptEntity>query().lambda()
			.eq(RoleDeptEntity::getRoleId, id)).stream().map(RoleDeptEntity::getDeptId).collect(Collectors.toList()));
		return oneVo;
	}

	/**
	 * 通过用户ID，查询角色信息
	 *
	 * @param userId
	 * @return
	 */
	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public List listRolesByUserId(String userId) {
		return baseMapper.listRolesByUserId(userId);
	}

	/**
	 * 通过角色ID，删除角色,并清空角色菜单缓存
	 *
	 * @param ids
	 * @return
	 */
	@Override
	@CacheEvict(value = "menu_details", allEntries = true)
	@Transactional(rollbackFor = Exception.class)
	public Boolean removeRoleByIds(List<String> ids) {
		ids.forEach(id->{
			roleMenuService.remove(Wrappers
				.<RoleMenuEntity>update().lambda()
				.eq(RoleMenuEntity::getRoleId, id));
			this.removeById(id);
		});
		return Boolean.TRUE;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	@CacheEvict(value = "menu_details", key = "#roleDataVo.id  + '_menu'")
	public void save(RoleDataVo roleDataVo) {
		super.save(roleDataVo);
		roleMenuService.remove(Wrappers.<RoleMenuEntity>query().lambda()
			.eq(RoleMenuEntity::getRoleId, roleDataVo.getId()));
		List<RoleMenuEntity> roleMenuEntityList = roleDataVo.getMenuIdList().stream().map(menuId -> {
				RoleMenuEntity roleMenuEntity = new RoleMenuEntity();
				roleMenuEntity.setRoleId(roleDataVo.getId());
				roleMenuEntity.setMenuId(menuId);
				return roleMenuEntity;
			}).collect(Collectors.toList());

		roleMenuService.saveBatch(roleMenuEntityList);
		if(CollUtil.isNotEmpty(roleDataVo.getDeptIdList())){
			roleDeptService.remove(Wrappers.<RoleDeptEntity>query().lambda()
				.eq(RoleDeptEntity::getRoleId, roleDataVo.getId()));
			List<RoleDeptEntity> roleDeptEntityList = roleDataVo.getDeptIdList().stream().map(deptId -> {
				RoleDeptEntity roleDeptEntity = new RoleDeptEntity();
				roleDeptEntity.setRoleId(roleDataVo.getId());
				roleDeptEntity.setDeptId(deptId);
				return roleDeptEntity;
			}).collect(Collectors.toList());
			roleDeptService.saveBatch(roleDeptEntityList);
		}
		//清空userinfo
		cacheManager.getCache("user_details").clear();
	}
}
