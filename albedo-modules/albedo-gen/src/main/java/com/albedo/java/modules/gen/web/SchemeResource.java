package com.albedo.java.modules.gen.web;

import cn.hutool.core.lang.Assert;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.constant.SecurityConstants;
import com.albedo.java.common.core.util.ResponseBuilder;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.security.util.SecurityUtils;
import com.albedo.java.common.web.resource.DataVoResource;
import com.albedo.java.modules.gen.domain.vo.GenCodeVo;
import com.albedo.java.modules.gen.domain.vo.SchemeDataVo;
import com.albedo.java.modules.gen.domain.vo.SchemeGenDataVo;
import com.albedo.java.modules.gen.domain.vo.TableDataVo;
import com.albedo.java.modules.gen.service.impl.SchemeServiceImpl;
import com.albedo.java.modules.gen.service.impl.TableServiceImpl;
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
 * @author somowhere
 */
@Controller
@RequestMapping(value = "/scheme")
public class SchemeResource extends DataVoResource<SchemeServiceImpl, SchemeDataVo> {

    private final TableServiceImpl tableService;

    private final RemoteMenuService remoteMenuService;

    public SchemeResource(SchemeServiceImpl schemeServiceImpl, TableServiceImpl tableService,
						  RemoteMenuService remoteMenuService) {
        super(schemeServiceImpl);
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
        return ResponseBuilder.buildOk(service.getSchemeVoPage(pm));
    }
    @GetMapping(value = "/form-data")
    @Timed
    public ResponseEntity formData(SchemeDataVo schemeDataVo) {
		String username = SecurityUtils.getUser().getUsername();
        Map<String, Object> formData = service.findFormData(schemeDataVo, username);
        return ResponseBuilder.buildOk(formData);
    }


	@PutMapping(value = "/gen-code")
	@Timed
	public ResponseEntity genCode(@Valid @RequestBody GenCodeVo genCodeVo) {
		SchemeDataVo genSchemeDataVo = service.findOneVo(genCodeVo.getId());
		Assert.isTrue(genSchemeDataVo !=null, "无法获取代码生成方案信息");
		genSchemeDataVo.setReplaceFile(genCodeVo.getReplaceFile());
		service.generateCode(genSchemeDataVo);
		return ResponseBuilder.buildOk("生成", genSchemeDataVo.getName(), "代码成功");
	}

    @PostMapping(value = "/", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @Timed
    public ResponseEntity save(@Valid @RequestBody SchemeDataVo schemeDataVo) {
        service.save(schemeDataVo);
        // 生成代码
        if (schemeDataVo.getGenCode()) {
            service.generateCode(schemeDataVo);
        }
        return ResponseBuilder.buildOk("保存", schemeDataVo.getName(), "成功");
    }

	@PostMapping(value = "/gen-menu", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@Timed
	public ResponseEntity genMenu(@Valid @RequestBody SchemeGenDataVo schemeGenDataVo) {
		SchemeDataVo schemeDataVo = service.findOneVo(schemeGenDataVo.getId());
		TableDataVo tableDataVo = schemeDataVo.getTableDataVo();
		if (tableDataVo == null) {
			tableDataVo = tableService.findOneVo(schemeDataVo.getTableId());
		}
		String url = StringUtil.toAppendStr("/", StringUtil.lowerCase(schemeDataVo.getModuleName()), (StringUtil.isNotBlank(schemeDataVo.getSubModuleName()) ? "/" + StringUtil.lowerCase(schemeDataVo.getSubModuleName()) : ""), "/",
			StringUtil.lowerFirst(tableDataVo.getClassName()), "/");
		remoteMenuService.saveByGenScheme(
			new GenSchemeDataVo(schemeDataVo.getName(), schemeGenDataVo.getParentMenuId(), url, tableDataVo.getClassName()), SecurityConstants.FROM_IN);
		return ResponseBuilder.buildOk("生成", schemeDataVo.getName(), "菜单成功");
	}


    @DeleteMapping(CommonConstants.URL_IDS_REGEX)
    @Timed
    public ResponseEntity delete(@PathVariable String ids) {
        log.debug("REST request to delete User: {}", ids);
        service.deleteBatchIds(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
        return ResponseBuilder.buildOk("删除成功");
    }


}
