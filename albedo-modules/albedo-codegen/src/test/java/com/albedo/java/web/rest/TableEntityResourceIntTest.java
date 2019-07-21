package com.albedo.java.web.rest;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.exception.GlobalExceptionHandler;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.modules.codegen.AlbedoCodeGenApplication;
import com.albedo.java.modules.codegen.controller.TableResource;
import com.albedo.java.modules.codegen.domain.TableEntity;
import com.albedo.java.modules.codegen.domain.vo.TableDataVo;
import com.albedo.java.modules.codegen.service.TableService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;

import static com.albedo.java.web.rest.TestUtil.createFormattingConversionService;
import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Test class for the TableResource REST resource.
 *
 * @see com.albedo.java.modules.codegen.controller.TableResource
 */
@SpringBootTest(classes = AlbedoCodeGenApplication.class)
@Slf4j
public class TableEntityResourceIntTest {


	private String DEFAULT_API_URL;

    private static final String DEFAULT_ANOTHER_USERNAME = "johndoeddd";
    private static final String DEFAULT_USERNAME = "johndoe";
    private static final String UPDATED_USERNAME = "jhipster";

    private static final String DEFAULT_PASSWORD = "passjohndoe";
    private static final String UPDATED_PASSWORD = "passjhipster";

    private static final String DEFAULT_PHONE = "13258812456";
    private static final String UPDATED_PHONE = "13222222222";

    private static final String DEFAULT_ANOTHER_EMAIL = "23423432@localhost";
    private static final String DEFAULT_EMAIL = "johndoe@localhost";
    private static final String UPDATED_EMAIL = "jhipster@localhost";


    private static final String DEFAULT_QQOPENID = "QQOPENID1";
    private static final String UPDATED_QQOPENID = "QQOPENID2";
	private static final String DEFAULT_LOCKFLAG = CommonConstants.STR_YES;
	private static final String UPDATED_LOCKFLAG = CommonConstants.STR_NO;


    @Autowired
    private TableService tableService;

    private MockMvc restTableMockMvc;
	@Autowired
	private MappingJackson2HttpMessageConverter jacksonMessageConverter;
	@Autowired
	private GlobalExceptionHandler globalExceptionHandler;

    private TableDataVo table;
	TableDataVo anotherTable = new TableDataVo();
    @BeforeEach
    public void setup() {
		DEFAULT_API_URL = "/tableEntity/";
		MockitoAnnotations.initMocks(this);
		final TableResource tableResource = new TableResource(tableService);
		this.restTableMockMvc = MockMvcBuilders.standaloneSetup(tableResource)
			.setControllerAdvice(globalExceptionHandler)
			.setConversionService(createFormattingConversionService())
			.setMessageConverters(jacksonMessageConverter)
			.build();
    }

    @Test
    @Transactional
    public void getTablePage() throws Exception {
        // Initialize the database
//        tableService.save(tableEntity);
        // Get all the tables
        restTableMockMvc.perform(get(DEFAULT_API_URL)
			.param(PageModel.F_DESC, TableEntity.F_SQL_CREATEDDATE)
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
//			.andExpect(jsonPath("$.data").isNotEmpty())
//			.andExpect(jsonPath("$.data.records.[*].status").value(hasItem(DictUtil.getCode("sys_status", tableEntity.getStatus()))))
		;
    }


	@Test
	@Transactional
	public void getTableInfo() throws Exception {
		// Initialize the database
//		tableService.save(tableEntity);

		// Get the tableEntity
		restTableMockMvc.perform(get(DEFAULT_API_URL+"/tableList"))
			.andExpect(status().isOk())
			.andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
			.andExpect(jsonPath("$.data").isNotEmpty())
		;
	}


}
