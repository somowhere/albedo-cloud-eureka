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
import com.albedo.java.common.security.util.SecurityUtils;
import com.albedo.java.common.web.resource.TreeVoResource;
import com.albedo.java.modules.sys.domain.Dept;
import com.albedo.java.modules.sys.service.DeptService;
import com.albedo.java.common.core.util.R;
import com.albedo.java.common.log.annotation.SysLog;
import com.albedo.java.modules.sys.service.DictService;
import com.albedo.java.modules.sys.vo.DeptDataVo;
import com.albedo.java.modules.sys.vo.DictDataVo;
import com.codahale.metrics.annotation.Timed;
import com.google.common.collect.Lists;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.time.LocalDateTime;

/**
 * <p>
 * 部门管理 前端控制器
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
@RestController
@RequestMapping("/sys/dept")
public class DeptResource extends TreeVoResource<DeptService, DeptDataVo> {

	public DeptResource(DeptService service) {
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
		return  R.createSuccessData(service.findOneVo(id));
	}
	/**
	 * 返回树形菜单集合
	 *
	 * @return 树形菜单
	 */
	@GetMapping(value = "/tree")
	public R listDeptTrees() {
		return new R<>(service.listDeptTrees());
	}

	/**
	 * 返回当前用户树形菜单集合
	 *
	 * @return 树形菜单
	 */
	@GetMapping(value = "/user-tree")
	public R listCurrentUserDeptTrees() {
		String deptId = SecurityUtils.getUser().getDeptId();
		return new R<>(service.listCurrentUserDeptTrees(deptId));
	}

	/**
	 * 添加
	 *
	 * @param dept 实体
	 * @return success/false
	 */
	@SysLog("添加部门")
	@PostMapping
	@PreAuthorize("@pms.hasPermission('sys_dept_edit')")
	public R save(@Valid @RequestBody Dept dept) {
		return new R<>(service.saveDept(dept));
	}

	/**
	 * 删除
	 *
	 * @param id ID
	 * @return success/false
	 */
	@SysLog("删除部门")
	@DeleteMapping(CommonConstants.URL_IDS_REGEX)
	@PreAuthorize("@pms.hasPermission('sys_dept_del')")
	public R removeById(@PathVariable Integer id) {
		return new R<>(service.removeDeptById(id));
	}

	/**
	 * @param ids
	 * @return
	 */
	@PutMapping(CommonConstants.URL_IDS_REGEX)
	@SysLog("锁定/解锁部门")
	@PreAuthorize("@pms.hasPermission('sys_user_lock')")
	public R lockOrUnLock(@PathVariable String ids) {
		service.lockOrUnLock(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
		return R.createSuccess("操作成功");
	}
}
