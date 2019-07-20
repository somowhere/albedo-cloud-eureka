package com.albedo.java.modules.gen.service;

import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.QueryCondition;
import com.albedo.java.common.persistence.DynamicSpecifications;
import com.albedo.java.common.persistence.SpecificationDetail;
import com.albedo.java.common.persistence.service.impl.DataVoServiceImpl;
import com.albedo.java.modules.gen.domain.Scheme;
import com.albedo.java.modules.gen.domain.Table;
import com.albedo.java.modules.gen.domain.TableColumn;
import com.albedo.java.modules.gen.domain.vo.SchemeVo;
import com.albedo.java.modules.gen.domain.vo.TableVo;
import com.albedo.java.modules.gen.domain.vo.TemplateVo;
import com.albedo.java.modules.gen.domain.xml.GenConfig;
import com.albedo.java.modules.gen.repository.SchemeRepository;
import com.albedo.java.modules.gen.repository.TableRepository;
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
public class SchemeService extends DataVoServiceImpl<SchemeRepository, Scheme, String, SchemeVo> {

    private final TableRepository tableRepository;
    private final TableService tableService;
    private final TableColumnService tableColumnService;

    public SchemeService(TableRepository tableRepository, TableService tableService, TableColumnService tableColumnService) {
        this.tableRepository = tableRepository;
        this.tableService = tableService;
        this.tableColumnService = tableColumnService;
    }

    public List<Scheme> findAll(String id) {
        SpecificationDetail specificationDetail = DynamicSpecifications.bySearchQueryCondition(
                QueryCondition.ne(Table.F_ID, id == null ? "-1" : id));
        return findAll(specificationDetail);
//		return repository.findAllByStatusAndId(TableVo.FLAG_NORMAL, id == null ? "-1" : id);
    }


    public String generateCode(SchemeVo schemeVo) {
        StringBuilder result = new StringBuilder();

        // 查询主表及字段列
		TableVo tableVo = tableService.findOneVo(schemeVo.getGenTableId());
		tableVo.setColumnList(tableColumnService.findAll(new QueryWrapper<TableColumn>().eq(TableColumn.F_SQL_GENTABLEID,
                tableVo.getId()))
                .stream().map(item-> tableColumnService.copyBeanToVo( item)).collect(Collectors.toList())
        );
        Collections.sort(tableVo.getColumnList());

        // 获取所有代码模板
        GenConfig config = GenUtil.getConfig();

        // 获取模板列表
        List<TemplateVo> templateList = GenUtil.getTemplateList(config, schemeVo.getCategory(), false);
        List<TemplateVo> childTableTemplateList = GenUtil.getTemplateList(config, schemeVo.getCategory(), true);

        // 如果有子表模板，则需要获取子表列表
        if (childTableTemplateList.size() > 0) {
            tableVo.setChildList(tableRepository.findAllByParentTable(tableVo.getId())
                    .stream().map(item -> tableService.copyBeanToVo(item)).collect(Collectors.toList()));
        }

        // 生成子表模板代码
        if (tableVo.getChildList() == null) {
            tableVo.setChildList(Lists.newArrayList());
        }
        for (TableVo childTable : tableVo.getChildList()) {
            Collections.sort(childTable.getColumnList());
            childTable.setCategory(schemeVo.getCategory());
            schemeVo.setGenTable(childTable);
            Map<String, Object> childTableModel = GenUtil.getDataModel(schemeVo);
            for (TemplateVo tpl : childTableTemplateList) {
                result.append(GenUtil.generateToFile(tpl, childTableModel, schemeVo.getReplaceFile()));
            }
        }
        tableVo.setCategory(schemeVo.getCategory());
        // 生成主表模板代码
        schemeVo.setGenTable(tableVo);
        Map<String, Object> model = GenUtil.getDataModel(schemeVo);
        for (TemplateVo tpl : templateList) {
            result.append(GenUtil.generateToFile(tpl, model, schemeVo.getReplaceFile()));
        }
        return result.toString();
    }

    public Map<String,Object> findFormData(SchemeVo schemeVo, String loginId) {
        Map<String, Object> map = Maps.newHashMap();
        if (StringUtil.isBlank(schemeVo.getPackageName())) {
            schemeVo.setPackageName("com.albedo.java.modules");
        }
        if (StringUtil.isBlank(schemeVo.getFunctionAuthor())) {
            schemeVo.setFunctionAuthor(loginId);
        }
        //同步模块数据
        schemeVo.setSyncModule(true);
        map.put("genSchemeVo", schemeVo);
        GenConfig config = GenUtil.getConfig();
        map.put("config", config);

        map.put("categoryList", CollUtil.convertComboDataList(config.getCategoryList(), Dict.F_VAL, Dict.F_NAME));
        map.put("viewTypeList", CollUtil.convertComboDataList(config.getViewTypeList(), Dict.F_VAL, Dict.F_NAME));

        List<Table> tableList = tableService.findAll(), list = Lists.newArrayList();
        List<Scheme> schemeList = findAll(schemeVo.getId());
        @SuppressWarnings("unchecked")
        List<String> tableIds = CollUtil.extractToList(schemeList, "genTableId");
        for (Table table : tableList) {
            if (!tableIds.contains(table.getId())) {
                list.add(table);
            }
        }
        map.put("tableList", CollUtil.convertComboDataList(list, Table.F_ID, Table.F_NAMESANDTITLE));
        return map;
    }
}
