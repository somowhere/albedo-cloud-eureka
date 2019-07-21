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

package com.albedo.java.modules.admin.resource;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.modules.admin.domain.OauthClientDetails;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.albedo.java.modules.admin.service.OauthClientDetailsService;
import com.albedo.java.common.core.util.R;
import com.albedo.java.common.log.annotation.SysLog;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author somewhere
 * @since 2018-05-15
 */
@RestController
@AllArgsConstructor
@RequestMapping("/client")
public class OauthClientDetailsResource {
	private final OauthClientDetailsService oauthClientDetailsService;

	/**
	 * 通过ID查询
	 *
	 * @param id ID
	 * @return OauthClientDetails
	 */
	@GetMapping(CommonConstants.URL_ID_REGEX)
	public R getById(@PathVariable Integer id) {
		return new R<>(oauthClientDetailsService.getById(id));
	}


	/**
	 * 简单分页查询
	 *
	 * @param page                  分页对象
	 * @param oauthClientDetails 系统终端
	 * @return
	 */
	@GetMapping("/page")
	public R getOauthClientDetailsPage(Page page, OauthClientDetails oauthClientDetails) {
		return new R<>(oauthClientDetailsService.page(page, Wrappers.query(oauthClientDetails)));
	}

	/**
	 * 保存
	 *
	 * @param oauthClientDetails 实体
	 * @return success/false
	 */
	@SysLog("保存终端")
	@PostMapping
	@GetMapping("/")
	@PreAuthorize("@pms.hasPermission('sys_client_edit')")
	public R save(@Valid @RequestBody OauthClientDetails oauthClientDetails) {
		return new R<>(oauthClientDetailsService.saveOrUpdate(oauthClientDetails));
	}

	/**
	 * 删除
	 *
	 * @param id ID
	 * @return success/false
	 */
	@SysLog("删除终端")
	@DeleteMapping(CommonConstants.URL_IDS_REGEX)
	@PreAuthorize("@pms.hasPermission('sys_client_del')")
	public R removeById(@PathVariable String id) {
		return new R<>(oauthClientDetailsService.removeClientDetailsById(id));
	}

}
