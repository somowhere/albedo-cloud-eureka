package com.albedo.java.modules.codegen.controller;

import cn.hutool.core.lang.Assert;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.constant.SecurityConstants;
import com.albedo.java.common.core.util.ResponseBuilder;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.security.util.SecurityUtils;
import com.albedo.java.common.web.resource.DataVoResource;
import com.albedo.java.modules.codegen.domain.vo.GenCodeVo;
import com.albedo.java.modules.codegen.domain.vo.SchemeVo;
import com.albedo.java.modules.codegen.domain.vo.TableDataVo;
import com.albedo.java.modules.codegen.service.SchemeService;
import com.albedo.java.modules.codegen.service.TableService;
import com.albedo.java.modules.admin.vo.GenSchemeDataVo;
import com.albedo.java.modules.admin.feign.RemoteMenuService;
import com.codahale.metrics.annotation.Timed;
import com.google.common.collect.Lists;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Map;

/**
 * 生成方案Controller
 *
 * @author somewhere
 */
@Controller
@RequestMapping(value = "/scheme")
public class SchemeResource extends DataVoResource<SchemeService, SchemeVo> {

    private final TableService tableService;

    private final RemoteMenuService remoteMenuService;

    public SchemeResource(SchemeService schemeService, TableService tableService,
						  RemoteMenuService remoteMenuService) {
        super(schemeService);
        this.tableService = tableService;
        this.remoteMenuService = remoteMenuService;
    }

    /**
     * @param pm
     * @return
     */
    @GetMapping(value = "/")
    @Timed
    public ResponseEntity getPage(PageModel pm) {
        service.findPage(pm);
        return ResponseBuilder.buildOk(pm);
    }
    @GetMapping(value = "/formData")
    @Timed
    public ResponseEntity formData(SchemeVo schemeVo) {

		String username = SecurityUtils.getUser().getUsername();
        Map<String, Object> formData = service.findFormData(schemeVo, username);
        return ResponseBuilder.buildOk(formData);
    }


	@PutMapping(value = "/genCode")
	@Timed
	public ResponseEntity genCode(@Valid @RequestBody GenCodeVo genCodeVo) {
		SchemeVo genSchemeVo = service.findOneVo(genCodeVo.getId());
		Assert.isTrue(genSchemeVo!=null, "无法获取代码生成方案信息");
		genSchemeVo.setReplaceFile(genCodeVo.getReplaceFile());
		service.generateCode(genSchemeVo);
		return ResponseBuilder.buildOk("操作成功");
	}

    @PostMapping(value = "/", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @Timed
    public ResponseEntity save(@Valid @RequestBody SchemeVo schemeVo) {
        service.save(schemeVo);
        TableDataVo tableDataVo = schemeVo.getTableDataVo();
        if (tableDataVo == null || StringUtil.isEmpty(tableDataVo.getClassName())) {
            tableDataVo = tableService.findOneVo(schemeVo.getTableId());
        }
        if (schemeVo.getSyncModule()) {
            String url = StringUtil.toAppendStr("/", StringUtil.lowerCase(schemeVo.getModuleName()), (StringUtil.isNotBlank(schemeVo.getSubModuleName()) ? "/" + StringUtil.lowerCase(schemeVo.getSubModuleName()) : ""), "/",
                StringUtil.lowerFirst(tableDataVo.getClassName()), "/");
			remoteMenuService.saveByGenScheme(
				new GenSchemeDataVo(schemeVo.getName(), schemeVo.getParentModuleId(), url), SecurityConstants.FROM_IN);
        }
        // 生成代码
        if (schemeVo.getGenCode()) {
            service.generateCode(schemeVo);
        }
        return ResponseBuilder.buildOk("保存", schemeVo.getName(), "成功");
    }

    @DeleteMapping(CommonConstants.URL_IDS_REGEX)
    @Timed
    public ResponseEntity delete(@PathVariable String ids) {
        log.debug("REST request to delete User: {}", ids);
        service.deleteBatchIds(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
        return ResponseBuilder.buildOk("删除成功");
    }


}
