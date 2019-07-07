package com.albedo.java.modules.gen.service;

import com.albedo.java.common.core.vo.QueryCondition;
import com.albedo.java.common.persistence.DynamicSpecifications;
import com.albedo.java.common.persistence.service.impl.DataServiceImpl;
import com.albedo.java.modules.gen.domain.GenTable;
import com.albedo.java.modules.gen.domain.GenTemplate;
import com.albedo.java.modules.gen.repository.GenTemplateRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Service class for managing genTables.
 *
 * @author somewhere
 */
@Service
public class GenTemplateService extends DataServiceImpl<GenTemplateRepository, GenTemplate, String> {

}
