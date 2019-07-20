package com.albedo.java.modules.gen.service;

import com.albedo.java.common.persistence.service.impl.DataServiceImpl;
import com.albedo.java.modules.gen.domain.Template;
import com.albedo.java.modules.gen.repository.TemplateRepository;
import org.springframework.stereotype.Service;

/**
 * Service class for managing genTables.
 *
 * @author somewhere
 */
@Service
public class TemplateService extends DataServiceImpl<TemplateRepository, Template, String> {

}
