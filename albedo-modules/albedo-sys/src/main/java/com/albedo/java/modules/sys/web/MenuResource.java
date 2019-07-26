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

package com.albedo.java.modules.sys.web;

import com.albedo.java.common.core.exception.RuntimeMsgException;
import com.albedo.java.common.core.util.ClassUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.core.vo.TreeQuery;
import com.albedo.java.common.core.vo.TreeUtil;
import com.albedo.java.common.security.annotation.Inner;
import com.albedo.java.common.web.resource.TreeVoResource;
import com.albedo.java.modules.sys.vo.*;
import com.albedo.java.modules.sys.domain.Menu;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.albedo.java.modules.sys.service.MenuService;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.R;
import com.albedo.java.common.log.annotation.SysLog;
import com.albedo.java.common.security.util.SecurityUtils;
import com.codahale.metrics.annotation.Timed;
import com.google.common.collect.Lists;
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
@RequestMapping("/menu")
public class MenuResource extends TreeVoResource<MenuService, MenuDataVo> {

	public MenuResource(MenuService service) {
		super(service);
	}
	/**
	 * @param id
	 * @return
	 */
	@GetMapping(CommonConstants.URL_ID_REGEX)
	@Timed
	public R get(@PathVariable String id) {
		log.debug("REST request to get Entity : {}", id);
		return  R.createSuccessData(service.findOneVo(id));
	}
	/**
	 * 返回当前用户的树形菜单集合
	 *
	 * @return 当前用户的树形菜单
	 */
	@GetMapping("/user-menu")
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
	public R getTree(TreeQuery treeQuery) {
		return R.createSuccessData(service.listMenuTrees(treeQuery));
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
	 * @param menuDataVo 菜单信息
	 * @return success/false
	 */
	@SysLog("添加/更新菜单")
	@PostMapping
	@PreAuthorize("@pms.hasPermission('sys_menu_edit')")
	public R save(@Valid @RequestBody MenuDataVo menuDataVo) {

		// permission before comparing with database
		if (StringUtil.isNotEmpty(menuDataVo.getPermission()) && !checkByProperty(ClassUtil.createObj(MenuDataVo.class,
			Lists.newArrayList(MenuDataVo.F_ID, MenuDataVo.F_PERMISSION),
			menuDataVo.getId(), menuDataVo.getPermission()))) {
			throw new RuntimeMsgException("权限已存在");
		}

		service.save(menuDataVo);
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
		service.removeMenuById(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
		return R.createSuccess("操作成功");
	}

	/**
	 * 分页查询菜单信息
	 *
	 * @param pm 分页对象
	 * @return 分页对象
	 */
	@GetMapping("/")
	public R<IPage> getPage(PageModel pm) {
		return new R<>(service.findRelationPage(pm));
	}


	/**
	 * 新增代码生成菜单
	 *
	 * @param schemeDataVo 菜单信息
	 * @return success/false
	 */
	@Inner
	@PostMapping("/gen")
	public R saveByGenScheme(@Valid @RequestBody GenSchemeDataVo schemeDataVo) {
		service.saveByGenScheme(schemeDataVo);
		return R.createSuccess("操作成功");
	}

}
