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

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.modules.sys.domain.Log;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.albedo.java.modules.sys.service.LogService;
import com.albedo.java.common.core.util.R;
import com.albedo.java.common.security.annotation.Inner;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

/**
 * <p>
 * 日志表 前端控制器
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
@RestController
@AllArgsConstructor
@RequestMapping("/log")
public class LogResource {
	private final LogService logService;

	/**
	 * 简单分页查询
	 *
	 * @param pm   分页对象
	 * @return
	 */
	@GetMapping("/")
	public R<IPage> getPage(PageModel pm) {
		return R.createSuccessData(logService.findPage(pm));
	}

	/**
	 * 删除日志
	 *
	 * @param id ID
	 * @return success/false
	 */
	@DeleteMapping(CommonConstants.URL_IDS_REGEX)
	@PreAuthorize("@pms.hasPermission('sys_log_del')")
	public R removeById(@PathVariable long id) {
		return R.createSuccessData(logService.removeById(id));
	}

	/**
	 * 插入日志
	 *
	 * @param log 日志实体
	 * @return success/false
	 */
	@Inner
	@PostMapping("/")
	public R save(@Valid @RequestBody Log log) {
		return R.createSuccessData(logService.save(log));
	}

}
