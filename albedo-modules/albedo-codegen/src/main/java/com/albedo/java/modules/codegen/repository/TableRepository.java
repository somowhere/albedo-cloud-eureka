package com.albedo.java.modules.codegen.repository;

import com.albedo.java.common.persistence.repository.BaseRepository;
import com.albedo.java.modules.codegen.domain.TableEntity;
import com.albedo.java.modules.codegen.domain.vo.TableColumnVo;
import com.albedo.java.modules.codegen.domain.vo.TableQuery;
import com.albedo.java.modules.codegen.domain.vo.TableDataVo;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * Spring Data JPA repository for the Authority domain.
 */
public interface TableRepository extends BaseRepository<TableEntity> {
    /**
     * 查询表列表
     *
     * @param tableQuery
     * @return
     */
    List<TableEntity> findTableList(@Param("tableQuery") TableQuery tableQuery);

    /**
     * 获取数据表字段
     *
     * @param tableDataVo
     * @return
     */
	List<TableColumnVo> findTableColumnList(@Param("tableDataVo") TableDataVo tableDataVo);

    /**
     * 获取数据表主键
     *
     * @param tableDataVo
     * @return
     */
    List<String> findTablePK(@Param("tableDataVo") TableDataVo tableDataVo);

    List<TableEntity> findAllByParentTable(String id);
}
