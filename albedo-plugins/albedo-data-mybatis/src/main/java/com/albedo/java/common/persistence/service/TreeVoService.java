package com.albedo.java.common.persistence.service;

import com.albedo.java.common.core.vo.TreeEntityVo;
import com.albedo.java.common.persistence.domain.TreeEntity;
import com.albedo.java.common.persistence.repository.TreeRepository;
import com.baomidou.mybatisplus.extension.service.IService;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.List;
import java.util.Optional;

public interface TreeVoService<Repository extends TreeRepository<T, PK>, T extends TreeEntity,
	PK extends Serializable, V extends TreeEntityVo> extends IService<T>, BaseService<Repository, T, PK>, DataService<Repository, T, PK>, TreeService<Repository, T, PK> {
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	V findOneVo(PK id);

	boolean doCheckByProperty(V entityForm);

	boolean doCheckByPK(V entityForm);

	void copyBeanToVo(T module, V result);

	V copyBeanToVo(T module);

	void copyVoToBean(V form, T entity);

	T copyVoToBean(V form);

	V save(V form);

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	List<V> findAllByParentId(String parentId);

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	Optional<V> findOptionalTopByParentId(String parentId);
}
