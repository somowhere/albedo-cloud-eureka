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

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.exception.RuntimeMsgException;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.TreeUtil;
import com.albedo.java.common.persistence.service.impl.TreeVoServiceImpl;
import com.albedo.java.modules.admin.domain.MenuEntity;
import com.albedo.java.modules.admin.domain.RoleMenuEntity;
import com.albedo.java.modules.admin.repository.MenuRepository;
import com.albedo.java.modules.admin.repository.RoleMenuRepository;
import com.albedo.java.modules.admin.service.MenuService;
import com.albedo.java.modules.admin.vo.GenSchemeDataVo;
import com.albedo.java.modules.admin.vo.MenuDataVo;
import com.albedo.java.modules.admin.vo.MenuTree;
import com.albedo.java.modules.admin.vo.MenuVo;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.google.common.collect.Lists;
import lombok.AllArgsConstructor;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 * 菜单权限表 服务实现类
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
@Service
@AllArgsConstructor
public class MenuServiceImpl extends
	TreeVoServiceImpl<MenuRepository, MenuEntity, MenuDataVo> implements MenuService {
	private final RoleMenuRepository roleMenuRepository;

	@Override
	@Cacheable(value = "menu_details", key = "#roleId  + '_menu'")
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public List<MenuVo> getMenuByRoleId(String roleId) {
		List<MenuVo> menuAllList = baseMapper.listMenuVos(CommonConstants.YES);
		List<MenuVo> menuVoList = baseMapper.listMenuVosByRoleId(roleId, CommonConstants.YES);
		List<String> parentIdList = Lists.newArrayList();
		for(MenuVo menuVo : menuVoList){
			if(menuVo.getParentId()!=null){
				if(!parentIdList.contains(menuVo.getParentId())){
					parentIdList.add(menuVo.getParentId());
				}
			}
			if(menuVo.getParentIds()!=null){
				String[] parentIds = menuVo.getParentIds().split(",");
				for(String parentId : parentIds){
					if(!parentIdList.contains(parentId)){
						parentIdList.add(parentId);
					}
				}
			}
		}
		if(ObjectUtil.isNotEmpty(parentIdList)){
			for(String parenId: parentIdList){
				if(!contain(parenId, menuVoList)){
					MenuVo menuVo = get(parenId, menuAllList);
					if(menuVo!=null){
						menuVoList.add(menuVo);
					}
				}
			}
		}
		return menuVoList;

	}
	private MenuVo get(String id, List<MenuVo> resourceList){
		for(MenuVo resource : resourceList){
			if(resource.getId().equals(id)){
				return resource;
			}
		}
		return null;
	}


	private boolean contain(String id, List<MenuVo> resourceList){
		for(MenuVo resource : resourceList){
			if(resource.getId().equals(id)){
				return true;
			}
		}
		return false;
	}
	@Override
	@CacheEvict(value = "menu_details", allEntries = true)
	public void removeMenuById(List<String> ids) {
		ids.forEach(id->{
			// 查询父节点为当前节点的节点
			List<MenuEntity> menuEntityList = this.list(Wrappers.<MenuEntity>query()
				.lambda().eq(MenuEntity::getParentId, id));
			if (CollUtil.isNotEmpty(menuEntityList)) {
				throw new RuntimeMsgException("菜单含有下级不能删除");
			}

			roleMenuRepository
				.delete(Wrappers.<RoleMenuEntity>query()
					.lambda().eq(RoleMenuEntity::getMenuId, id));
			//删除当前菜单及其子菜单
			this.removeById(id);
		});

	}

	@Override
	@CacheEvict(value = "menu_details", allEntries = true)
	public MenuDataVo save(MenuDataVo form) {
		return super.save(form);
	}

	@Override
	@CacheEvict(value = "menu_details", allEntries = true)
	public boolean saveByGenScheme(GenSchemeDataVo schemeDataVo) {

		String moduleName= schemeDataVo.getSchemeName(),
			parentMenuId= schemeDataVo.getParentMenuId(),
			url= schemeDataVo.getUrl();
		String permission = url.replace("/", "_").substring(1), permissionLike = permission.substring(0,permission.length()-1)+"%";
		List<MenuEntity> currentMenuEntityList = baseMapper.selectList(Wrappers.<MenuEntity>query()
				.lambda().eq(MenuEntity::getName, moduleName)
				.like(MenuEntity::getPermission, permissionLike)
		);
		for(MenuEntity currentMenuEntity : currentMenuEntityList){
			if (currentMenuEntity != null) {
				baseMapper.delete(Wrappers.<MenuEntity>query()
					.lambda()
					.like(MenuEntity::getPermission, permissionLike)
					.and(i->i.eq(MenuEntity::getId, currentMenuEntity.getId())
						.or().eq(MenuEntity::getParentId, currentMenuEntity.getId()))
				);
			}
		}
		MenuEntity parentMenuEntity = baseMapper.selectById(parentMenuId);
		Assert.isTrue(parentMenuEntity != null, StringUtil.toAppendStr("根据模块id[", parentMenuId, "无法查询到模块信息]"));


		MenuEntity module = new MenuEntity();
		module.setPermission(permission.substring(0, permission.length() - 1));
		module.setName(moduleName);
		module.setParentId(parentMenuEntity.getId());
		module.setType(MenuEntity.TYPE_MENU);
		module.setIcon("icon-right-square");
		module.setPath(url + "list");
		module.setComponent("views/modules"+url+"index");
		save(module);

		MenuEntity moduleView = new MenuEntity();
		moduleView.setParent(module);
		moduleView.setName("查看");
		moduleView.setIcon("fa-info-circle");
		moduleView.setPermission(permission + "view");
		moduleView.setParentId(module.getId());
		moduleView.setType(MenuEntity.TYPE_BUTTON);
		moduleView.setSort(20);
		moduleView.setPath(url);
		save(moduleView);
		MenuEntity moduleEdit = new MenuEntity();
		moduleEdit.setParent(module);
		moduleEdit.setName("编辑");
//        moduleEdit.setIconCls("icon-edit-fill");
		moduleEdit.setPermission(permission + "edit");
		moduleEdit.setParentId(module.getId());
		moduleEdit.setType(MenuEntity.TYPE_BUTTON);
		moduleEdit.setSort(40);
		moduleEdit.setPath(url);
		save(moduleEdit);
		MenuEntity moduleLock = new MenuEntity();
		moduleLock.setParent(module);
		moduleLock.setName("锁定");
//        moduleLock.setIconCls("fa-lock");
		moduleLock.setPermission(permission + "lock");
		moduleLock.setParentId(module.getId());
		moduleLock.setType(MenuEntity.TYPE_BUTTON);
		moduleLock.setSort(60);
		moduleLock.setPath(url);
		save(moduleLock);
		MenuEntity moduleDelete = new MenuEntity();
		moduleDelete.setParent(module);
		moduleDelete.setName("删除");
//        moduleDelete.setIconCls("fa-trash-o");
		moduleDelete.setPermission(permission + "delete");
		moduleDelete.setParentId(module.getId());
		moduleDelete.setType(MenuEntity.TYPE_BUTTON);
		moduleDelete.setSort(80);
		moduleDelete.setPath(url);
		save(moduleDelete);
		return true;
	}

	@Override
	public List<MenuTree> listMenuTrees() {
		List<MenuTree> trees = new ArrayList<>();
		MenuTree node;
		List<MenuEntity> menuEntities = baseMapper.selectList(Wrappers.emptyWrapper());
		for (MenuEntity menuEntity : menuEntities) {
			node = new MenuTree();
			node.setId(menuEntity.getId());
			node.setParentId(menuEntity.getParentId());
			node.setName(menuEntity.getName());
			node.setPath(menuEntity.getPath());
			node.setCode(menuEntity.getPermission());
			node.setLabel(menuEntity.getName());
			node.setComponent(menuEntity.getComponent());
			node.setIcon(menuEntity.getIcon());
			node.setKeepAlive(menuEntity.getKeepAlive());
			trees.add(node);
		}
		return TreeUtil.buildByLoop(trees, MenuEntity.ROOT);
	}
}
