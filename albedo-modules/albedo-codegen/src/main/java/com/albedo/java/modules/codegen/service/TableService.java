package com.albedo.java.modules.codegen.service;

import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.core.vo.QueryCondition;
import com.albedo.java.common.persistence.DynamicSpecifications;
import com.albedo.java.common.persistence.SpecificationDetail;
import com.albedo.java.common.persistence.service.impl.DataVoServiceImpl;
import com.albedo.java.modules.admin.domain.DictEntity;
import com.albedo.java.modules.codegen.domain.TableEntity;
import com.albedo.java.modules.codegen.domain.TableColumnEntity;
import com.albedo.java.modules.codegen.domain.vo.*;
import com.albedo.java.modules.codegen.domain.vo.TableColumnVo;
import com.albedo.java.modules.codegen.domain.vo.TableDataVo;
import com.albedo.java.modules.codegen.domain.xml.GenConfig;
import com.albedo.java.modules.codegen.repository.TableRepository;
import com.albedo.java.modules.codegen.util.GenUtil;
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
 * Service class for managing tables.
 *
 * @author somewhere
 */
@Service
public class TableService extends
	DataVoServiceImpl<TableRepository, TableEntity, String, TableDataVo> {

    @Autowired
    private TableColumnService tableColumnService;

    @Override
    @Transactional(readOnly = true)
    public PageModel<TableEntity> findPage(PageModel<TableEntity> pm, List<QueryCondition> authQueryConditions) {
        //拼接查询动态对象
        SpecificationDetail<TableEntity> spec = DynamicSpecifications.
                buildSpecification(pm.getQueryConditionJson());
        spec.orAll(authQueryConditions);
        findPage(pm, spec);
        return pm;
    }


    @Override
    public boolean save(TableEntity tableEntity) {
        boolean isNew = StringUtil.isEmpty(tableEntity.getId());
        boolean flag = super.save(tableEntity);
        log.debug("Save Information for TableEntity: {}", tableEntity);
        if (isNew) {
            for (TableColumnEntity item : tableEntity.getColumnFormList()) {
                item.setTableId(tableEntity.getId());
            }
        }else{
            List<TableColumnEntity> tableColumnEntities = tableColumnService.findAll(new QueryWrapper<TableColumnEntity>().eq(TableColumnEntity.F_SQL_GENTABLEID, tableEntity.getId()));
            for (TableColumnEntity item : tableEntity.getColumnFormList()) {
                for (TableColumnEntity tableColumnEntity : tableColumnEntities) {
                    if (tableColumnEntity.getId().equals(item.getId())) {
                        item.setVersion(tableColumnEntity.getVersion());
                        break;
                    }
                }
            }
        }

        tableColumnService.saveOrUpdateBatch(tableEntity.getColumnFormList());

        return flag;
    }

    @Override
    public void copyVoToBean(TableDataVo form, TableEntity tableEntity) {
        super.copyVoToBean(form, tableEntity);
        if (tableEntity != null) {
            if (ObjectUtil.isNotEmpty(form.getColumnFormList())) {
                tableEntity.setColumnFormList(form.getColumnFormList().stream()
                        .map(item -> tableColumnService.copyVoToBean(item)).collect(Collectors.toList()));
            }
            if (ObjectUtil.isNotEmpty(form.getColumnList())) {
                tableEntity.setColumnList(form.getColumnList().stream()
                        .map(item -> tableColumnService.copyVoToBean(item)).collect(Collectors.toList()));
            }
        }
    }

    @Override
    public void copyBeanToVo(TableEntity tableEntity, TableDataVo result) {
        super.copyBeanToVo(tableEntity, result);
        if (tableEntity != null) {
            if (ObjectUtil.isNotEmpty(tableEntity.getColumnFormList())) {
                result.setColumnFormList(tableEntity.getColumnFormList().stream()
                        .map(item -> tableColumnService.copyBeanToVo(item)).collect(Collectors.toList()));
            }
            if (ObjectUtil.isNotEmpty(tableEntity.getColumnList())) {
                result.setColumnList(tableEntity.getColumnList().stream()
                        .map(item -> tableColumnService.copyBeanToVo(item)).collect(Collectors.toList()));
            }
        }
    }




    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public boolean checkTableName(String tableName) {
        if (StringUtil.isBlank(tableName)) {
            return true;
        }
        List<TableEntity> list = findAll(
                DynamicSpecifications.bySearchQueryCondition(QueryCondition.eq(TableEntity.F_NAME, tableName)));
        return list.size() == 0;
    }

    public TableDataVo getTableFormDb(TableDataVo tableDataVo) {
        // 如果有表名，则获取物理表
        if (StringUtil.isNotBlank(tableDataVo.getName())) {

            List<TableDataVo> list = findTableListFormDb(tableDataVo);
            if (list.size() > 0) {

                // 如果是新增，初始化表属性
                if (ObjectUtil.isNotEmpty(tableDataVo.getId())) {
                    tableDataVo = list.get(0);
                    // 设置字段说明
                    if (StringUtil.isBlank(tableDataVo.getComments())) {
                        tableDataVo.setComments(tableDataVo.getName());
                    }
                    tableDataVo.setClassName(StringUtil.toCapitalizeCamelCase(tableDataVo.getName()));
                }

                // 添加新列
                List<TableColumnVo> columnList = findTableColumnList(tableDataVo);
                for (TableColumnVo column : columnList) {
                    boolean b = false;
                    for (TableColumnVo e : tableDataVo.getColumnList()) {
                        if (e.getName().equals(column.getName())) {
                            b = true;
                            break;
                        }
                    }
                    if (!b) {
                        tableDataVo.getColumnList().add(column);
                    }
                }
                // 删除已删除的列
                for (TableColumnVo e : tableDataVo.getColumnList()) {
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
                tableDataVo.setPkList(findTablePK(tableDataVo));

                // 初始化列属性字段
                GenUtil.initColumnField(tableDataVo);

            }
        }
        return tableDataVo;
    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<String> findTablePK(TableDataVo tableDataVo) {
        List<String> pkList = null;

        pkList = repository.findTablePK(tableDataVo);
        return pkList;
    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<TableColumnVo> findTableColumnList(TableDataVo tableDataVo) {
        List<String[]> GenString = null;
        List<TableColumnVo> list = null;
        list = repository.findTableColumnList(tableDataVo);
		Assert.notNull(list, StringUtil.toAppendStr("无法获取[", tableDataVo.getName(), "]表的列信息"));
        if (ObjectUtil.isNotEmpty(tableDataVo.getId())) {
            Collections.sort(list);
        }
        return list;
    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<TableDataVo> findTableListFormDb(TableDataVo tableDataVo) {
        List<TableEntity> tableEntities = findAll();
        TableQuery tableQuery = new TableQuery();
        if (tableDataVo != null) {
            tableQuery.setName(tableDataVo.getName());
        }
        List<String> tempNames = Lists.newArrayList("gen_");
        tableQuery.setNotLikeNames(tempNames);
        if (ObjectUtil.isNotEmpty(tableEntities)) {
            tableQuery.setNotNames(CollUtil.extractToList(tableEntities, TableEntity.F_NAME));
        }
        List<TableEntity> list = repository.findTableList(tableQuery);
        return list.stream().map(item -> copyBeanToVo(item)).collect(Collectors.toList());
    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Map<String, Object> findFormData(TableFormVo tableFormVo) {
        Map<String, Object> map = Maps.newHashMap();
        map.put("tableList", CollUtil.convertComboDataList(findTableListFormDb(new TableDataVo()), TableEntity.F_NAME, TableEntity.F_NAMESANDTITLE));
        // 验证参数缺失
        Assert.isTrue(StringUtil.isNotEmpty(tableFormVo.getId()) || StringUtil.isNotEmpty(tableFormVo.getName()),
			"参数缺失！");
        // 验证表是否存在
		Assert.isTrue(
			StringUtil.isNotEmpty(tableFormVo.getId()) || checkTableName(tableFormVo.getName()),
			StringUtil.toAppendStr("下一步失败！", tableFormVo.getName(), " 表已经添加！"));
        TableDataVo tableDataVo = new TableDataVo(tableFormVo);
        if (ObjectUtil.isNotEmpty(tableFormVo.getId())) {
            tableDataVo = findOneVo(tableFormVo.getId());
            tableDataVo.setColumnList(tableColumnService.findAll(new QueryWrapper<TableColumnEntity>().eq(TableColumnEntity.F_SQL_GENTABLEID, tableFormVo.getId()))
                    .stream().map(item-> tableColumnService.copyBeanToVo(item)).collect(Collectors.toList())
            );
        }
        // 获取物理表字段
        tableDataVo = getTableFormDb(tableDataVo);
        map.put("columnList", CollUtil.convertComboDataList(tableDataVo.getColumnList(),
                TableEntity.F_NAME, TableEntity.F_NAMESANDTITLE));


        map.put("tableVo", tableDataVo);
        GenConfig config = GenUtil.getConfig();
        map.put("config", config);

        map.put("queryTypeList", CollUtil.convertComboDataList(config.getQueryTypeList(), DictEntity.F_VAL, DictEntity.F_NAME));
        map.put("showTypeList", CollUtil.convertComboDataList(config.getShowTypeList(), DictEntity.F_VAL, DictEntity.F_NAME));
        map.put("javaTypeList", CollUtil.convertComboDataList(config.getJavaTypeList(), DictEntity.F_VAL, DictEntity.F_NAME));
        if (ObjectUtil.isNotEmpty(tableDataVo.getId())) {
            Collections.sort(tableDataVo.getColumnList());
        }

        return map;
    }

    public void delete(List<String> ids, String currentAuditor) {
        ids.forEach(id -> {
            TableEntity entity = repository.selectById(id);
            Assert.notNull(entity, "对象 " + id + " 信息为空，删除失败");
            deleteById(id);
            tableColumnService.deleteByTableId(id, currentAuditor);
            log.debug("Deleted TableDataVo: {}", entity);
        });
    }
}
