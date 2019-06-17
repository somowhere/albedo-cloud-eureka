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

package com.albedo.java.modules.sys.vo;

import com.albedo.java.common.core.vo.DataEntityVo;
import com.albedo.java.modules.sys.entity.Role;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;

import java.util.List;

/**
 * @author lengleng
 * @date 2019/2/1
 */
@Data
public class UserVo  extends DataEntityVo<String> {

	public static final String F_USERNAME = "username";
	public static final String F_EMAIL = "email";
	/**
	 * 用户名
	 */
	private String username;

	private String password;
	/**
	 * 随机盐
	 */
	@JsonIgnore
	private String salt;

	/**
	 * 锁定标记
	 */
	private String lockFlag;

	/**
	 * 邮箱
	 */
	private String email;
	/**
	 * 电话
	 */
	private String phone;
	/**
	 * 头像
	 */
	private String avatar;

	/**
	 * 部门ID
	 */
	private String deptId;
	/**
	 * 部门ID
	 */
	private String deptName;

	/**
	 * 微信openid
	 */
	private String wxOpenid;

	/**
	 * QQ openid
	 */
	private String qqOpenid;

	/**
	 * 角色ID
	 */
	private List<Role> roleList;
}
