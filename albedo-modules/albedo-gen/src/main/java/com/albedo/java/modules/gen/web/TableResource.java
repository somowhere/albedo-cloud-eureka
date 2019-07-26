package com.albedo.java.modules.gen.web;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.ResponseBuilder;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.web.resource.DataVoResource;
import com.albedo.java.modules.gen.domain.Table;
import com.albedo.java.modules.gen.domain.vo.TableDataVo;
import com.albedo.java.modules.gen.domain.vo.TableFormVo;
import com.albedo.java.modules.gen.service.TableService;
import com.albedo.java.modules.gen.service.impl.TableServiceImpl;
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
public class TableResource extends DataVoResource<TableService, TableDataVo> {

    public TableResource(TableServiceImpl service) {
        super(service);
    }

    @GetMapping(value = "/table-list")
    @Timed
    public ResponseEntity tableList() {
        return ResponseBuilder.buildOk(CollUtil.convertSelectDataList(service.findTableListFormDb(null), Table.F_NAME, Table.F_NAMESANDTITLE));
    }

    @GetMapping(value = "/form-data")
    @Timed
    public ResponseEntity formData(TableFormVo tableVo) {
        Map<String, Object> map = service.findFormData(tableVo);
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
        return ResponseBuilder.buildOk(pm);
    }

    @PostMapping(value = "/", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity save(@Valid @RequestBody TableDataVo tableDataVo) {
        // 验证表是否已经存在
        if (StringUtil.isBlank(tableDataVo.getId()) && !service.checkTableName(tableDataVo.getName())) {
            return ResponseBuilder.buildFailed("保存失败！" + tableDataVo.getName() + " 表已经存在！");
        }
        service.save(tableDataVo);
        return ResponseBuilder.buildOk(StringUtil.toAppendStr("保存", tableDataVo.getName(), "成功"));
    }

    @DeleteMapping(CommonConstants.URL_IDS_REGEX)
    @Timed
    public ResponseEntity delete(@PathVariable String ids) {
        log.debug("REST request to delete table: {}", ids);
		service.deleteBatchIds(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
		return ResponseBuilder.buildOk("删除成功");
    }


}
