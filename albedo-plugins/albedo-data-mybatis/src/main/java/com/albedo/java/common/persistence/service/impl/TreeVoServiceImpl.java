package com.albedo.java.common.persistence.service.impl;

import com.albedo.java.common.core.util.BeanVoUtil;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.TreeEntityVo;
import com.albedo.java.common.core.vo.TreeNode;
import com.albedo.java.common.core.vo.TreeUtil;
import com.albedo.java.common.persistence.domain.BaseEntity;
import com.albedo.java.common.persistence.domain.TreeEntity;
import com.albedo.java.common.persistence.repository.TreeRepository;
import com.albedo.java.common.persistence.service.TreeVoService;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.Data;
import org.springframework.transaction.annotation.Transactional;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;


/**
 * @author somewhere
 */
@Data
public class TreeVoServiceImpl<Repository extends TreeRepository<T>,
        T extends TreeEntity, V extends TreeEntityVo>
        extends TreeServiceImpl<Repository, T> implements TreeVoService<Repository, T, V> {

    private Class<V> entityVoClz;

    public TreeVoServiceImpl() {
        super();
        Class<?> c = getClass();
        Type type = c.getGenericSuperclass();
        if (type instanceof ParameterizedType) {
            Type[] parameterizedType = ((ParameterizedType) type).getActualTypeArguments();
            entityVoClz = (Class<V>) parameterizedType[2];
        }
    }

    @Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
    public V findOneVo(String id) {
        return copyBeanToVo(findTreeOne(id));
    }

    @Override
	public boolean doCheckByProperty(V entityForm) {
        T entity = copyVoToBean(entityForm);
        return super.doCheckByProperty(entity);
    }

    @Override
	public boolean doCheckByPK(V entityForm) {
        T entity = copyVoToBean(entityForm);
        return super.doCheckByPK(entity);
    }

    @Override
	public void copyBeanToVo(T module, V result) {
        if (result != null && module != null) {
			BeanVoUtil.copyProperties(module, result, true);
            if (module.getParent() != null) {
                result.setParentName(module.getParent().getName());
            }
        }
    }

    @Override
	public V copyBeanToVo(T module) {
        V result = null;
        if (module != null) {
            try {
                result = entityVoClz.newInstance();
                copyBeanToVo(module, result);
            } catch (Exception e) {
                log.error("{}", e);
            }
        }
        return result;
    }

    @Override
	public void copyVoToBean(V form, T entity) {
        if (form != null && entity != null) {
            BeanVoUtil.copyProperties(form, entity, true);
        }
    }

    @Override
	public T copyVoToBean(V form) {
        T result = null;
        if (form != null && getPersistentClass() != null) {
            try {
                result = getPersistentClass().newInstance();
                copyVoToBean(form, result);
            } catch (Exception e) {
                log.error("{}", e);
            }
        }
        return result;
    }


    @Override
	public V save(V form) {
        T entity = null;
        try {
            entity = StringUtil.isNotEmpty(form.getId()) ? repository.selectById(form.getId()) :
                    getPersistentClass().newInstance();
            copyVoToBean(form, entity);
        } catch (Exception e) {
            log.warn("{}", e);
        }
        saveOrUpdate(entity);
        form.setId( entity.getId());
        return form;
    }

    @Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<V> findAllVoByParentId(String parentId) {
        return super.findAllByParentId(parentId).stream()
                .map(item -> copyBeanToVo(item))
                .collect(Collectors.toList());
    }

    @Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
    public Optional<V> findOptionalTopByParentId(String parentId) {
        List<T> tempList = super.findTop1ByParentIdOrderBySortDesc(parentId);
        if(CollUtil.isNotEmpty(tempList)){
            T entity = tempList.get(0);
            entity.setParent(repository.selectById(entity.getParentId()));
            return Optional.of(copyBeanToVo(entity));
        }
        return  Optional.empty();
    }

	/**
	 * 构建部门树
	 *
	 * @param dicts 部门
	 * @return
	 */
	public List<TreeNode> getNodeTree(List<T> dicts) {
		List<TreeNode> treeList = dicts.stream()
			.filter(dict -> !dict.getId().equals(dict.getParentId()))
			.map(dept -> {
				TreeNode node = new TreeNode();
				node.setId(dept.getId());
				node.setParentId(dept.getParentId());
				node.setLabel(dept.getName());
				return node;
			}).collect(Collectors.toList());
		return TreeUtil.buildByLoop(treeList, TreeEntity.ROOT);
	}


	/**
	 * 查询全部部门树
	 *
	 * @return 树
	 */
	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public List<TreeNode> listTrees() {
		return getNodeTree(this.list(Wrappers.emptyWrapper()));
	}

}
