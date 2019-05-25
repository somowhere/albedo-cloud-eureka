package com.albedo.java.common.persistence.service;

import com.albedo.java.common.core.vo.DataEntityVo;
import com.albedo.java.common.persistence.domain.IdEntity;
import com.albedo.java.common.persistence.repository.BaseRepository;
import com.baomidou.mybatisplus.extension.service.IService;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;

public interface DataVoService<Repository extends BaseRepository<T, PK>,
	T extends IdEntity, PK extends Serializable, V extends DataEntityVo> extends IService<T>,
	BaseService<Repository, T, PK>, DataService<Repository, T, PK> {
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	V findOneVo(PK id);

	boolean doCheckByProperty(V entityForm);

	boolean doCheckByPK(V entityForm);

	void copyBeanToVo(T module, V result);

	V copyBeanToVo(T module);

	void copyVoToBean(V form, T entity);

	T copyVoToBean(V form);

	void save(V form);
}
