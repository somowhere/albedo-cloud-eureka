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


import com.albedo.java.common.core.vo.SelectResult;
import com.albedo.java.common.security.annotation.Inner;
import com.albedo.java.modules.sys.domain.Dict;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.albedo.java.modules.sys.service.DictService;
import com.albedo.java.common.core.util.R;
import com.albedo.java.common.log.annotation.SysLog;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * 字典表 前端控制器
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
@RestController
@AllArgsConstructor
@RequestMapping("/sys/dict")
public class DictController {
	private final DictService dictService;

	/**
	 * 通过ID查询字典信息
	 *
	 * @param id ID
	 * @return 字典信息
	 */
	@GetMapping("/{id}")
	public R getById(@PathVariable Integer id) {
		return new R<>(dictService.getById(id));
	}

	/**
	 * 分页查询字典信息
	 *
	 * @param page 分页对象
	 * @return 分页对象
	 */
	@GetMapping("/page")
	public R<IPage> getPage(Page page, Dict dict) {
		return new R<>(dictService.page(page, Wrappers.query(dict)));
	}

	/**
	 * 通过字典类型查找字典
	 * @param codes
	 * @return
	 */
	@ApiOperation(value = "获取字典数据", notes = "codes 不传获取所有的业务字典，多个用','隔开")
	@GetMapping(value = "/codes")
	public R getByCodes(String codes) {
		Map<String,List<SelectResult>> map = dictService.findCodes(codes);
		return new R<>(map);
	}


	/**
	 * 所有类型字典
	 *
	 * @return 所有类型字典
	 */
	@Inner
	@GetMapping("/all")
	@Cacheable(value = Dict.CACHE_DICT_DETAILS, key=Dict.CACHE_GET_DICT_ALL)
	public R getAll() {
		List<Dict> list = dictService.list(Wrappers
			.<Dict>query().lambda()
			.ne(Dict::getStatus, Dict.FLAG_DELETE));
		return new R<>(list);
	}


	/**
	 * 添加字典
	 *
	 * @param dict 字典信息
	 * @return success、false
	 */
	@SysLog("添加字典")
	@PostMapping
	@CacheEvict(value = Dict.CACHE_DICT_DETAILS, key = Dict.CACHE_GET_DICT_ALL)
	@PreAuthorize("@pms.hasPermission('sys_dict_add')")
	public R save(@Valid @RequestBody Dict dict) {
		return new R<>(dictService.save(dict));
	}

	/**
	 * 删除字典，并且清除字典缓存
	 *
	 * @param id   ID
	 * @param code 类型
	 * @return R
	 */
	@SysLog("删除字典")
	@DeleteMapping("/{id}/{code}")
	@CacheEvict(value = Dict.CACHE_DICT_DETAILS, key = Dict.CACHE_GET_DICT_ALL)
	@PreAuthorize("@pms.hasPermission('sys_dict_del')")
	public R removeById(@PathVariable Integer id, @PathVariable String code) {
		return new R<>(dictService.removeById(id));
	}

	/**
	 * 修改字典
	 *
	 * @param dict 字典信息
	 * @return success/false
	 */
	@PutMapping
	@SysLog("修改字典")
	@CacheEvict(value = Dict.CACHE_DICT_DETAILS, key = Dict.CACHE_GET_DICT_ALL)
	@PreAuthorize("@pms.hasPermission('sys_dict_edit')")
	public R updateById(@Valid @RequestBody Dict dict) {
		return new R<>(dictService.updateById(dict));
	}
}
