package com.albedo.java.modules.gen.repository;

import com.albedo.java.common.persistence.repository.BaseRepository;
import com.albedo.java.modules.gen.domain.Table;
import com.albedo.java.modules.gen.domain.vo.TableColumnVo;
import com.albedo.java.modules.gen.domain.vo.TableQuery;
import com.albedo.java.modules.gen.domain.vo.TableVo;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * Spring Data JPA repository for the Authority domain.
 */
public interface TableRepository extends BaseRepository<Table> {
    /**
     * 查询表列表
     *
     * @param tableQuery
     * @return
     */
    List<Table> findTableList(@Param("tableQuery") TableQuery tableQuery);

    /**
     * 获取数据表字段
     *
     * @param tableVo
     * @return
     */
	List<TableColumnVo> findTableColumnList(@Param("tableVo") TableVo tableVo);

    /**
     * 获取数据表主键
     *
     * @param tableVo
     * @return
     */
    List<String> findTablePK(@Param("tableVo") TableVo tableVo);

    List<Table> findAllByParentTable(String id);
}
