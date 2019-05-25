package com.albedo.java.modules.gen.service;

import com.albedo.java.common.persistence.service.impl.DataVoServiceImpl;
import com.albedo.java.modules.gen.domain.GenTableColumn;
import com.albedo.java.modules.gen.domain.vo.GenTableColumnVo;
import com.albedo.java.modules.gen.repository.GenTableColumnRepository;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import java.util.List;
import java.util.stream.Collectors;

/**
 * Service class for managing genTables.
 *
 * @author somewhere
 */
@Service
public class GenTableColumnService extends
	DataVoServiceImpl<GenTableColumnRepository, GenTableColumn, String, GenTableColumnVo> {

    List<GenTableColumn> findAllByGenTableIdOrderBySort(String id){
        return findAll(new QueryWrapper<GenTableColumn>().eq(GenTableColumn.F_GENTABLEID,id)
            .orderByAsc(GenTableColumn.F_SORT));
    }


    public void deleteByTableId(String id, String currentAuditor) {
        List<GenTableColumn> genTableColumnList = findAllByGenTableIdOrderBySort(id);
        Assert.notNull(genTableColumnList, "id " + id + " genTableColumn 不能为空");
        super.deleteBatchIds(genTableColumnList.stream().map(item->item.getId()).collect(Collectors.toList()));

    }


}
