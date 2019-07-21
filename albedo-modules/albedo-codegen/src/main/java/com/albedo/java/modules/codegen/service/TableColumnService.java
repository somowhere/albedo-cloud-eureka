package com.albedo.java.modules.codegen.service;

import com.albedo.java.common.persistence.service.impl.DataVoServiceImpl;
import com.albedo.java.modules.codegen.domain.TableColumnEntity;
import com.albedo.java.modules.codegen.domain.vo.TableColumnVo;
import com.albedo.java.modules.codegen.repository.TableColumnRepository;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import java.util.List;
import java.util.stream.Collectors;

/**
 * Service class for managing tables.
 *
 * @author somewhere
 */
@Service
public class TableColumnService extends
	DataVoServiceImpl<TableColumnRepository, TableColumnEntity, String, TableColumnVo> {

    List<TableColumnEntity> findAllByGenTableIdOrderBySort(String id){
        return findAll(new QueryWrapper<TableColumnEntity>().eq(TableColumnEntity.F_GENTABLEID,id)
            .orderByAsc(TableColumnEntity.F_SORT));
    }


    public void deleteByTableId(String id, String currentAuditor) {
        List<TableColumnEntity> tableColumnEntityList = findAllByGenTableIdOrderBySort(id);
        Assert.notNull(tableColumnEntityList, "id " + id + " tableColumn 不能为空");
        super.deleteBatchIds(tableColumnEntityList.stream().map(item->item.getId()).collect(Collectors.toList()));

    }


}
