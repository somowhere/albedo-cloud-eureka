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

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.web.resource.DataVoResource;
import com.albedo.java.modules.sys.domain.Role;
import com.albedo.java.modules.sys.service.UserService;
import com.albedo.java.modules.sys.vo.RoleDataVo;
import com.albedo.java.modules.sys.vo.UserDataVo;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.albedo.java.modules.sys.service.RoleMenuService;
import com.albedo.java.modules.sys.service.RoleService;
import com.albedo.java.common.core.util.R;
import com.albedo.java.common.log.annotation.SysLog;
import com.google.common.collect.Lists;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

/**
 * @author somewhere
 * @date 2019/2/1
 */
@RestController
@RequestMapping("/sys/role")
public class RoleResource extends DataVoResource<RoleService, RoleDataVo> {
	private final RoleMenuService roleMenuService;

	public RoleResource(RoleService service, RoleMenuService roleMenuService) {
		super(service);
		this.roleMenuService = roleMenuService;
	}

	/**
	 * 添加角色
	 *
	 * @param roleDataVo 角色信息
	 * @return success、false
	 */
	@SysLog("新增/编辑角色")
	@PostMapping
	@PreAuthorize("@pms.hasPermission('sys_role_edit')")
	public R save(@Valid @RequestBody RoleDataVo roleDataVo) {
		service.save(roleDataVo);
		return R.createSuccess("操作成功");
	}
	/**
	 * @param ids
	 * @return
	 */
	@PutMapping(CommonConstants.URL_IDS_REGEX)
	@SysLog("锁定/解锁角色")
	@PreAuthorize("@pms.hasPermission('sys_role_lock')")
	public R lockOrUnLock(@PathVariable String ids) {
		service.lockOrUnLock(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
		return R.createSuccess("操作成功");
	}

	/**
	 * 删除角色
	 *
	 * @param ids
	 * @return
	 */
	@SysLog("删除角色")
	@DeleteMapping(CommonConstants.URL_IDS_REGEX)
	public R removeByIds(@PathVariable String ids) {
		service.removeByIds(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
		return R.createSuccess("操作成功");
	}

	/**
	 * 获取角色列表
	 *
	 * @return 角色列表
	 */
	@GetMapping("/comboData")
	public R comboData() {
		return R.createSuccessData(CollUtil.convertComboDataList(service.list(Wrappers.emptyWrapper()), Role.F_ID, Role.F_NAME));
	}

	/**
	 * 分页查询角色信息
	 *
	 * @param page 分页对象
	 * @return 分页对象
	 */
	@GetMapping("/")
	public R getRolePage(Page page) {
		return new R<>(service.page(page, Wrappers.emptyWrapper()));
	}

	/**
	 * 更新角色菜单
	 *
	 * @param roleId  角色ID
	 * @param menuIds 菜单ID拼成的字符串，每个id之间根据逗号分隔
	 * @return success、false
	 */
	@SysLog("更新角色菜单")
	@PutMapping("/menu")
	@PreAuthorize("@pms.hasPermission('sys_role_perm')")
	public R saveRoleMenus(String roleId, @RequestParam(value = "menuIds", required = false) String menuIds) {
		Role role = service.getById(roleId);
		return new R<>(roleMenuService.saveRoleMenus(role.getCode(), roleId, menuIds));
	}
}
