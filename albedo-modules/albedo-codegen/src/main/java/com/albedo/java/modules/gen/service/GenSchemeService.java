package com.albedo.java.modules.gen.service;

import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.QueryCondition;
import com.albedo.java.common.persistence.DynamicSpecifications;
import com.albedo.java.common.persistence.SpecificationDetail;
import com.albedo.java.common.persistence.service.impl.DataVoServiceImpl;
import com.albedo.java.modules.gen.domain.GenScheme;
import com.albedo.java.modules.gen.domain.GenTable;
import com.albedo.java.modules.gen.domain.GenTableColumn;
import com.albedo.java.modules.gen.domain.vo.GenSchemeVo;
import com.albedo.java.modules.gen.domain.vo.GenTableVo;
import com.albedo.java.modules.gen.domain.vo.GenTemplateVo;
import com.albedo.java.modules.gen.domain.xml.GenConfig;
import com.albedo.java.modules.gen.repository.GenSchemeRepository;
import com.albedo.java.modules.gen.repository.GenTableRepository;
import com.albedo.java.modules.gen.util.GenUtil;
import com.albedo.java.modules.sys.domain.Dict;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Service class for managing genSchemes.
 *
 * @author somewhere
 */
@Service
public class GenSchemeService extends DataVoServiceImpl<GenSchemeRepository, GenScheme, String, GenSchemeVo> {

    private final GenTableRepository genTableRepository;
    private final GenTableService genTableService;
    private final GenTableColumnService genTableColumnService;

    public GenSchemeService(GenTableRepository genTableRepository, GenTableService genTableService, GenTableColumnService genTableColumnService) {
        this.genTableRepository = genTableRepository;
        this.genTableService = genTableService;
        this.genTableColumnService = genTableColumnService;
    }

    public List<GenScheme> findAll(String id) {
        SpecificationDetail specificationDetail = DynamicSpecifications.bySearchQueryCondition(
                QueryCondition.ne(GenTable.F_ID, id == null ? "-1" : id));
        return findAll(specificationDetail);
//		return repository.findAllByStatusAndId(GenTableVo.FLAG_NORMAL, id == null ? "-1" : id);
    }


    public String generateCode(GenSchemeVo genSchemeVo) {
        StringBuilder result = new StringBuilder();

        // 查询主表及字段列
		GenTableVo genTableVo = genTableService.findOneVo(genSchemeVo.getGenTableId());
		genTableVo.setColumnList(genTableColumnService.findAll(new QueryWrapper<GenTableColumn>().eq(GenTableColumn.F_SQL_GENTABLEID,
                genTableVo.getId()))
                .stream().map(item->genTableColumnService.copyBeanToVo( item)).collect(Collectors.toList())
        );
        Collections.sort(genTableVo.getColumnList());

        // 获取所有代码模板
        GenConfig config = GenUtil.getConfig();

        // 获取模板列表
        List<GenTemplateVo> templateList = GenUtil.getTemplateList(config, genSchemeVo.getCategory(), false);
        List<GenTemplateVo> childTableTemplateList = GenUtil.getTemplateList(config, genSchemeVo.getCategory(), true);

        // 如果有子表模板，则需要获取子表列表
        if (childTableTemplateList.size() > 0) {
            genTableVo.setChildList(genTableRepository.findAllByParentTable(genTableVo.getId())
                    .stream().map(item -> genTableService.copyBeanToVo(item)).collect(Collectors.toList()));
        }

        // 生成子表模板代码
        if (genTableVo.getChildList() == null) {
            genTableVo.setChildList(Lists.newArrayList());
        }
        for (GenTableVo childTable : genTableVo.getChildList()) {
            Collections.sort(childTable.getColumnList());
            childTable.setCategory(genSchemeVo.getCategory());
            genSchemeVo.setGenTable(childTable);
            Map<String, Object> childTableModel = GenUtil.getDataModel(genSchemeVo);
            for (GenTemplateVo tpl : childTableTemplateList) {
                result.append(GenUtil.generateToFile(tpl, childTableModel, genSchemeVo.getReplaceFile()));
            }
        }
        genTableVo.setCategory(genSchemeVo.getCategory());
        // 生成主表模板代码
        genSchemeVo.setGenTable(genTableVo);
        Map<String, Object> model = GenUtil.getDataModel(genSchemeVo);
        for (GenTemplateVo tpl : templateList) {
            result.append(GenUtil.generateToFile(tpl, model, genSchemeVo.getReplaceFile()));
        }
        return result.toString();
    }

    public Map<String,Object> findFormData(GenSchemeVo genSchemeVo, String loginId) {
        Map<String, Object> map = Maps.newHashMap();
        if (StringUtil.isBlank(genSchemeVo.getPackageName())) {
            genSchemeVo.setPackageName("com.albedo.java.modules");
        }
        if (StringUtil.isBlank(genSchemeVo.getFunctionAuthor())) {
            genSchemeVo.setFunctionAuthor(loginId);
        }
        //同步模块数据
        genSchemeVo.setSyncModule(true);
        map.put("genSchemeVo", genSchemeVo);
        GenConfig config = GenUtil.getConfig();
        map.put("config", config);

        map.put("categoryList", CollUtil.convertComboDataList(config.getCategoryList(), Dict.F_VAL, Dict.F_NAME));
        map.put("viewTypeList", CollUtil.convertComboDataList(config.getViewTypeList(), Dict.F_VAL, Dict.F_NAME));

        List<GenTable> tableList = genTableService.findAll(), list = Lists.newArrayList();
        List<GenScheme> schemeList = findAll(genSchemeVo.getId());
        @SuppressWarnings("unchecked")
        List<String> tableIds = CollUtil.extractToList(schemeList, "genTableId");
        for (GenTable table : tableList) {
            if (!tableIds.contains(table.getId())) {
                list.add(table);
            }
        }
        map.put("tableList", CollUtil.convertComboDataList(list, GenTable.F_ID, GenTable.F_NAMESANDTITLE));
        return map;
    }
}
