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
import com.albedo.java.common.core.exception.RuntimeMsgException;
import com.albedo.java.common.core.util.ClassUtil;
import com.albedo.java.common.core.util.ResponseBuilder;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.web.resource.DataVoResource;
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
import com.codahale.metrics.annotation.Timed;
import com.google.common.collect.Lists;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Optional;

/**
 * @author somewhere
 * @date 2019/2/1
 */
@RestController
@RequestMapping("/sys/user")
@Log4j2
public class UserResource extends DataVoResource<UserService, UserDataVo> {


	public UserResource(UserService service) {
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
		return  R.createSuccessData(service.getUserVoById(id));
	}
	/**
	 * 获取当前用户全部信息
	 *
	 * @return 用户信息
	 */
	@GetMapping(value = {"/info"})
	public R info() {
		String username = SecurityUtils.getUser().getUsername();
		User user = service.getOne(Wrappers.<User>query()
			.lambda().eq(User::getUsername, username));
		if (user == null) {
			return new R<>(Boolean.FALSE, "获取当前用户信息失败");
		}
		return new R<>(service.getUserInfo(user));
	}

	/**
	 * 获取指定用户全部信息
	 *
	 * @return 用户信息
	 */
	@Inner
	@GetMapping("/info/{username}")
	public R info(@PathVariable String username) {
		User user = service.getOne(Wrappers.<User>query()
			.lambda().eq(User::getUsername, username));
		if (user == null) {
			return new R<>(Boolean.FALSE, String.format("用户信息为空 %s", username));
		}
		return new R<>(service.getUserInfo(user));
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
		return new R<>(service.getOne(new QueryWrapper<>(condition)));
	}

	/**
	 * 删除用户
	 *
	 * @param ids
	 * @return
	 */
	@SysLog("删除用户")
	@DeleteMapping(CommonConstants.URL_IDS_REGEX)
	public R removeByIds(@PathVariable String ids) {
		service.removeByIds(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
		return R.createSuccess("操作成功");
	}
	/**
	 * @param ids
	 * @return
	 */
	@PutMapping(CommonConstants.URL_IDS_REGEX)
	@SysLog("锁定/解锁用户")
	@PreAuthorize("@pms.hasPermission('sys_user_lock')")
	public R lockOrUnLock(@PathVariable String ids) {
		service.lockOrUnLock(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
		return R.createSuccess("操作成功");
	}
	/**
	 * 添加/更新用户信息
	 *
	 * @param userDataVo 用户信息
	 * @return R
	 */
	@SysLog("添加/更新用户信息")
	@PostMapping("/")
	@PreAuthorize("@pms.hasPermission('sys_user_edit')")
	public R saveUser(@Valid @RequestBody UserDataVo userDataVo) {
		log.debug("REST request to save userDataVo : {}", userDataVo);
		// beanValidatorAjax(user);
		if (StringUtil.isNotEmpty(userDataVo.getPassword()) &&
			!userDataVo.getPassword().equals(userDataVo.getConfirmPassword())) {
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
		service.save(userDataVo);
		return R.createSuccess("操作成功");
	}

	/**
	 * 分页查询用户
	 *
	 * @param pm    参数集
	 * @return 用户集合
	 */
	@GetMapping("/")
	public R getUserPage(PageModel pm) {
		return R.createSuccessData(service.getUserWithRolePage(pm));
	}

	/**
	 * @param username 用户名称
	 * @return 上级部门用户列表
	 */
	@GetMapping("/ancestor/{username}")
	public R listAncestorUsers(@PathVariable String username) {
		return new R<>(service.listAncestorUsersByUsername(username));
	}
}
