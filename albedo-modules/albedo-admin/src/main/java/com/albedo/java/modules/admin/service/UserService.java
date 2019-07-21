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

package com.albedo.java.modules.admin.service;

import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.persistence.service.DataVoService;
import com.albedo.java.modules.admin.domain.UserEntity;
import com.albedo.java.modules.admin.vo.UserDataVo;
import com.albedo.java.modules.admin.vo.UserInfo;
import com.albedo.java.modules.admin.repository.UserRepository;
import com.baomidou.mybatisplus.core.metadata.IPage;

import java.util.ArrayList;
import java.util.List;

/**
 * @author somewhere
 * @date 2019/2/1
 */
public interface UserService extends DataVoService<UserRepository, UserEntity, String, UserDataVo> {
	/**
	 * 查询用户信息
	 *
	 * @param userEntity 用户
	 * @return userInfo
	 */
	UserInfo getUserInfo(UserEntity userEntity);

	/**
	 * 分页查询用户信息（含有角色信息）
	 *
	 * @param pm    分页对象
	 * @return
	 */
	IPage getUserWithRolePage(PageModel pm);

	/**
	 * 删除用户
	 *
	 * @param idList 用户
	 * @return boolean
	 */
	Boolean removeByIds(List<String> idList);

	/**
	 * 通过ID查询用户信息
	 *
	 * @param id 用户ID
	 * @return 用户信息
	 */
	com.albedo.java.modules.admin.vo.UserVo getUserVoById(String id);

	/**
	 * 查询上级部门的用户信息
	 *
	 * @param username 用户名
	 * @return R
	 */
	List<UserEntity> listAncestorUsersByUsername(String username);

	void lockOrUnLock(ArrayList<String> newArrayList);
}
