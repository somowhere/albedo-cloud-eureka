package com.albedo.java.modules.gen.controller;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.constant.SecurityConstants;
import com.albedo.java.common.core.util.ResponseBuilder;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.security.util.SecurityUtils;
import com.albedo.java.common.web.resource.DataVoResource;
import com.albedo.java.modules.gen.domain.vo.GenSchemeVo;
import com.albedo.java.modules.gen.domain.vo.GenTableVo;
import com.albedo.java.modules.gen.service.GenSchemeService;
import com.albedo.java.modules.gen.service.GenTableService;
import com.albedo.java.modules.sys.vo.GenSchemeDataVo;
import com.albedo.java.modules.sys.feign.RemoteMenuService;
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
@RequestMapping(value = "/gen/genScheme")
public class GenSchemeResource extends DataVoResource<GenSchemeService, GenSchemeVo> {

    private final GenTableService genTableService;

    private final RemoteMenuService remoteMenuService;

    public GenSchemeResource(GenSchemeService genSchemeService, GenTableService genTableService,
							 RemoteMenuService remoteMenuService) {
        super(genSchemeService);
        this.genTableService = genTableService;
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
//        JSON rs = JsonUtil.getInstance().setRecurrenceStr("genTable_name").toJsonObject(pm);
        return ResponseBuilder.buildObject(pm);
    }
    @GetMapping(value = "/formData")
    @Timed
    public ResponseEntity formData(GenSchemeVo genSchemeVo) {

		String username = SecurityUtils.getUser().getUsername();
        Map<String, Object> formData = service.findFormData(genSchemeVo, username);
        return ResponseBuilder.buildOk(formData);
    }

    @PostMapping(value = "/", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @Timed
    public ResponseEntity save(@Valid @RequestBody GenSchemeVo genSchemeVo) {
        service.save(genSchemeVo);
        GenTableVo genTableVo = genSchemeVo.getGenTable();
        if (genTableVo == null || StringUtil.isEmpty(genTableVo.getClassName())) {
            genTableVo = genTableService.findOneVo(genSchemeVo.getGenTableId());
        }
        if (genSchemeVo.getSyncModule()) {
            String url = StringUtil.toAppendStr("/", StringUtil.lowerCase(genSchemeVo.getModuleName()), (StringUtil.isNotBlank(genSchemeVo.getSubModuleName()) ? "/" + StringUtil.lowerCase(genSchemeVo.getSubModuleName()) : ""), "/",
                StringUtil.lowerFirst(genTableVo.getClassName()), "/");
			remoteMenuService.saveByGenScheme(
				new GenSchemeDataVo(genSchemeVo.getName(), genSchemeVo.getParentModuleId(), url), SecurityConstants.FROM_IN);
        }
        // 生成代码
        if (genSchemeVo.getGenCode()) {
            service.generateCode(genSchemeVo);
        }
        return ResponseBuilder.buildOk("保存", genSchemeVo.getName(), "成功");
    }

    @DeleteMapping(CommonConstants.URL_IDS_REGEX)
    @Timed
    public ResponseEntity delete(@PathVariable String ids) {
        log.debug("REST request to delete User: {}", ids);
        service.deleteBatchIds(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
        return ResponseBuilder.buildOk("删除成功");
    }


}
