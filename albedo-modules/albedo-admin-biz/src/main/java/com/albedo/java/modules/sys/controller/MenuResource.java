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

package com.albedo.java.modules.sys.controller;

import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.security.annotation.Inner;
import com.albedo.java.common.web.resource.DataVoResource;
import com.albedo.java.common.web.resource.TreeVoResource;
import com.albedo.java.modules.sys.service.RoleService;
import com.albedo.java.modules.sys.vo.*;
import com.albedo.java.modules.sys.domain.Menu;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.albedo.java.modules.sys.service.MenuService;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.R;
import com.albedo.java.common.log.annotation.SysLog;
import com.albedo.java.common.security.util.SecurityUtils;
import com.google.common.collect.Lists;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Comparator;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * @author somewhere
 * @date 2019/2/1
 */
@RestController
@RequestMapping("/sys/menu")
public class MenuResource extends TreeVoResource<MenuService, MenuDataVo> {

	public MenuResource(MenuService service) {
		super(service);
	}

	/**
	 * 返回当前用户的树形菜单集合
	 *
	 * @return 当前用户的树形菜单
	 */
	@GetMapping
	public R getUserMenu() {
		// 获取符合条件的菜单
		Set<MenuVo> all = new HashSet<>();
		SecurityUtils.getRoles()
			.forEach(roleId -> all.addAll(service.getMenuByRoleId(roleId)));
		List<MenuTree> menuTreeList = all.stream()
			.filter(menuVo -> CommonConstants.MENU.equals(menuVo.getType()))
			.map(MenuTree::new)
			.sorted(Comparator.comparingInt(MenuTree::getSort))
			.collect(Collectors.toList());
		return new R<>(TreeUtil.buildByLoop(menuTreeList, Menu.ROOT));
	}

	/**
	 * 返回树形菜单集合
	 *
	 * @return 树形菜单
	 */
	@GetMapping(value = "/tree")
	public R getTree() {
		return R.createSuccessData(TreeUtil.buildTree(service.list(Wrappers.emptyWrapper()), Menu.ROOT));
	}

	/**
	 * 返回角色的菜单集合
	 *
	 * @param roleId 角色ID
	 * @return 属性集合
	 */
	@GetMapping("/tree/{roleId}")
	public List getRoleTree(@PathVariable String roleId) {
		return service.getMenuByRoleId(roleId)
			.stream()
			.map(MenuVo::getId)
			.collect(Collectors.toList());
	}

	/**
	 * 新增菜单
	 *
	 * @param menu 菜单信息
	 * @return success/false
	 */
	@SysLog("新增菜单")
	@PostMapping
	@PreAuthorize("@pms.hasPermission('sys_menu_edit')")
	public R save(@Valid @RequestBody Menu menu) {
		service.save(menu);
		return R.createSuccess("操作成功");
	}


	/**
	 * 新增菜单
	 *
	 * @param genSchemeDataVo 菜单信息
	 * @return success/false
	 */
	@Inner
	@PostMapping("/gen")
	public R saveByGenScheme(@Valid @RequestBody GenSchemeDataVo genSchemeDataVo) {
		service.saveByGenScheme(genSchemeDataVo);
		return R.createSuccess("操作成功");
	}

	/**
	 * 删除菜单
	 *
	 * @param ids 菜单ID
	 * @return success/false
	 */
	@SysLog("删除菜单")
	@DeleteMapping(CommonConstants.URL_IDS_REGEX)
	@PreAuthorize("@pms.hasPermission('sys_menu_del')")
	public R removeByIds(@PathVariable String ids) {
		return service.removeMenuById(ids);
	}

	/**
	 * @param ids
	 * @return
	 */
	@PutMapping(CommonConstants.URL_IDS_REGEX)
	@SysLog("锁定/解锁菜单")
	@PreAuthorize("@pms.hasPermission('sys_menu_lock')")
	public R lockOrUnLock(@PathVariable String ids) {
		service.lockOrUnLock(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
		return R.createSuccess("操作成功");
	}

}
