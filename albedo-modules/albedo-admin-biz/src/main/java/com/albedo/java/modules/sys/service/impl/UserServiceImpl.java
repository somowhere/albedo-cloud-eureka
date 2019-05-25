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
import com.albedo.java.modules.sys.dto.UserDTO;
import com.albedo.java.modules.sys.dto.UserInfo;
import com.albedo.java.modules.sys.entity.*;
import com.albedo.java.modules.sys.repository.UserRepository;
import com.albedo.java.modules.sys.service.*;
import com.albedo.java.modules.sys.vo.MenuVO;
import com.albedo.java.modules.sys.vo.UserVO;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.albedo.java.common.core.constant.CommonConstants;
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

import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * @author lengleng
 * @date 2019/2/1
 */
@Slf4j
@Service
@AllArgsConstructor
public class UserServiceImpl extends ServiceImpl<UserRepository, User> implements UserService {
	private static final PasswordEncoder ENCODER = new BCryptPasswordEncoder();
	private final MenuService menuService;
	private final RoleService roleService;
	private final DeptService sysDeptService;
	private final UserRoleService userRoleService;
	private final DeptRelationService deptRelationService;

	/**
	 * 保存用户信息
	 *
	 * @param userDto DTO 对象
	 * @return success/fail
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public Boolean saveUser(UserDTO userDto) {
		User user = new User();
		BeanUtils.copyProperties(userDto, user);
		user.setPassword(ENCODER.encode(userDto.getPassword()));
		baseMapper.insert(user);
		List<UserRole> userRoleList = userDto.getRole()
			.stream().map(roleId -> {
				UserRole userRole = new UserRole();
				userRole.setUserId(user.getId());
				userRole.setRoleId(roleId);
				return userRole;
			}).collect(Collectors.toList());
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
				.map(MenuVO::getPermission)
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
	 * @param userDTO 参数列表
	 * @return
	 */
	@Override
	public IPage getUserWithRolePage(Page page, UserDTO userDTO) {
		return baseMapper.getUserVosPage(page, userDTO);
	}

	/**
	 * 通过ID查询用户信息
	 *
	 * @param id 用户ID
	 * @return 用户信息
	 */
	@Override
	public UserVO getUserVoById(Integer id) {
		return baseMapper.getUserVoById(id);
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
	@CacheEvict(value = "user_details", key = "#userDto.username")
	public R<Boolean> updateUserInfo(UserDTO userDto) {
		UserVO userVO = baseMapper.getUserVoByUsername(userDto.getUsername());
		User user = new User();
		if (StrUtil.isNotBlank(userDto.getPassword())
			&& StrUtil.isNotBlank(userDto.getNewpassword1())) {
			if (ENCODER.matches(userDto.getPassword(), userVO.getPassword())) {
				user.setPassword(ENCODER.encode(userDto.getNewpassword1()));
			} else {
				log.warn("原密码错误，修改密码失败:{}", userDto.getUsername());
				return new R<>(Boolean.FALSE, "原密码错误，修改失败");
			}
		}
		user.setPhone(userDto.getPhone());
		user.setId(userVO.getId());
		user.setAvatar(userDto.getAvatar());
		return new R<>(this.updateById(user));
	}

	@Override
	@CacheEvict(value = "user_details", key = "#userDto.username")
	public Boolean updateUser(UserDTO userDto) {
		User user = new User();
		BeanUtils.copyProperties(userDto, user);
		user.setLastModifiedDate(LocalDateTime.now());

		if (StrUtil.isNotBlank(userDto.getPassword())) {
			user.setPassword(ENCODER.encode(userDto.getPassword()));
		}
		this.updateById(user);

		userRoleService.remove(Wrappers.<UserRole>update().lambda()
			.eq(UserRole::getUserId, userDto.getId()));
		userDto.getRole().forEach(roleId -> {
			UserRole userRole = new UserRole();
			userRole.setUserId(user.getId());
			userRole.setRoleId(roleId);
			userRole.insert();
		});
		return Boolean.TRUE;
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
