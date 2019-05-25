package com.albedo.java.modules.gen.controller;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.ResponseBuilder;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.web.resource.DataVoResource;
import com.albedo.java.modules.gen.domain.GenTable;
import com.albedo.java.modules.gen.domain.vo.GenTableFormVo;
import com.albedo.java.modules.gen.domain.vo.GenTableVo;
import com.albedo.java.modules.gen.service.GenTableService;
import com.albedo.java.modules.sys.util.JsonUtil;
import com.alibaba.fastjson.JSON;
import com.codahale.metrics.annotation.Timed;
import com.google.common.collect.Lists;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Map;

/**
 * 业务表Controller
 *
 * @author somewhere
 */
@Controller
@RequestMapping(value = "${application.adminPath}/gen/genTable")
public class GenTableResource extends DataVoResource<GenTableService, GenTableVo> {

    public GenTableResource(GenTableService service) {
        super(service);
    }

    @GetMapping(value = "/tableList")
    @Timed
    public ResponseEntity tableList() {
        return ResponseBuilder.buildOk(CollUtil.convertSelectDataList(service.findTableListFormDb(null), GenTable.F_NAME, GenTable.F_NAMESANDTITLE));
    }

    @GetMapping(value = "/formData")
    @Timed
    public ResponseEntity formData(GenTableFormVo genTableVo) {
        Map<String, Object> map = service.findFormData(genTableVo);
        return ResponseBuilder.buildOk(map);
    }


    /**
     * @param pm
     * @return
     */
    @GetMapping(value = "/")
    @Timed
    public ResponseEntity getPage(PageModel<GenTable> pm) {

        pm = service.findPage(pm);
        JSON rs = JsonUtil.getInstance().setRecurrenceStr("org_name").toJsonObject(pm);
        return ResponseBuilder.buildObject(rs);
    }

    @PostMapping(value = "/", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity save(@Valid @RequestBody GenTableVo genTableVo) {
        // 验证表是否已经存在
        if (StringUtil.isBlank(genTableVo.getId()) && !service.checkTableName(genTableVo.getName())) {
            return ResponseBuilder.buildFailed("保存失败！" + genTableVo.getName() + " 表已经存在！");
        }
        service.save(genTableVo);
        return ResponseBuilder.buildOk(StringUtil.toAppendStr("保存", genTableVo.getName(), "成功"));
    }

    @DeleteMapping(value = "/{ids:" + CommonConstants.LOGIN_REGEX + "}")
    @Timed
    public ResponseEntity delete(@PathVariable String ids) {
        log.debug("REST request to delete genTable: {}", ids);
		service.deleteBatchIds(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
		return ResponseBuilder.buildOk("删除成功");
    }

    @PutMapping(value = "/{ids:" + CommonConstants.LOGIN_REGEX + "}")
    @Timed
    public ResponseEntity lockOrUnLock(@PathVariable String ids) {
        log.debug("REST request to lockOrUnLock genTable: {}", ids);
        service.lockOrUnLock(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
        return ResponseBuilder.buildOk("操作成功");
    }

}
