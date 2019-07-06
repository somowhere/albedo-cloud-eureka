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
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.SelectResult;
import com.albedo.java.common.security.annotation.Inner;
import com.albedo.java.common.web.resource.TreeVoResource;
import com.albedo.java.modules.sys.domain.Dict;
import com.albedo.java.modules.sys.service.MenuService;
import com.albedo.java.modules.sys.vo.DictDataVo;
import com.albedo.java.modules.sys.vo.MenuDataVo;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.albedo.java.modules.sys.service.DictService;
import com.albedo.java.common.core.util.R;
import com.albedo.java.common.log.annotation.SysLog;
import com.google.common.collect.Lists;
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
@RequestMapping("/sys/dict")
public class DictResource extends TreeVoResource<DictService, DictDataVo> {

	public DictResource(DictService service) {
		super(service);
	}

	/**
	 * 分页查询字典信息
	 *
	 * @param page 分页对象
	 * @return 分页对象
	 */
	@GetMapping("/page")
	public R<IPage> getPage(Page page, Dict dict) {
		return new R<>(service.page(page, Wrappers.query(dict)));
	}

	/**
	 * 通过字典类型查找字典
	 * @param codes
	 * @return
	 */
	@ApiOperation(value = "获取字典数据", notes = "codes 不传获取所有的业务字典，多个用','隔开")
	@GetMapping(value = "/codes")
	public R getByCodes(String codes) {
		Map<String,List<SelectResult>> map = codes!=null ?
			service.findCodes(codes):service.findCodes();
		return new R<>(map);
	}

	/**
	 * 添加字典
	 *
	 * @param dict 字典信息
	 * @return success、false
	 */
	@SysLog("添加字典")
	@PostMapping
	@CacheEvict(value = Dict.CACHE_DICT_DETAILS, allEntries = true)
	@PreAuthorize("@pms.hasPermission('sys_dict_edit')")
	public R save(@Valid @RequestBody Dict dict) {
		return new R<>(service.save(dict));
	}

	/**
	 * 删除字典，并且清除字典缓存
	 *
	 * @param id   ID
	 * @return R
	 */
	@SysLog("删除字典")
	@DeleteMapping("/{id}")
	@CacheEvict(value = Dict.CACHE_DICT_DETAILS, allEntries = true)
	@PreAuthorize("@pms.hasPermission('sys_dict_del')")
	public R removeByIds(@PathVariable Integer id) {
		return new R<>(service.removeById(id));
	}


	/**
	 * @param ids
	 * @return
	 */
	@PutMapping(CommonConstants.URL_IDS_REGEX)
	@SysLog("锁定/解锁字典")
	@CacheEvict(value = Dict.CACHE_DICT_DETAILS, allEntries = true)
	@PreAuthorize("@pms.hasPermission('sys_user_lock')")
	public R lockOrUnLock(@PathVariable String ids) {
		service.lockOrUnLock(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
		return R.createSuccess("操作成功");
	}

}
