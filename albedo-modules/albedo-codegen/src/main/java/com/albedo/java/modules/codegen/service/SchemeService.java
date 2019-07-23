package com.albedo.java.modules.codegen.service;

import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.persistence.service.DataVoService;
import com.albedo.java.modules.codegen.domain.Scheme;
import com.albedo.java.modules.codegen.domain.vo.SchemeDataVo;
import com.albedo.java.modules.codegen.repository.SchemeRepository;
import com.baomidou.mybatisplus.core.metadata.IPage;

import java.util.List;
import java.util.Map;

public interface SchemeService extends DataVoService<SchemeRepository, Scheme, String, SchemeDataVo> {
	List<Scheme> findAll(String id);

	String generateCode(SchemeDataVo schemeDataVo);

	Map<String,Object> findFormData(SchemeDataVo schemeDataVo, String loginId);
	/**
	 * 分页查询用户信息（含有角色信息）
	 *
	 * @param pm    分页对象
	 * @return
	 */
	IPage getSchemeVoPage(PageModel pm);
}
