/**
 * Copyright &copy; 2018 <a href="https://github.com/somewhereMrli/albedo-boot">albedo-boot</a> All rights reserved.
 */
package com.albedo.java.modules.test.web;

import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.util.StringUtil;
import com.google.common.collect.Lists;
import com.albedo.java.modules.test.domain.vo.TestBookVo;
import com.albedo.java.modules.test.service.TestBookService;
import com.albedo.java.util.JsonUtil;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.domain.Globals;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.exception.RuntimeMsgException;
import com.albedo.java.web.rest.ResultBuilder;
import com.albedo.java.web.rest.base.DataVoResource;
import com.alibaba.fastjson.JSON;
import com.codahale.metrics.annotation.Timed;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import javax.validation.Valid;

/**
 * 测试书籍管理Controller 测试书籍管理
 * @author admin
 * @version 2019-07-23 21:19:31
 */
@Controller
@RequestMapping(value = "${application.adminPath}/test/testbook")
public class TestBookResource extends DataVoResource<TestBookService, TestBookVo> {

    public TestBookResource(TestBookService service) {
        super(service);
    }

	/**
	 * GET / : get all testbook.
	 *
	 * @param pm
	 *            the pagination information
	 * @return the ResponseEntity with status 200 (OK) and with body all testbook
	 */
	@GetMapping(value = "/")
	@Timed
	public ResponseEntity getPage(PageModel pm) {
	    service.findPage(pm, SecurityUtil.dataScopeFilter());
		JSON json = JsonUtil.getInstance().setRecurrenceStr().toJsonObject(pm);
		return ResultBuilder.buildObject(json);
	}

	/**
	 * POST / : Save a testbookVo.
	 *
	 * @param testbookVo the HTTP testbook
	 */
	@PostMapping(value = "/", produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public ResponseEntity save(@Valid @RequestBody TestBookVo testbookVo) {
		log.debug("REST request to save TestBookForm : {}", testbookVo);
		service.save(testbookVo);
		return ResultBuilder.buildOk("保存测试书籍管理成功");

	}

	/**
	 * DELETE //:id : delete the "id" TestBook.
	 *
	 * @param ids the id of the testbook to delete
	 * @return the ResponseEntity with status 200 (OK)
	 */
	@DeleteMapping(value = "/{ids:" + Globals.LOGIN_REGEX
			+ "}")
	@Timed
	public ResponseEntity delete(@PathVariable String ids) {
		log.debug("REST request to delete TestBook: {}", ids);
		service.deleteBatchIds(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
		return ResultBuilder.buildOk("删除测试书籍管理成功");
	}
}