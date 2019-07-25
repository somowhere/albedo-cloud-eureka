/**
 * Copyright &copy; 2018 <a href="https://github.com/somewhereMrli/albedo-boot">albedo-boot</a> All rights reserved.
 */
package com.albedo.java.modules.test.web;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.exception.RuntimeMsgException;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.core.vo.TreeQuery;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.web.resource.DataVoResource;
import com.albedo.java.common.core.util.R;
import com.albedo.java.common.log.annotation.SysLog;
import com.albedo.java.modules.test.domain.vo.TestBookDataVo;
import com.albedo.java.modules.test.service.TestBookService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.google.common.collect.Lists;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

/**
 * 测试书籍管Controller 测试书籍
 * @author admin
 * @version 2019-07-25 21:24:51
 */
@RestController
@RequestMapping(value = "/testBook")
public class TestBookResource extends DataVoResource<TestBookService, TestBookDataVo> {

    public TestBookResource(TestBookService service) {
        super(service);
    }

	/**
	 * @param id
	 * @return
	 */
	@GetMapping(CommonConstants.URL_ID_REGEX)
	@PreAuthorize("@pms.hasPermission('test_testBook_view')")
	public R get(@PathVariable String id) {
		log.debug("REST request to get Entity : {}", id);
		return  R.createSuccessData(service.findOneVo(id));
	}
	/**
	 * GET / : get all testBook.
	 *
	 * @param pm the pagination information
	 * @return the R with status 200 (OK) and with body all testBook
	 */

	@PreAuthorize("@pms.hasPermission('test_testBook_view')")
	@GetMapping("/")
	public R getPage(PageModel pm) {
		return R.createSuccessData(service.findPage(pm));
	}

	/**
	 * POST / : Save a testBookVo.
	 *
	 * @param testBookVo the HTTP testBook
	 */
	@PreAuthorize("@pms.hasPermission('test_testBook_edit')")
	@SysLog("新增/编辑测试书籍管")
	@PostMapping(value = "/", produces = MediaType.APPLICATION_JSON_VALUE)
	public R save(@Valid @RequestBody TestBookDataVo testBookVo) {
		log.debug("REST request to save TestBookForm : {}", testBookVo);
		TestBookDataVo testBookValidate = new TestBookDataVo();
		testBookValidate.setId(testBookVo.getId());
		testBookValidate.setName(testBookVo.getName());
		if (StringUtil.isNotEmpty(testBookVo.getName()) && !checkByProperty(testBookValidate)) {
			throw new RuntimeMsgException(StringUtil.toAppendStr("保存测试书籍'", testBookVo.getName(),"'失败，名称已存在"));
		}
		service.save(testBookVo);
		return R.createSuccess("保存测试书籍成功");

	}

	/**
	 * DELETE //:ids : delete the "ids" TestBook.
	 *
	 * @param ids the id of the testBook to delete
	 * @return the R with status 200 (OK)
	 */
	@PreAuthorize("@pms.hasPermission('test_testBook_del')")
	@SysLog("删除测试书籍管")
	@DeleteMapping(CommonConstants.URL_IDS_REGEX)
	public R delete(@PathVariable String ids) {
		log.debug("REST request to delete TestBook: {}", ids);
		service.deleteBatchIds(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
		return R.createSuccess("删除测试书籍成功");
	}
}