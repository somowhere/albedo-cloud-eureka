package com.albedo.java.modules.gen.service;

import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.core.vo.QueryCondition;
import com.albedo.java.common.persistence.DynamicSpecifications;
import com.albedo.java.common.persistence.SpecificationDetail;
import com.albedo.java.common.persistence.service.impl.DataVoServiceImpl;
import com.albedo.java.modules.gen.domain.Table;
import com.albedo.java.modules.gen.domain.TableColumn;
import com.albedo.java.modules.gen.domain.vo.*;
import com.albedo.java.modules.gen.domain.vo.TableColumnVo;
import com.albedo.java.modules.gen.domain.vo.TableVo;
import com.albedo.java.modules.gen.domain.xml.GenConfig;
import com.albedo.java.modules.gen.repository.TableRepository;
import com.albedo.java.modules.gen.util.GenUtil;
import com.albedo.java.modules.sys.domain.Dict;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Service class for managing genTables.
 *
 * @author somewhere
 */
@Service
public class TableService extends
	DataVoServiceImpl<TableRepository, Table, String, TableVo> {

    @Autowired
    private TableColumnService tableColumnService;

    @Override
    @Transactional(readOnly = true)
    public PageModel<Table> findPage(PageModel<Table> pm, List<QueryCondition> authQueryConditions) {
        //拼接查询动态对象
        SpecificationDetail<Table> spec = DynamicSpecifications.
                buildSpecification(pm.getQueryConditionJson());
        spec.orAll(authQueryConditions);
        findPage(pm, spec);
        return pm;
    }


    @Override
    public boolean save(Table table) {
        boolean isNew = StringUtil.isEmpty(table.getId());
        boolean flag = super.save(table);
        log.debug("Save Information for Table: {}", table);
        if (isNew) {
            for (TableColumn item : table.getColumnFormList()) {
                item.setGenTableId(table.getId());
            }
        }else{
            List<TableColumn> tableColumns = tableColumnService.findAll(new QueryWrapper<TableColumn>().eq(TableColumn.F_SQL_GENTABLEID, table.getId()));
            for (TableColumn item : table.getColumnFormList()) {
                for (TableColumn tableColumn : tableColumns) {
                    if (tableColumn.getId().equals(item.getId())) {
                        item.setVersion(tableColumn.getVersion());
                        break;
                    }
                }
            }
        }

        tableColumnService.saveOrUpdateBatch(table.getColumnFormList());

        return flag;
    }

    @Override
    public void copyVoToBean(TableVo form, Table table) {
        super.copyVoToBean(form, table);
        if (table != null) {
            if (ObjectUtil.isNotEmpty(form.getColumnFormList())) {
                table.setColumnFormList(form.getColumnFormList().stream()
                        .map(item -> tableColumnService.copyVoToBean(item)).collect(Collectors.toList()));
            }
            if (ObjectUtil.isNotEmpty(form.getColumnList())) {
                table.setColumnList(form.getColumnList().stream()
                        .map(item -> tableColumnService.copyVoToBean(item)).collect(Collectors.toList()));
            }
        }
    }

    @Override
    public void copyBeanToVo(Table table, TableVo result) {
        super.copyBeanToVo(table, result);
        if (table != null) {
            if (ObjectUtil.isNotEmpty(table.getColumnFormList())) {
                result.setColumnFormList(table.getColumnFormList().stream()
                        .map(item -> tableColumnService.copyBeanToVo(item)).collect(Collectors.toList()));
            }
            if (ObjectUtil.isNotEmpty(table.getColumnList())) {
                result.setColumnList(table.getColumnList().stream()
                        .map(item -> tableColumnService.copyBeanToVo(item)).collect(Collectors.toList()));
            }
        }
    }




    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public boolean checkTableName(String tableName) {
        if (StringUtil.isBlank(tableName)) {
            return true;
        }
        List<Table> list = findAll(
                DynamicSpecifications.bySearchQueryCondition(QueryCondition.eq(Table.F_NAME, tableName)));
        return list.size() == 0;
    }

    public TableVo getTableFormDb(TableVo tableVo) {
        // 如果有表名，则获取物理表
        if (StringUtil.isNotBlank(tableVo.getName())) {

            List<TableVo> list = findTableListFormDb(tableVo);
            if (list.size() > 0) {

                // 如果是新增，初始化表属性
                if (ObjectUtil.isNotEmpty(tableVo.getId())) {
                    tableVo = list.get(0);
                    // 设置字段说明
                    if (StringUtil.isBlank(tableVo.getComments())) {
                        tableVo.setComments(tableVo.getName());
                    }
                    tableVo.setClassName(StringUtil.toCapitalizeCamelCase(tableVo.getName()));
                }

                // 添加新列
                List<TableColumnVo> columnList = findTableColumnList(tableVo);
                for (TableColumnVo column : columnList) {
                    boolean b = false;
                    for (TableColumnVo e : tableVo.getColumnList()) {
                        if (e.getName().equals(column.getName())) {
                            b = true;
                            break;
                        }
                    }
                    if (!b) {
                        tableVo.getColumnList().add(column);
                    }
                }
                // 删除已删除的列
                for (TableColumnVo e : tableVo.getColumnList()) {
                    boolean b = false;
                    for (TableColumnVo column : columnList) {
                        if (column.getName().equals(e.getName())) {
                            b = true;
                        }
                    }
                    if (!b) {
                        e.setDelFlag(TableColumnVo.FLAG_DELETE);
                    }
                }

                // 获取主键
                tableVo.setPkList(findTablePK(tableVo));

                // 初始化列属性字段
                GenUtil.initColumnField(tableVo);

            }
        }
        return tableVo;
    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<String> findTablePK(TableVo tableVo) {
        List<String> pkList = null;

        pkList = repository.findTablePK(tableVo);
        return pkList;
    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<TableColumnVo> findTableColumnList(TableVo tableVo) {
        List<String[]> GenString = null;
        List<TableColumnVo> list = null;
        list = repository.findTableColumnList(tableVo);
		Assert.notNull(list, StringUtil.toAppendStr("无法获取[", tableVo.getName(), "]表的列信息"));
        if (ObjectUtil.isNotEmpty(tableVo.getId())) {
            Collections.sort(list);
        }
        return list;
    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<TableVo> findTableListFormDb(TableVo tableVo) {
        List<Table> tables = findAll();
        TableQuery tableQuery = new TableQuery();
        if (tableVo != null) {
            tableQuery.setName(tableVo.getName());
        }
        List<String> tempNames = Lists.newArrayList("gen_", "logging_",
//                "sys_",
                "jhi_");
        tableQuery.setNotLikeNames(tempNames);
        if (ObjectUtil.isNotEmpty(tables)) {
            tableQuery.setNotNames(CollUtil.extractToList(tables, Table.F_NAME));
        }
        List<Table> list = repository.findTableList(tableQuery);
        return list.stream().map(item -> copyBeanToVo(item)).collect(Collectors.toList());
    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Map<String, Object> findFormData(TableFormVo tableFormVo) {
        Map<String, Object> map = Maps.newHashMap();
        map.put("tableList", CollUtil.convertComboDataList(findTableListFormDb(new TableVo()), Table.F_NAME, Table.F_NAMESANDTITLE));
        // 验证参数缺失
        Assert.isTrue(StringUtil.isBlank(tableFormVo.getId()) && StringUtil.isBlank(tableFormVo.getName()),
			"参数缺失！");
        // 验证表是否存在
		Assert.isTrue(
			StringUtil.isBlank(tableFormVo.getId()) && !checkTableName(tableFormVo.getName()),
			StringUtil.toAppendStr("下一步失败！", tableFormVo.getName(), " 表已经添加！"));
        TableVo tableVo = new TableVo(tableFormVo);
        if (ObjectUtil.isNotEmpty(tableFormVo.getId())) {
            tableVo = findOneVo(tableFormVo.getId());
            tableVo.setColumnList(tableColumnService.findAll(new QueryWrapper<TableColumn>().eq(TableColumn.F_SQL_GENTABLEID, tableFormVo.getId()))
                    .stream().map(item-> tableColumnService.copyBeanToVo(item)).collect(Collectors.toList())
            );
        }
        // 获取物理表字段
        tableVo = getTableFormDb(tableVo);
        map.put("columnList", CollUtil.convertComboDataList(tableVo.getColumnList(),
                Table.F_NAME, Table.F_NAMESANDTITLE));


        map.put("genTableVo", tableVo);
        GenConfig config = GenUtil.getConfig();
        map.put("config", config);

        map.put("queryTypeList", CollUtil.convertComboDataList(config.getQueryTypeList(), Dict.F_VAL, Dict.F_NAME));
        map.put("showTypeList", CollUtil.convertComboDataList(config.getShowTypeList(), Dict.F_VAL, Dict.F_NAME));
        map.put("javaTypeList", CollUtil.convertComboDataList(config.getJavaTypeList(), Dict.F_VAL, Dict.F_NAME));
        if (ObjectUtil.isNotEmpty(tableVo.getId())) {
            Collections.sort(tableVo.getColumnList());
        }

        return map;
    }

    public void delete(List<String> ids, String currentAuditor) {
        ids.forEach(id -> {
            Table entity = repository.selectById(id);
            Assert.notNull(entity, "对象 " + id + " 信息为空，删除失败");
            deleteById(id);
            tableColumnService.deleteByTableId(id, currentAuditor);
            log.debug("Deleted TableVo: {}", entity);
        });
    }
}
