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

import cn.hutool.core.util.ArrayUtil;
import cn.hutool.core.util.StrUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.persistence.service.impl.DataVoServiceImpl;
import com.albedo.java.modules.sys.vo.UserDataVo;
import com.albedo.java.modules.sys.vo.UserInfo;
import com.albedo.java.modules.sys.domain.*;
import com.albedo.java.modules.sys.repository.UserRepository;
import com.albedo.java.modules.sys.service.*;
import com.albedo.java.modules.sys.vo.MenuVo;
import com.albedo.java.modules.sys.vo.UserVo;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.albedo.java.common.core.util.R;
import com.albedo.java.common.security.util.SecurityUtils;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * @author somewhere
 * @date 2019/2/1
 */
@Slf4j
@Service
@AllArgsConstructor
public class UserServiceImpl extends DataVoServiceImpl<UserRepository, User, String, UserDataVo> implements UserService {
	private static final PasswordEncoder ENCODER = new BCryptPasswordEncoder();
	private final MenuService menuService;
	private final RoleService roleService;
	private final DeptService sysDeptService;
	private final UserRoleService userRoleService;
	private final DeptRelationService deptRelationService;

	/**
	 * 保存用户信息
	 *
	 * @param userDataVo DTO 对象
	 * @return success/fail
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	@CacheEvict(value = "user_details", key = "#userDataVo.username")
	public Boolean saveUser(UserDataVo userDataVo) {
		User user = StringUtil.isNotEmpty(userDataVo.getId()) ? baseMapper.selectById(userDataVo.getId()) : new User();
		BeanUtils.copyProperties(userDataVo, user);
		user.setPassword(ENCODER.encode(userDataVo.getPassword()));
		super.saveOrUpdate(user);
		List<UserRole> userRoleList = userDataVo.getRoleIdList()
			.stream().map(roleId -> {
				UserRole userRole = new UserRole();
				userRole.setUserId(user.getId());
				userRole.setRoleId(roleId);
				return userRole;
			}).collect(Collectors.toList());
		userRoleService.removeRoleByUserId(user.getId());
		return userRoleService.saveBatch(userRoleList);
	}

	/**
	 * 通过查用户的全部信息
	 *
	 * @param user 用户
	 * @return
	 */
	@Override
	public UserInfo getUserInfo(User user) {
		UserInfo userInfo = new UserInfo();
		userInfo.setUser(user);
		//设置角色列表  （ID）
		List<String> roleIds = roleService.listRolesByUserId(user.getId())
			.stream()
			.map(Role::getId)
			.collect(Collectors.toList());
		userInfo.setRoles(ArrayUtil.toArray(roleIds, String.class));

		//设置权限列表（menu.permission）
		Set<String> permissions = new HashSet<>();
		roleIds.forEach(roleId -> {
			List<String> permissionList = menuService.getMenuByRoleId(roleId)
				.stream()
				.filter(menuVo -> StringUtils.isNotEmpty(menuVo.getPermission()))
				.map(MenuVo::getPermission)
				.collect(Collectors.toList());
			permissions.addAll(permissionList);
		});
		userInfo.setPermissions(ArrayUtil.toArray(permissions, String.class));
		return userInfo;
	}

	/**
	 * 分页查询用户信息（含有角色信息）
	 *
	 * @param page    分页对象
	 * @param userDataVo 参数列表
	 * @return
	 */
	@Override
	public IPage getUserWithRolePage(Page page, UserDataVo userDataVo) {
		IPage<List<UserVo>> userVosPage = baseMapper.getUserVosPage(page, userDataVo);
		return userVosPage;
	}

	/**
	 * 通过ID查询用户信息
	 *
	 * @param id 用户ID
	 * @return 用户信息
	 */
	@Override
	public com.albedo.java.modules.sys.vo.UserVo getUserVoById(String id) {
		UserVo userVo = baseMapper.getUserVoById(id);
		return userVo;
	}

	/**
	 * 删除用户
	 *
	 * @param user 用户
	 * @return Boolean
	 */
	@Override
	@CacheEvict(value = "user_details", key = "#user.username")
	public Boolean removeUserById(User user) {
		userRoleService.removeRoleByUserId(user.getId());
		this.removeById(user.getId());
		return Boolean.TRUE;
	}

	@Override
	@CacheEvict(value = "user_details", key = "#userDataVo.username")
	public R<Boolean> updateUserInfo(UserDataVo userDataVo) {
		com.albedo.java.modules.sys.vo.UserVo userVO = baseMapper.getUserVoByUsername(userDataVo.getUsername());
		User user = new User();
		if (StrUtil.isNotBlank(userDataVo.getPassword())
			&& StrUtil.isNotBlank(userDataVo.getNewpassword1())) {
			if (ENCODER.matches(userDataVo.getPassword(), userVO.getPassword())) {
				user.setPassword(ENCODER.encode(userDataVo.getNewpassword1()));
			} else {
				log.warn("原密码错误，修改密码失败:{}", userDataVo.getUsername());
				return new R<>(Boolean.FALSE, "原密码错误，修改失败");
			}
		}
		user.setPhone(userDataVo.getPhone());
		user.setId(userVO.getId());
		user.setAvatar(userDataVo.getAvatar());
		return new R<>(this.updateById(user));
	}


	/**
	 * 查询上级部门的用户信息
	 *
	 * @param username 用户名
	 * @return R
	 */
	@Override
	public List<User> listAncestorUsersByUsername(String username) {
		User user = this.getOne(Wrappers.<User>query().lambda()
			.eq(User::getUsername, username));

		Dept dept = sysDeptService.getById(user.getDeptId());
		if (dept == null) {
			return null;
		}

		String parentId = dept.getParentId();
		return this.list(Wrappers.<User>query().lambda()
			.eq(User::getDeptId, parentId));
	}

	/**
	 * 获取当前用户的子部门信息
	 *
	 * @return 子部门列表
	 */
	private List<String> getChildDepts() {
		String deptId = SecurityUtils.getUser().getDeptId();
		//获取当前部门的子部门
		return deptRelationService
			.list(Wrappers.<DeptRelation>query().lambda()
				.eq(DeptRelation::getAncestor, deptId))
			.stream()
			.map(DeptRelation::getDescendant)
			.collect(Collectors.toList());
	}

}
