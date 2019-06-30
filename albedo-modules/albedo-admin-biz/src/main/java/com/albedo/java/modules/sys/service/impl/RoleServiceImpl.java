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

import com.albedo.java.common.persistence.service.impl.DataVoServiceImpl;
import com.albedo.java.modules.sys.vo.RoleDataVo;
import com.albedo.java.modules.sys.domain.Role;
import com.albedo.java.modules.sys.domain.RoleMenu;
import com.albedo.java.modules.sys.repository.RoleRepository;
import com.albedo.java.modules.sys.repository.RoleMenuRepository;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.albedo.java.modules.sys.service.RoleService;
import lombok.AllArgsConstructor;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

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
	DataVoServiceImpl<RoleRepository, Role, String, RoleDataVo> implements RoleService {
	private RoleMenuRepository roleMenuRepository;

	/**
	 * 通过用户ID，查询角色信息
	 *
	 * @param userId
	 * @return
	 */
	@Override
	public List listRolesByUserId(String userId) {
		return baseMapper.listRolesByUserId(userId);
	}

	/**
	 * 通过角色ID，删除角色,并清空角色菜单缓存
	 *
	 * @param id
	 * @return
	 */
	@Override
	@CacheEvict(value = "menu_details", allEntries = true)
	@Transactional(rollbackFor = Exception.class)
	public Boolean removeRoleById(String id) {
		roleMenuRepository.delete(Wrappers
			.<RoleMenu>update().lambda()
			.eq(RoleMenu::getRoleId, id));
		return this.removeById(id);
	}
}
