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

import com.albedo.java.common.core.exception.RuntimeMsgException;
import com.albedo.java.common.core.util.ClassUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.modules.sys.vo.UserDataVo;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.modules.sys.vo.UserSearchVo;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.albedo.java.modules.sys.service.UserService;
import com.albedo.java.common.core.util.R;
import com.albedo.java.common.log.annotation.SysLog;
import com.albedo.java.common.security.annotation.Inner;
import com.albedo.java.common.security.util.SecurityUtils;
import com.google.common.collect.Lists;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

/**
 * @author somewhere
 * @date 2019/2/1
 */
@RestController
@AllArgsConstructor
@RequestMapping("${application.adminPath}/sys/user")
@Log4j2
public class UserController {
	private final UserService userService;

	/**
	 * 获取当前用户全部信息
	 *
	 * @return 用户信息
	 */
	@GetMapping(value = {"/info"})
	public R info() {
		String username = SecurityUtils.getUser().getUsername();
		User user = userService.getOne(Wrappers.<User>query()
			.lambda().eq(User::getUsername, username));
		if (user == null) {
			return new R<>(Boolean.FALSE, "获取当前用户信息失败");
		}
		return new R<>(userService.getUserInfo(user));
	}

	/**
	 * 获取指定用户全部信息
	 *
	 * @return 用户信息
	 */
	@Inner
	@GetMapping("/info/{username}")
	public R info(@PathVariable String username) {
		User user = userService.getOne(Wrappers.<User>query()
			.lambda().eq(User::getUsername, username));
		if (user == null) {
			return new R<>(Boolean.FALSE, String.format("用户信息为空 %s", username));
		}
		return new R<>(userService.getUserInfo(user));
	}

	/**
	 * 通过ID查询用户信息
	 *
	 * @param id ID
	 * @return 用户信息
	 */
	@GetMapping("/{id}")
	public R user(@PathVariable String id) {
		return R.createSuccessData(userService.getUserVoById(id));
	}

	/**
	 * 根据用户名查询用户信息
	 *
	 * @param username 用户名
	 * @return
	 */
	@GetMapping("/details/{username}")
	public R detailsUser(@PathVariable String username) {
		User condition = new User();
		condition.setUsername(username);
		return new R<>(userService.getOne(new QueryWrapper<>(condition)));
	}

	/**
	 * 删除用户信息
	 *
	 * @param id ID
	 * @return R
	 */
	@SysLog("删除用户信息")
	@DeleteMapping("/{id}")
	@PreAuthorize("@pms.hasPermission('sys_user_del')")
	public R userDel(@PathVariable String id) {
		User user = userService.getById(id);
		userService.removeUserById(user);
		return R.createSuccess("删除用户信息");
	}


	@GetMapping(value = "checkByProperty")
	public boolean checkByProperty(UserDataVo userDataVo) {
		return userService.doCheckByProperty(userDataVo);
	}


	/**
	 * 添加/更新用户信息
	 *
	 * @param userDataVo 用户信息
	 * @return R
	 */
	@SysLog("添加/更新用户信息")
	@PostMapping
	@PreAuthorize("@pms.hasPermission('sys_user_edit')")
	public R saveUser(@Valid @RequestBody UserDataVo userDataVo) {
		log.debug("REST request to save userDataVo : {}", userDataVo);
		// beanValidatorAjax(user);
		if (StringUtil.isNotEmpty(userDataVo.getPassword()) &&
			!userDataVo.getPassword().equals(userDataVo.getNewpassword1())) {
			throw new RuntimeMsgException("两次输入密码不一致");
		}
		// Lowercase the user login before comparing with database
		if (!checkByProperty(ClassUtil.createObj(UserDataVo.class,
			Lists.newArrayList(UserDataVo.F_ID, UserDataVo.F_USERNAME),
			userDataVo.getId(), userDataVo.getUsername()))) {
			throw new RuntimeMsgException("登录Id已存在");
		}
		if (StringUtil.isNotEmpty(userDataVo.getEmail()) &&
			!checkByProperty(ClassUtil.createObj(UserDataVo.class,
			Lists.newArrayList(UserDataVo.F_ID, UserDataVo.F_EMAIL), userDataVo.getId(), userDataVo.getEmail()))) {
			throw new RuntimeMsgException("邮箱已存在");
		}
		userService.save(userDataVo);
		return R.createSuccess("操作成功");
	}

	/**
	 * 分页查询用户
	 *
	 * @param page    参数集
	 * @param userDataVo 查询参数列表
	 * @return 用户集合
	 */
	@GetMapping("/page")
	public R getUserPage(Page page, UserSearchVo userDataVo) {
		return new R<>(userService.getUserWithRolePage(page, userDataVo));
	}

	/**
	 * 修改个人信息
	 *
	 * @param userDataVo userDataVo
	 * @return success/false
	 */
	@SysLog("修改个人信息")
	@PutMapping("/edit")
	public R updateUserInfo(@Valid @RequestBody UserDataVo userDataVo) {
		return userService.updateUserInfo(userDataVo);
	}

	/**
	 * @param username 用户名称
	 * @return 上级部门用户列表
	 */
	@GetMapping("/ancestor/{username}")
	public R listAncestorUsers(@PathVariable String username) {
		return new R<>(userService.listAncestorUsersByUsername(username));
	}
}
