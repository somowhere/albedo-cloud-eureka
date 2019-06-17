package com.albedo.java.common.persistence.service;

import com.albedo.java.common.core.vo.TreeQuery;
import com.albedo.java.common.core.vo.TreeResult;
import com.albedo.java.common.persistence.domain.TreeEntity;
import com.albedo.java.common.persistence.repository.TreeRepository;
import com.baomidou.mybatisplus.extension.service.IService;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.List;

public interface TreeService<Repository extends TreeRepository<T>, T extends TreeEntity> 
	extends IService<T>, BaseService<Repository, T, String>,
	DataService<Repository, T, String> {
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	T findTreeOne(Serializable id);

	Integer countByParentId(String parentId);

	Integer countByParentIdAndStatusNot(String parentId, Integer status);

	List<T> findAllByParentIdsLike(String parentIds);

	List<T> findAllByParentIdAndStatusNot(String parentId, Integer status);

	List<T> findAllByStatusNot(Integer status);

	List<T> findTop1ByParentIdAndStatusNotOrderBySortDesc(String parentId, Integer status);

	List<T> findAllByStatusOrderBySort(Integer status);

	List<T> findAllByStatusNotOrderBySort(Integer status);

	List<T> findAllByIdOrParentIdsLike(String id, String likeParentIds);

	int deleteById(String id, String likeParentIds, String lastModifiedBy);

	int operateStatusById(String id, String likeParentIds, Integer status, String lastModifiedBy);

	@Override
	boolean saveOrUpdate(T entity);

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	List<TreeResult> findTreeData(TreeQuery query);

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	Integer countTopByParentId(String parentId);

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	T findTopByParentId(String parentId);

	void deleteByParentIds(List<String> ids, String lastModifiedBy);

	void deleteByParentIds(String id, String lastModifiedBy);

	void lockOrUnLockByParentIds(String id, String lastModifiedBy);

	void lockOrUnLockByParentIds(List<String> ids, String lastModifiedBy);
}
