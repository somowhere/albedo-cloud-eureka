package com.albedo.java.modules.codegen.service;

import com.albedo.java.common.persistence.service.impl.DataServiceImpl;
import com.albedo.java.modules.codegen.domain.TemplateEntity;
import com.albedo.java.modules.codegen.repository.TemplateRepository;
import org.springframework.stereotype.Service;

/**
 * Service class for managing tables.
 *
 * @author somewhere
 */
@Service
public class TemplateService extends DataServiceImpl<TemplateRepository, TemplateEntity, String> {

}
