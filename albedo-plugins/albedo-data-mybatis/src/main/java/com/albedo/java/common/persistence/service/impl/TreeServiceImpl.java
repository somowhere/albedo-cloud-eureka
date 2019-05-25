package com.albedo.java.common.persistence.service.impl;

import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.TreeQuery;
import com.albedo.java.common.core.vo.TreeResult;
import com.albedo.java.common.persistence.domain.BaseEntity;
import com.albedo.java.common.persistence.domain.TreeEntity;
import com.albedo.java.common.persistence.repository.TreeRepository;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.toolkit.SqlHelper;
import com.google.common.collect.Lists;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.io.Serializable;
import java.util.List;


@Transactional
public abstract class TreeServiceImpl<Repository extends TreeRepository<T, PK>, T extends TreeEntity, PK extends Serializable>
    extends DataServiceImpl<Repository, T, PK> implements com.albedo.java.common.persistence.service.TreeService<Repository, T, PK> {


    @Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
    public T findTreeOne(Serializable id) {
        List<T> treeList = repository.findRelationList(
            new QueryWrapper<T>().eq(getClassNameProfix() + TreeEntity.F_SQL_ID, id));
        return SqlHelper.getObject(treeList);
    }

    @Override
	public Integer countByParentId(String parentId){
        return repository.selectCount(
            new QueryWrapper<T>().eq(TreeEntity.F_SQL_PARENTID, parentId)
        );
    }

    @Override
	public Integer countByParentIdAndStatusNot(String parentId, Integer status){
        return repository.selectCount(
            new QueryWrapper<T>().eq(TreeEntity.F_SQL_PARENTID, parentId).ne(TreeEntity.F_STATUS, status)
        );

    }

    @Override
	public List<T> findAllByParentIdsLike(String parentIds){
        return repository.findRelationList(
            new QueryWrapper<T>().like(getClassNameProfix()+TreeEntity.F_SQL_PARENTIDS, parentIds));
    }

    @Override
	public List<T> findAllByParentIdAndStatusNot(String parentId, Integer status){
        return repository.findRelationList(
            new QueryWrapper<T>().eq(getClassNameProfix()+TreeEntity.F_SQL_PARENTID, parentId).ne(getClassNameProfix()+TreeEntity.F_STATUS, status)
        );

    }

    @Override
	public List<T> findAllByStatusNot(Integer status){
        return repository.findRelationList(new QueryWrapper<T>().ne(getClassNameProfix()+TreeEntity.F_SQL_STATUS, status));

    }

    @Override
	public List<T> findTop1ByParentIdAndStatusNotOrderBySortDesc(String parentId, Integer status){

        return repository.findRelationList(
            new QueryWrapper<T>().eq(getClassNameProfix()+TreeEntity.F_SQL_PARENTID, parentId).ne(getClassNameProfix()+TreeEntity.F_SQL_STATUS, status)
        );

    }
    @Override
	public List<T> findAllByStatusOrderBySort(Integer status) {
        return repository.findRelationList(
            new QueryWrapper<T>().eq(getClassNameProfix()+TreeEntity.F_SQL_STATUS, status)
                .orderByAsc(getClassNameProfix()+TreeEntity.F_SQL_SORT)
        );
    }
    @Override
	public List<T> findAllByStatusNotOrderBySort(Integer status) {
        return repository.findRelationList(
            new QueryWrapper<T>().ne(getClassNameProfix()+TreeEntity.F_SQL_STATUS, status)
                .orderByAsc(getClassNameProfix()+TreeEntity.F_SQL_SORT)
        );
    }
    @Override
	public List<T> findAllByIdOrParentIdsLike(PK id, String likeParentIds){
        return repository.findRelationList(
            new QueryWrapper<T>().likeRight(getClassNameProfix()+TreeEntity.F_SQL_PARENTIDS, likeParentIds).or()
                .eq(getClassNameProfix()+TreeEntity.F_SQL_ID, id)
        );
    }
    /**
     * 逻辑删除
     *
     * @param id
     * @param likeParentIds
     * @return
     */
    @Override
	public int deleteById(PK id, String likeParentIds, String lastModifiedBy) {
        Assert.notNull(id, "ids 信息为空，操作失败");
        Assert.notNull(likeParentIds, "likeParentIds 信息为空，操作失败");
        Assert.notNull(lastModifiedBy, "lastModifiedBy 信息为空，操作失败");
        return operateStatusById(id, likeParentIds, BaseEntity.FLAG_DELETE, lastModifiedBy);
    }

    @Override
	public int operateStatusById(PK id, String likeParentIds, Integer status, String lastModifiedBy) {
        List<T> entityList = findAllByIdOrParentIdsLike(id, StringUtil.toAppendStr(likeParentIds, id, StringUtil.SPLIT_DEFAULT, "%"));
        Assert.notNull(id, "id 信息为空，操作失败");
        Assert.notNull(status, "status 信息为空，操作失败");
        Assert.notNull(lastModifiedBy, "lastModifiedBy 信息为空，操作失败");
        for (T entity : entityList) {
            if(BaseEntity.FLAG_DELETE.equals(status)){
                repository.deleteById(entity.getId());
            }else{
                entity.setStatus(status);
                repository.updateById(entity);
            }

        }
        return entityList!=null ? entityList.size() : 0;
    }


    @Override
    public boolean saveOrUpdate(T entity) {
        // 获取修改前的parentIds，用于更新子节点的parentIds
        String oldParentIds = entity.getParentIds();
        if (entity.getParentId() != null) {
            T parent = repository.selectById(entity.getParentId());
            if (parent != null && ObjectUtil.isNotEmpty(parent.getId())) {
                parent.setLeaf(false);
                super.updateById(parent);
                entity.setParentIds(StringUtil.toAppendStr(parent.getParentIds(), parent.getId(), StringUtil.SPLIT_DEFAULT));
            }
        }

        if (ObjectUtil.isNotEmpty(entity.getId())) {
            Integer count = countByParentId((String) entity.getId());
            entity.setLeaf(count == null || count == 0 ? true : false);
        } else {
            entity.setLeaf(true);
        }
//        checkSave(entity);
        boolean flag = super.saveOrUpdate(entity);
        // 更新子节点 parentIds
        List<T> list = findAllByParentIdsLike((String) entity.getId());
        for (T e : list) {
            if (StringUtil.isNotEmpty(e.getParentIds())) {
                e.setParentIds(e.getParentIds().replace(oldParentIds, entity.getParentIds()));
            }
        }
        if(ObjectUtil.isNotEmpty(list)){
            super.updateBatchById(list);
        }
        log.debug("Save Information for T: {}", entity);
        return flag;
    }

    @Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<TreeResult> findTreeData(TreeQuery query) {
        String extId = query != null ? query.getExtId() : null, all = query != null ? query.getAll() : null;
        List<TreeResult> mapList = Lists.newArrayList();
        List<T> list = findAllByStatusNot(BaseEntity.FLAG_DELETE);
        TreeResult treeResult = null;
        for (T e : list) {
            if ((StringUtil.isEmpty(extId)
                || StringUtil.isEmpty(e.getParentIds()) || (StringUtil.isNotEmpty(extId) && !extId.equals(e.getId()) && e.getParentIds() != null && e.getParentIds().indexOf(StringUtil.SPLIT_DEFAULT + extId + StringUtil.SPLIT_DEFAULT) == -1))
                && (all != null || (all == null && BaseEntity.FLAG_NORMAL.equals(e.getStatus())))) {
                treeResult = new TreeResult();
                treeResult.setId((String) e.getId());
                treeResult.setPid(StringUtil.isEmpty(e.getParentId()) ? "0" : e.getParentId());
                treeResult.setLabel(e.getName());
                treeResult.setKey(e.getName());
                treeResult.setValue((String) e.getId());
                mapList.add(treeResult);
            }
        }
        return mapList;
    }

    @Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
    public Integer countTopByParentId(String parentId) {
        return countByParentIdAndStatusNot(parentId, TreeEntity.FLAG_DELETE);
    }

    @Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
    public T findTopByParentId(String parentId) {
        List<T> tempList = findTop1ByParentIdAndStatusNotOrderBySortDesc(parentId, BaseEntity.FLAG_DELETE);
        return  SqlHelper.getObject(tempList);
    }

    /**
     * 逻辑删除，更新子节点
     *
     * @param ids
     * @param lastModifiedBy
     * @return
     */
    @Override
	public void deleteByParentIds(List<PK> ids, String lastModifiedBy) {
        Assert.notNull(ids, "ids 信息为空，操作失败");
        Assert.notNull(lastModifiedBy, "lastModifiedBy 信息为空，操作失败");
        ids.forEach(id ->deleteByParentIds(id, lastModifiedBy));
    }
    /**
     * 逻辑删除，更新子节点
     *
     * @param id
     * @param lastModifiedBy
     * @return
     */
    @Override
	public void deleteByParentIds(PK id, String lastModifiedBy) {
        Assert.notNull(id, "id 信息为空，操作失败");
        Assert.notNull(lastModifiedBy, "lastModifiedBy 信息为空，操作失败");
        T entity = repository.selectById(id);
        operateStatusById(id, entity.getParentIds(), BaseEntity.FLAG_DELETE, lastModifiedBy);
    }
    /**
     * 锁定/启用，更新子节点
     *
     * @param id
     * @param lastModifiedBy
     * @return
     */
    @Override
	public void lockOrUnLockByParentIds(PK id, String lastModifiedBy) {
        Assert.notNull(id, "id 信息为空，操作失败");
        Assert.notNull(lastModifiedBy, "lastModifiedBy 信息为空，操作失败");
        T entity = repository.selectById(id);
        Assert.notNull(entity, "对象 " + id + " 信息为空，操作失败");
        operateStatusById(id, entity.getParentIds(), BaseEntity.FLAG_NORMAL.equals(entity.getStatus()) ? BaseEntity.FLAG_UNABLE : BaseEntity.FLAG_NORMAL, lastModifiedBy);
        log.debug("LockOrUnLock Entity: {}", entity);
    }
    /**
     * 锁定/启用，更新子节点
     *
     * @param ids
     * @param lastModifiedBy
     * @return
     */
    @Override
	public void lockOrUnLockByParentIds(List<PK> ids, String lastModifiedBy) {
        Assert.notNull(ids, "ids 信息为空，操作失败");
        Assert.notNull(lastModifiedBy, "lastModifiedBy 信息为空，操作失败");
        ids.forEach(id -> lockOrUnLockByParentIds(id, lastModifiedBy));
    }


}
