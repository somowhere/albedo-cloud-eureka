package com.albedo.java.modules.gen.controller;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.ResponseBuilder;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.web.resource.DataVoResource;
import com.albedo.java.modules.gen.domain.Table;
import com.albedo.java.modules.gen.domain.vo.TableVo;
import com.albedo.java.modules.gen.domain.vo.TableFormVo;
import com.albedo.java.modules.gen.service.TableService;
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
@RequestMapping(value = "/table")
public class TableResource extends DataVoResource<TableService, TableVo> {

    public TableResource(TableService service) {
        super(service);
    }

    @GetMapping(value = "/tableList")
    @Timed
    public ResponseEntity tableList() {
        return ResponseBuilder.buildOk(CollUtil.convertSelectDataList(service.findTableListFormDb(null), Table.F_NAME, Table.F_NAMESANDTITLE));
    }

    @GetMapping(value = "/formData")
    @Timed
    public ResponseEntity formData(TableFormVo genTableVo) {
        Map<String, Object> map = service.findFormData(genTableVo);
        return ResponseBuilder.buildOk(map);
    }


    /**
     * @param pm
     * @return
     */
    @GetMapping(value = "/")
    @Timed
    public ResponseEntity getPage(PageModel pm) {
        pm = service.findPage(pm);
        return ResponseBuilder.buildObject(pm);
    }

    @PostMapping(value = "/", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity save(@Valid @RequestBody TableVo tableVo) {
        // 验证表是否已经存在
        if (StringUtil.isBlank(tableVo.getId()) && !service.checkTableName(tableVo.getName())) {
            return ResponseBuilder.buildFailed("保存失败！" + tableVo.getName() + " 表已经存在！");
        }
        service.save(tableVo);
        return ResponseBuilder.buildOk(StringUtil.toAppendStr("保存", tableVo.getName(), "成功"));
    }

    @DeleteMapping(CommonConstants.URL_IDS_REGEX)
    @Timed
    public ResponseEntity delete(@PathVariable String ids) {
        log.debug("REST request to delete table: {}", ids);
		service.deleteBatchIds(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
		return ResponseBuilder.buildOk("删除成功");
    }


}
