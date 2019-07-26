/**
 * Copyright &copy; 2018 <a href="https://github.com/somewhereMrli/albedo-boot">albedo-boot</a> All rights reserved.
 */
package com.albedo.java.modules.test.web;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.exception.RuntimeMsgException;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.core.vo.TreeQuery;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.web.resource.TreeVoResource;
import com.albedo.java.common.core.util.R;
import com.albedo.java.common.log.annotation.SysLog;
import com.albedo.java.modules.test.domain.vo.TestTreeBookDataVo;
import com.albedo.java.modules.test.service.TestTreeBookService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.google.common.collect.Lists;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;


/**
 * 测试树书管Controller 测试树书
 * @author sys
 * @version 2019-07-25 21:24:22
 */
@RestController
@RequestMapping(value = "/testTreeBook")
public class TestTreeBookResource extends TreeVoResource<TestTreeBookService, TestTreeBookDataVo> {
    public TestTreeBookResource(TestTreeBookService service) {
        super(service);
    }
    /**
	 * GET / : 获取树型结构数据 测试树书.
	 *
	 * @param treeQuery
	 * @return the ResponseEntity with status 200 (OK) and with body all testTreeBook
	 */
	@GetMapping(value = "/tree")
	public R getTree(TreeQuery treeQuery) {
		return R.createSuccessData(service.listTrees(treeQuery));
	}
	/**
	 * GET / : 获取数据 测试树书.
	 *
	 * @param id
	 * @return
	 */
	@GetMapping(CommonConstants.URL_ID_REGEX)
	@PreAuthorize("@pms.hasPermission('test_testTreeBook_view')")
	public R get(@PathVariable String id) {
		log.debug("REST request to get Entity : {}", id);
		return R.createSuccessData(service.findOneVo(id));
	}
	/**
	 * GET / : 获取分页数据源 测试树书.
	 *
	 * @param pm the pagination information
	 * @return the ResponseEntity with status 200 (OK) and with body all testTreeBook
	 */
	@GetMapping("/")
	@PreAuthorize("@pms.hasPermission('test_testTreeBook_view')")
	public R<IPage> getPage(PageModel pm) {
		return R.createSuccessData(service.findRelationPage(pm));
	}

	/**
	 * POST / : 保存 a 测试树书Vo.
	 *
	 * @param {className}Vo
	 */
	@PreAuthorize("@pms.hasPermission('test_testTreeBook_edit')")
	@PostMapping(value = "/", produces = MediaType.APPLICATION_JSON_VALUE)
	@SysLog("新增/编辑测试树书管")
	public R save(@Valid @RequestBody TestTreeBookDataVo testTreeBookVo) {
		log.debug("REST request to save TestTreeBook : {}", testTreeBookVo);
		TestTreeBookDataVo testTreeBookValidate = new TestTreeBookDataVo();
		testTreeBookValidate.setId(testTreeBookVo.getId());
		testTreeBookValidate.setPhone(testTreeBookVo.getPhone());
		if (StringUtil.isNotEmpty(testTreeBookVo.getPhone()) && !checkByProperty(testTreeBookValidate)) {
			throw new RuntimeMsgException(StringUtil.toAppendStr("保存测试树书'", testTreeBookVo.getPhone(),"'失败，手机已存在"));
		}
		service.save(testTreeBookVo);
		return R.createSuccess("保存测试树书成功");
	}

	/**
	 * DELETE //:id : delete the "id" TestTreeBook.
	 *
	 * @param ids the id of the testTreeBook to delete
	 * @return the ResponseEntity with status 200 (OK)
	 */
	@PreAuthorize("@pms.hasPermission('test_testTreeBook_del')")
	@DeleteMapping(CommonConstants.URL_IDS_REGEX)
	@SysLog("删除测试树书管")
	public R delete(@PathVariable String ids) {
		log.debug("REST request to delete TestTreeBook: {}", ids);
		service.deleteByParentIds(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
		return R.createSuccess("删除测试树书成功");
	}

}
