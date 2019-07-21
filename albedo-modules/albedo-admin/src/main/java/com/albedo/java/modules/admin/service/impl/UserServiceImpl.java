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

import cn.hutool.core.util.ArrayUtil;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.BeanVoUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.data.util.QueryWrapperUtil;
import com.albedo.java.common.persistence.service.impl.DataVoServiceImpl;
import com.albedo.java.modules.admin.vo.*;
import com.albedo.java.modules.admin.domain.*;
import com.albedo.java.modules.admin.repository.UserRepository;
import com.albedo.java.modules.admin.service.*;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.albedo.java.common.security.util.SecurityUtils;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
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
public class UserServiceImpl extends DataVoServiceImpl<UserRepository, UserEntity, String, UserDataVo> implements UserService {
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
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	@CacheEvict(value = "user_details", key = "#userDataVo.username")
	public void save(UserDataVo userDataVo) {
		UserEntity userEntity = StringUtil.isNotEmpty(userDataVo.getId()) ? baseMapper.selectById(userDataVo.getId()) : new UserEntity();
		if(StringUtil.isEmpty(userDataVo.getPassword())){
			userDataVo.setPassword(null);
		}
		BeanVoUtil.copyProperties(userDataVo, userEntity, true);
		if(StringUtil.isNotEmpty(userDataVo.getPassword())){
			userEntity.setPassword(ENCODER.encode(userDataVo.getPassword()));
		}
		super.saveOrUpdate(userEntity);
		userDataVo.setId(userEntity.getId());
		List<UserRoleEntity> userRoleEntityList = userDataVo.getRoleIdList()
			.stream().map(roleId -> {
				UserRoleEntity userRoleEntity = new UserRoleEntity();
				userRoleEntity.setUserId(userEntity.getId());
				userRoleEntity.setRoleId(roleId);
				return userRoleEntity;
			}).collect(Collectors.toList());
		userRoleService.removeRoleByUserId(userEntity.getId());
		userRoleService.saveBatch(userRoleEntityList);
	}

	/**
	 * 通过查用户的全部信息
	 *
	 * @param userEntity 用户
	 * @return
	 */
	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public UserInfo getUserInfo(UserEntity userEntity) {
		UserInfo userInfo = new UserInfo();
		userInfo.setUserEntity(userEntity);
		//设置角色列表  （ID）
		List<String> roleIds = roleService.listRolesByUserId(userEntity.getId())
			.stream()
			.map(RoleEntity::getId)
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
	 * @param pm    分页对象
	 * @return
	 */
	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public PageModel getUserWithRolePage(PageModel pm) {
		Wrapper wrapper = QueryWrapperUtil.getWrapperByPage(pm, getPersistentClass());
		pm.setDesc(UserEntity.F_SQL_CREATEDDATE);
		IPage<List<UserVo>> userVosPage = baseMapper.getUserVosPage(pm, wrapper);
		return (PageModel) userVosPage;
	}

	@Override
	public Boolean removeByIds(List<String> idList) {
		idList.stream().forEach(id->removeUserById(baseMapper.selectById(id)));
		return Boolean.TRUE;
	}

	/**
	 * 通过ID查询用户信息
	 *
	 * @param id 用户ID
	 * @return 用户信息
	 */
	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public UserVo getUserVoById(String id) {
		UserVo userVo = baseMapper.getUserVoById(id);
		return userVo;
	}

	/**
	 * 删除用户
	 *
	 * @param userEntity 用户
	 * @return Boolean
	 */
	@CacheEvict(value = "user_details", key = "#userEntity.username")
	public Boolean removeUserById(UserEntity userEntity) {
//		userRoleService.removeRoleByUserId(userEntity.getId());
		this.removeById(userEntity.getId());
		return Boolean.TRUE;
	}

	/**
	 * 查询上级部门的用户信息
	 *
	 * @param username 用户名
	 * @return R
	 */
	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public List<UserEntity> listAncestorUsersByUsername(String username) {
		UserEntity userEntity = this.getOne(Wrappers.<UserEntity>query().lambda()
			.eq(UserEntity::getUsername, username));

		DeptEntity deptEntity = sysDeptService.getById(userEntity.getDeptId());
		if (deptEntity == null) {
			return null;
		}

		String parentId = deptEntity.getParentId();
		return this.list(Wrappers.<UserEntity>query().lambda()
			.eq(UserEntity::getDeptId, parentId));
	}

	@Override
	public void lockOrUnLock(ArrayList<String> idList) {
		idList.forEach(id -> {
			UserEntity userEntity = baseMapper.selectById(id);
			userEntity.setLockFlag(CommonConstants.STR_YES.equals(userEntity.getLockFlag()) ? CommonConstants.STR_NO:CommonConstants.STR_YES);
			baseMapper.updateById(userEntity);
		});
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
			.list(Wrappers.<DeptRelationEntity>query().lambda()
				.eq(DeptRelationEntity::getAncestor, deptId))
			.stream()
			.map(DeptRelationEntity::getDescendant)
			.collect(Collectors.toList());
	}
}
