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
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.persistence.service.impl.TreeVoServiceImpl;
import com.albedo.java.modules.sys.vo.GenSchemeDataVo;
import com.albedo.java.modules.sys.vo.MenuDataVo;
import com.albedo.java.modules.sys.entity.Menu;
import com.albedo.java.modules.sys.entity.RoleMenu;
import com.albedo.java.modules.sys.repository.MenuRepository;
import com.albedo.java.modules.sys.repository.RoleMenuRepository;
import com.albedo.java.modules.sys.vo.MenuVo;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.albedo.java.modules.sys.service.MenuService;
import com.albedo.java.common.core.util.R;
import lombok.AllArgsConstructor;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

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
public class MenuServiceImpl extends
	TreeVoServiceImpl<MenuRepository, Menu, MenuDataVo> implements MenuService {
	private final RoleMenuRepository roleMenuRepository;

	@Override
	@Cacheable(value = "menu_details", key = "#roleId  + '_menu'")
	public List<MenuVo> getMenuByRoleId(String roleId) {
		return baseMapper.listMenusByRoleId(roleId);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	@CacheEvict(value = "menu_details", allEntries = true)
	public R removeMenuById(String id) {
		// 查询父节点为当前节点的节点
		List<Menu> menuList = this.list(Wrappers.<Menu>query()
			.lambda().eq(Menu::getParentId, id));
		if (CollUtil.isNotEmpty(menuList)) {
			return R.createFail("菜单含有下级不能删除");
		}

		roleMenuRepository
			.delete(Wrappers.<RoleMenu>query()
				.lambda().eq(RoleMenu::getMenuId, id));

		//删除当前菜单及其子菜单
		return R.createSuccessData(this.removeById(id));
	}

	@Override
	@CacheEvict(value = "menu_details", allEntries = true)
	public Boolean updateMenuById(Menu menu) {
		return this.updateById(menu);
	}

	@Override
	public boolean saveByGenScheme(GenSchemeDataVo genSchemeDataVo) {

		String moduleName= genSchemeDataVo.getSchemeName(),
			parentMenuId= genSchemeDataVo.getParentMenuId(),
			url= genSchemeDataVo.getUrl();
		String permission = url.replace("/", "_").substring(1), permissionLike = permission.substring(0,permission.length()-1)+"%";
		List<Menu> currentMenuList = baseMapper.selectList(Wrappers.<Menu>query()
				.lambda().eq(Menu::getName, moduleName)
				.like(Menu::getPermission, permissionLike)
		);
		for(Menu currentMenu : currentMenuList){
			if (currentMenu != null) {
				baseMapper.delete(Wrappers.<Menu>query()
					.lambda()
					.like(Menu::getPermission, permissionLike)
					.and(i->i.eq(Menu::getId, currentMenu.getId())
						.or().eq(Menu::getParentId, currentMenu.getId()))
				);
			}
		}
		Menu parentMenu = baseMapper.selectById(parentMenuId);
		Assert.isTrue(parentMenu != null, StringUtil.toAppendStr("根据模块id[", parentMenuId, "无法查询到模块信息]"));


		Menu module = new Menu();
		module.setPermission(permission.substring(0, permission.length() - 1));
		module.setName(moduleName);
		module.setParentId(parentMenu.getId());
		module.setType(Menu.TYPE_MENU);
		module.setIcon("icon-right-square");
		module.setPath(url + "list");
		module.setComponent("views/modules"+url+"index");
		save(module);

		Menu moduleView = new Menu();
		moduleView.setParent(module);
		moduleView.setName("查看");
		moduleView.setIcon("fa-info-circle");
		moduleView.setPermission(permission + "view");
		moduleView.setParentId(module.getId());
		moduleView.setType(Menu.TYPE_BUTTON);
		moduleView.setSort(20);
		moduleView.setPath(url);
		save(moduleView);
		Menu moduleEdit = new Menu();
		moduleEdit.setParent(module);
		moduleEdit.setName("编辑");
//        moduleEdit.setIconCls("icon-edit-fill");
		moduleEdit.setPermission(permission + "edit");
		moduleEdit.setParentId(module.getId());
		moduleEdit.setType(Menu.TYPE_BUTTON);
		moduleEdit.setSort(40);
		moduleEdit.setPath(url);
		save(moduleEdit);
		Menu moduleLock = new Menu();
		moduleLock.setParent(module);
		moduleLock.setName("锁定");
//        moduleLock.setIconCls("fa-lock");
		moduleLock.setPermission(permission + "lock");
		moduleLock.setParentId(module.getId());
		moduleLock.setType(Menu.TYPE_BUTTON);
		moduleLock.setSort(60);
		moduleLock.setPath(url);
		save(moduleLock);
		Menu moduleDelete = new Menu();
		moduleDelete.setParent(module);
		moduleDelete.setName("删除");
//        moduleDelete.setIconCls("fa-trash-o");
		moduleDelete.setPermission(permission + "delete");
		moduleDelete.setParentId(module.getId());
		moduleDelete.setType(Menu.TYPE_BUTTON);
		moduleDelete.setSort(80);
		moduleDelete.setPath(url);
		save(moduleDelete);
		return true;
	}
}
