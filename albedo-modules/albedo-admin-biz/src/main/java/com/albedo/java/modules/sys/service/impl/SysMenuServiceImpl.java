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

import cn.hutool.core.collection.CollUtil;
import com.albedo.java.modules.sys.entity.SysMenu;
import com.albedo.java.modules.sys.entity.SysRoleMenu;
import com.albedo.java.modules.sys.mapper.SysMenuMapper;
import com.albedo.java.modules.sys.mapper.SysRoleMenuMapper;
import com.albedo.java.modules.sys.vo.MenuVO;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.albedo.java.modules.sys.service.SysMenuService;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.R;
import lombok.AllArgsConstructor;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * <p>
 * 菜单权限表 服务实现类
 * </p>
 *
 * @author lengleng
 * @since 2019/2/1
 */
@Service
@AllArgsConstructor
public class SysMenuServiceImpl extends ServiceImpl<SysMenuMapper, SysMenu> implements SysMenuService {
	private final SysRoleMenuMapper sysRoleMenuMapper;

	@Override
	@Cacheable(value = "menu_details", key = "#roleId  + '_menu'")
	public List<MenuVO> getMenuByRoleId(Integer roleId) {
		return baseMapper.listMenusByRoleId(roleId);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	@CacheEvict(value = "menu_details", allEntries = true)
	public R removeMenuById(Integer id) {
		// 查询父节点为当前节点的节点
		List<SysMenu> menuList = this.list(Wrappers.<SysMenu>query()
			.lambda().eq(SysMenu::getParentId, id));
		if (CollUtil.isNotEmpty(menuList)) {
			return R.builder()
				.code(CommonConstants.FAIL)
				.msg("菜单含有下级不能删除").build();
		}

		sysRoleMenuMapper
			.delete(Wrappers.<SysRoleMenu>query()
				.lambda().eq(SysRoleMenu::getMenuId, id));

		//删除当前菜单及其子菜单
		return new R(this.removeById(id));
	}

	@Override
	@CacheEvict(value = "menu_details", allEntries = true)
	public Boolean updateMenuById(SysMenu sysMenu) {
		return this.updateById(sysMenu);
	}
}
