package com.albedo.java.modules.gen.service;

import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.core.vo.QueryCondition;
import com.albedo.java.common.persistence.DynamicSpecifications;
import com.albedo.java.common.persistence.SpecificationDetail;
import com.albedo.java.common.persistence.service.impl.DataVoServiceImpl;
import com.albedo.java.modules.gen.domain.GenTable;
import com.albedo.java.modules.gen.domain.GenTableColumn;
import com.albedo.java.modules.gen.domain.vo.*;
import com.albedo.java.modules.gen.domain.vo.GenTableColumnVo;
import com.albedo.java.modules.gen.domain.vo.GenTableVo;
import com.albedo.java.modules.gen.domain.xml.GenConfig;
import com.albedo.java.modules.gen.repository.GenTableRepository;
import com.albedo.java.modules.gen.util.GenUtil;
import com.albedo.java.modules.sys.entity.Dict;
import com.albedo.java.modules.sys.entity.User;
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
public class GenTableService extends
	DataVoServiceImpl<GenTableRepository, GenTable, String, GenTableVo> {

    @Autowired
    private GenTableColumnService genTableColumnService;

    @Override
    @Transactional(readOnly = true)
    public PageModel<GenTable> findPage(PageModel<GenTable> pm, List<QueryCondition> authQueryConditions) {
        //拼接查询动态对象
        SpecificationDetail<GenTable> spec = DynamicSpecifications.
                buildSpecification(pm.getQueryConditionJson(),
                        QueryCondition.ne(User.F_STATUS, User.FLAG_DELETE));
        spec.orAll(authQueryConditions);
        findPage(pm, spec);
        return pm;
    }


    @Override
    public boolean save(GenTable genTable) {
        boolean isNew = StringUtil.isEmpty(genTable.getId());
        boolean flag = super.save(genTable);
        log.debug("Save Information for GenTable: {}", genTable);
        if (isNew) {
            for (GenTableColumn item : genTable.getColumnFormList()) {
                item.setGenTableId(genTable.getId());
            }
        }else{
            List<GenTableColumn> genTableColumns = genTableColumnService.findAll(new QueryWrapper<GenTableColumn>().eq(GenTableColumn.F_SQL_GENTABLEID, genTable.getId()));
            for (GenTableColumn item : genTable.getColumnFormList()) {
                for (GenTableColumn genTableColumn : genTableColumns) {
                    if (genTableColumn.getId().equals(item.getId())) {
                        item.setVersion(genTableColumn.getVersion());
                        break;
                    }
                }
            }
        }

        genTableColumnService.saveOrUpdateBatch(genTable.getColumnFormList());

        return flag;
    }

    @Override
    public void copyVoToBean(GenTableVo form, GenTable genTable) {
        super.copyVoToBean(form, genTable);
        if (genTable != null) {
            if (ObjectUtil.isNotEmpty(form.getColumnFormList())) {
                genTable.setColumnFormList(form.getColumnFormList().stream()
                        .map(item -> genTableColumnService.copyVoToBean(item)).collect(Collectors.toList()));
            }
            if (ObjectUtil.isNotEmpty(form.getColumnList())) {
                genTable.setColumnList(form.getColumnList().stream()
                        .map(item -> genTableColumnService.copyVoToBean(item)).collect(Collectors.toList()));
            }
        }
    }

    @Override
    public void copyBeanToVo(GenTable genTable, GenTableVo result) {
        super.copyBeanToVo(genTable, result);
        if (genTable != null) {
            if (ObjectUtil.isNotEmpty(genTable.getColumnFormList())) {
                result.setColumnFormList(genTable.getColumnFormList().stream()
                        .map(item -> genTableColumnService.copyBeanToVo(item)).collect(Collectors.toList()));
            }
            if (ObjectUtil.isNotEmpty(genTable.getColumnList())) {
                result.setColumnList(genTable.getColumnList().stream()
                        .map(item -> genTableColumnService.copyBeanToVo(item)).collect(Collectors.toList()));
            }
        }
    }


    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<GenTable> findAll() {
        return findAll(DynamicSpecifications
                .bySearchQueryCondition(QueryCondition.ne(GenTable.F_STATUS, GenTable.FLAG_DELETE)));
    }


    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public boolean checkTableName(String tableName) {
        if (StringUtil.isBlank(tableName)) {
            return true;
        }
        List<GenTable> list = findAll(
                DynamicSpecifications.bySearchQueryCondition(QueryCondition.eq(GenTable.F_STATUS, GenTable.FLAG_NORMAL),
                        QueryCondition.eq(GenTable.F_NAME, tableName)));
        return list.size() == 0;
    }

    public GenTableVo getTableFormDb(GenTableVo genTableVo) {
        // 如果有表名，则获取物理表
        if (StringUtil.isNotBlank(genTableVo.getName())) {

            List<GenTableVo> list = findTableListFormDb(genTableVo);
            if (list.size() > 0) {

                // 如果是新增，初始化表属性
                if (ObjectUtil.isNotEmpty(genTableVo.getId())) {
                    genTableVo = list.get(0);
                    // 设置字段说明
                    if (StringUtil.isBlank(genTableVo.getComments())) {
                        genTableVo.setComments(genTableVo.getName());
                    }
                    genTableVo.setClassName(StringUtil.toCapitalizeCamelCase(genTableVo.getName()));
                }

                // 添加新列
                List<GenTableColumnVo> columnList = findTableColumnList(genTableVo);
                for (GenTableColumnVo column : columnList) {
                    boolean b = false;
                    for (GenTableColumnVo e : genTableVo.getColumnList()) {
                        if (e.getName().equals(column.getName())) {
                            b = true;
                            break;
                        }
                    }
                    if (!b) {
                        genTableVo.getColumnList().add(column);
                    }
                }
                // 删除已删除的列
                for (GenTableColumnVo e : genTableVo.getColumnList()) {
                    boolean b = false;
                    for (GenTableColumnVo column : columnList) {
                        if (column.getName().equals(e.getName())) {
                            b = true;
                        }
                    }
                    if (!b) {
                        e.setStatus(GenTableColumnVo.FLAG_DELETE);
                    }
                }

                // 获取主键
                genTableVo.setPkList(findTablePK(genTableVo));

                // 初始化列属性字段
                GenUtil.initColumnField(genTableVo);

            }
        }
        return genTableVo;
    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<String> findTablePK(GenTableVo genTableVo) {
        List<String> pkList = null;

        pkList = repository.findTablePK(genTableVo);
        return pkList;
    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<GenTableColumnVo> findTableColumnList(GenTableVo genTableVo) {
        List<String[]> GenString = null;
        List<GenTableColumnVo> list = null;
        list = repository.findTableColumnList(genTableVo);
		Assert.notNull(list, StringUtil.toAppendStr("无法获取[", genTableVo.getName(), "]表的列信息"));
        if (ObjectUtil.isNotEmpty(genTableVo.getId())) {
            Collections.sort(list);
        }
        return list;
    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<GenTableVo> findTableListFormDb(GenTableVo genTableVo) {
        List<GenTable> genTables = findAll();
        GenTableQuery genTableQuery = new GenTableQuery();
        if (genTableVo != null) {
            genTableQuery.setName(genTableVo.getName());
        }
        List<String> tempNames = Lists.newArrayList("gen_", "logging_",
//                "sys_",
                "jhi_");
        genTableQuery.setNotLikeNames(tempNames);
        if (ObjectUtil.isNotEmpty(genTables)) {
            genTableQuery.setNotNames(CollUtil.extractToList(genTables, GenTable.F_NAME));
        }
        List<GenTable> list = repository.findTableList(genTableQuery);
        return list.stream().map(item -> copyBeanToVo(item)).collect(Collectors.toList());
    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Map<String, Object> findFormData(GenTableFormVo genTableFormVo) {
        Map<String, Object> map = Maps.newHashMap();
        map.put("tableList", CollUtil.convertComboDataList(findTableListFormDb(new GenTableVo()), GenTable.F_NAME, GenTable.F_NAMESANDTITLE));
        // 验证参数缺失
        Assert.isTrue(StringUtil.isBlank(genTableFormVo.getId()) && StringUtil.isBlank(genTableFormVo.getName()),
			"参数缺失！");
        // 验证表是否存在
		Assert.isTrue(
			StringUtil.isBlank(genTableFormVo.getId()) && !checkTableName(genTableFormVo.getName()),
			StringUtil.toAppendStr("下一步失败！", genTableFormVo.getName(), " 表已经添加！"));
        GenTableVo genTableVo = new GenTableVo(genTableFormVo);
        if (ObjectUtil.isNotEmpty(genTableFormVo.getId())) {
            genTableVo = findOneVo(genTableFormVo.getId());
            genTableVo.setColumnList(genTableColumnService.findAll(new QueryWrapper<GenTableColumn>().eq(GenTableColumn.F_SQL_GENTABLEID, genTableFormVo.getId()))
                    .stream().map(item->genTableColumnService.copyBeanToVo(item)).collect(Collectors.toList())
            );
        }
        // 获取物理表字段
        genTableVo = getTableFormDb(genTableVo);
        map.put("columnList", CollUtil.convertComboDataList(genTableVo.getColumnList(),
                GenTable.F_NAME, GenTable.F_NAMESANDTITLE));


        map.put("genTableVo", genTableVo);
        GenConfig config = GenUtil.getConfig();
        map.put("config", config);

        map.put("queryTypeList", CollUtil.convertComboDataList(config.getQueryTypeList(), Dict.F_VAL, Dict.F_NAME));
        map.put("showTypeList", CollUtil.convertComboDataList(config.getShowTypeList(), Dict.F_VAL, Dict.F_NAME));
        map.put("javaTypeList", CollUtil.convertComboDataList(config.getJavaTypeList(), Dict.F_VAL, Dict.F_NAME));
        if (ObjectUtil.isNotEmpty(genTableVo.getId())) {
            Collections.sort(genTableVo.getColumnList());
        }

        return map;
    }

    public void delete(List<String> ids, String currentAuditor) {
        ids.forEach(id -> {
            GenTable entity = repository.selectById(id);
            Assert.notNull(entity, "对象 " + id + " 信息为空，删除失败");
            deleteById(id);
            genTableColumnService.deleteByTableId(id, currentAuditor);
            log.debug("Deleted GenTableVo: {}", entity);
        });
    }
}
