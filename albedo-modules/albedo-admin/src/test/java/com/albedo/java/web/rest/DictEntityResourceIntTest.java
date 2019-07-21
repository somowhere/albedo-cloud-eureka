package com.albedo.java.web.rest;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.exception.GlobalExceptionHandler;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.modules.admin.AlbedoAdminApplication;
import com.albedo.java.modules.admin.domain.DictEntity;
import com.albedo.java.modules.admin.resource.DictResource;
import com.albedo.java.modules.admin.service.DictService;
import com.albedo.java.modules.admin.vo.DictDataVo;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
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

import java.util.List;

import static com.albedo.java.web.rest.TestUtil.createFormattingConversionService;
import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Test class for the DictResource REST resource.
 *
 * @see DictResource
 */
@SpringBootTest(classes = AlbedoAdminApplication.class)
@Slf4j
public class DictEntityResourceIntTest {


	private String DEFAULT_API_URL;

    private static final String DEFAULT_ANOTHER_NAME = "ANOTHER_NAME";
    private static final String DEFAULT_NAME = "NAME1";
    private static final String UPDATED_NAME = "NAME2";
	private static final String DEFAULT_ANOTHER_CODE = "ANOTHER_CODE";
    private static final String DEFAULT_CODE = "CODE1";
    private static final String UPDATED_CODE = "CODE2";
    private static final Integer DEFAULT_SHOW = CommonConstants.YES;
    private static final Integer UPDATED_SHOW = CommonConstants.NO;
	private static final String DEFAULT_ANOTHER_VAL = "ANOTHER_VAL";
    private static final String DEFAULT_VAL = "VAL1";
    private static final String UPDATED_VAL = "VAL2";
	private static final String DEFAULT_ANOTHER_PARENTID = "ANOTHER_PARENTID";
//    private static final String DEFAULT_PARENTID = "PARENTID1";
    private static final String UPDATED_PARENTID = "PARENTID2";
	private static final Integer DEFAULT_SORT = 10;
	private static final Integer UPDATED_SORT = 20;
	private static final String DEFAULT_REMARK = "REMARK1";
	private static final String UPDATED_REMARK = "REMARK2";
	private static final String DEFAULT_DESCRIPTION = "DESCRIPTION1";
	private static final String UPDATED_DESCRIPTION = "DESCRIPTION2";


    @Autowired
    private DictService dictService;

    private MockMvc restDictMockMvc;
	@Autowired
	private MappingJackson2HttpMessageConverter jacksonMessageConverter;
	@Autowired
	private GlobalExceptionHandler globalExceptionHandler;

    private DictDataVo dict;

	private DictDataVo anotherDict = new DictDataVo();
    @BeforeEach
    public void setup() {
		DEFAULT_API_URL = "/dict/";
		MockitoAnnotations.initMocks(this);
		final DictResource dictResource = new DictResource(dictService);
		this.restDictMockMvc = MockMvcBuilders.standaloneSetup(dictResource)
			.setControllerAdvice(globalExceptionHandler)
			.setConversionService(createFormattingConversionService())
			.setMessageConverters(jacksonMessageConverter)
			.build();
    }

    /**
     * Create a DictEntity.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an domain which has a required relationship to the DictEntity domain.
     */
    public DictDataVo createEntity() {
		DictDataVo dict = new DictDataVo();
        dict.setName(DEFAULT_NAME);
        dict.setVal(DEFAULT_VAL);
        dict.setCode(DEFAULT_CODE);
		dict.setShow(DEFAULT_SHOW);
		dict.setSort(DEFAULT_SORT);
		dict.setRemark(DEFAULT_REMARK);
		dict.setDescription(DEFAULT_DESCRIPTION);
        return dict;
    }

    @BeforeEach
    public void initTest() {
        dict = createEntity();
        // Initialize the database

		anotherDict.setName(DEFAULT_ANOTHER_NAME);
		anotherDict.setVal(DEFAULT_ANOTHER_VAL);
		anotherDict.setParentId(DEFAULT_ANOTHER_PARENTID);
		anotherDict.setCode(DEFAULT_ANOTHER_CODE);
		anotherDict.setShow(DEFAULT_SHOW);
		anotherDict.setSort(DEFAULT_SORT);
		anotherDict.setRemark(DEFAULT_REMARK);
		anotherDict.setDescription(DEFAULT_DESCRIPTION);
        dictService.save(anotherDict);

        dict.setParentId(anotherDict.getId());
	}

    @Test
    @Transactional
    public void createDict() throws Exception {
        List<DictEntity> databaseSizeBeforeCreate = dictService.list();

        // Create the DictEntity
        restDictMockMvc.perform(post(DEFAULT_API_URL)
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(dict)))
            .andExpect(status().isOk());

        // Validate the DictEntity in the database
        List<DictEntity> dictEntityList = dictService.list();
        assertThat(dictEntityList).hasSize(databaseSizeBeforeCreate.size() + 1);
		DictEntity testDictEntity = dictService.findOne(Wrappers.<DictEntity>query().lambda()
			.eq(DictEntity::getName, dict.getName()));
		assertThat(testDictEntity.getName()).isEqualTo(DEFAULT_NAME);
        assertThat(testDictEntity.getCode()).isEqualTo(DEFAULT_CODE);
        assertThat(testDictEntity.getVal()).isEqualTo(DEFAULT_VAL);
		assertThat(testDictEntity.getShow()).isEqualTo(DEFAULT_SHOW);
		assertThat(testDictEntity.getSort()).isEqualTo(DEFAULT_SORT);
		assertThat(testDictEntity.getParentId()).isEqualTo(anotherDict.getId());
		assertThat(testDictEntity.getParentIds()).contains(anotherDict.getId());
		assertThat(testDictEntity.getRemark()).isEqualTo(DEFAULT_REMARK);
		assertThat(testDictEntity.isLeaf()).isEqualTo(true);
		assertThat(testDictEntity.getDescription()).isEqualTo(DEFAULT_DESCRIPTION);
		assertThat(testDictEntity.getDelFlag()).isEqualTo(DictEntity.FLAG_NORMAL);
    }

    @Test
    @Transactional
    public void createDictWithExistingCode() throws Exception {
		// Initialize the database
		dictService.save(dict);
        int databaseSizeBeforeCreate = dictService.list().size();

        // Create the DictEntity
        DictDataVo managedDictVM = createEntity();

        // Create the DictEntity
        restDictMockMvc.perform(post(DEFAULT_API_URL)
                .contentType(TestUtil.APPLICATION_JSON_UTF8)
                .content(TestUtil.convertObjectToJsonBytes(managedDictVM)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(CommonConstants.FAIL))
                .andExpect(jsonPath("$.message").isNotEmpty());

        // Validate the DictEntity in the database
        List<DictEntity> dictEntityList = dictService.list();
        assertThat(dictEntityList).hasSize(databaseSizeBeforeCreate);
    }

    @Test
    @Transactional
    public void getDictPage() throws Exception {
        // Initialize the database
        dictService.save(dict);
        // Get all the dicts
        restDictMockMvc.perform(get(DEFAULT_API_URL)
			.param(PageModel.F_DESC, "parent.created_date")
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
                .andExpect(jsonPath("$.data.records.[*].name").value(hasItem(DEFAULT_NAME)))
                .andExpect(jsonPath("$.data.records.[*].code").value(hasItem(DEFAULT_CODE)))
                .andExpect(jsonPath("$.data.records.[*].val").value(hasItem(DEFAULT_VAL)))
                .andExpect(jsonPath("$.data.records.[*].show").value(hasItem(DEFAULT_SHOW)))
			.andExpect(jsonPath("$.data.records.[*].sort").value(hasItem(DEFAULT_SORT)))
			.andExpect(jsonPath("$.data.records.[*].parentId").value(hasItem(anotherDict.getId())))
			.andExpect(jsonPath("$.data.records.[*].remark").value(hasItem(DEFAULT_REMARK)))
			.andExpect(jsonPath("$.data.records.[*].description").value(hasItem(DEFAULT_DESCRIPTION)))
		;
    }

    @Test
    @Transactional
    public void getDict() throws Exception {
        // Initialize the database
        dictService.save(dict);

        // Get the dict
        restDictMockMvc.perform(get(DEFAULT_API_URL+"{id}", dict.getId()))
                .andExpect(status().isOk())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
			.andExpect(jsonPath("$.data.name").value(DEFAULT_NAME))
			.andExpect(jsonPath("$.data.code").value(DEFAULT_CODE))
			.andExpect(jsonPath("$.data.val").value(DEFAULT_VAL))
			.andExpect(jsonPath("$.data.show").value(DEFAULT_SHOW))
			.andExpect(jsonPath("$.data.parentId").value(anotherDict.getId()))
			.andExpect(jsonPath("$.data.remark").value(DEFAULT_REMARK))
			.andExpect(jsonPath("$.data.description").value(DEFAULT_DESCRIPTION));
    }

    @Test
    @Transactional
	public void getNonExistingDict() throws Exception {
        restDictMockMvc.perform(get("/admin/dict/ddd/unknown"))
                .andExpect(status().isNotFound());
    }

    @Test
    @Transactional
    public void updateDict() throws Exception {
        // Initialize the database
        dictService.save(dict);
        int databaseSizeBeforeUpdate = dictService.list().size();

        // Update the dict
        DictEntity updatedDictEntity = dictService.findOneById(dict.getId());


		DictDataVo managedDictVM = new DictDataVo();
		managedDictVM.setName(UPDATED_NAME);
		managedDictVM.setCode(UPDATED_CODE);
		managedDictVM.setVal(UPDATED_VAL);
		managedDictVM.setSort(UPDATED_SORT);
		managedDictVM.setShow(UPDATED_SHOW);
		managedDictVM.setParentId(UPDATED_PARENTID);
		managedDictVM.setRemark(UPDATED_REMARK);
		managedDictVM.setDescription(UPDATED_DESCRIPTION);

        managedDictVM.setId(updatedDictEntity.getId());
        restDictMockMvc.perform(post(DEFAULT_API_URL)
                .contentType(TestUtil.APPLICATION_JSON_UTF8)
                .content(TestUtil.convertObjectToJsonBytes(managedDictVM)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(CommonConstants.SUCCESS));

        // Validate the DictEntity in the database
        List<DictEntity> dictEntityList = dictService.list();
        assertThat(dictEntityList).hasSize(databaseSizeBeforeUpdate);
        DictEntity testDictEntity = dictService.findOneById(updatedDictEntity.getId());
		assertThat(testDictEntity.getName()).isEqualTo(UPDATED_NAME);
		assertThat(testDictEntity.getCode()).isEqualTo(UPDATED_CODE);
		assertThat(testDictEntity.getVal()).isEqualTo(UPDATED_VAL);
		assertThat(testDictEntity.getShow()).isEqualTo(UPDATED_SHOW);
		assertThat(testDictEntity.getSort()).isEqualTo(UPDATED_SORT);
		assertThat(testDictEntity.getParentId()).isEqualTo(UPDATED_PARENTID);
//		assertThat(testDictEntity.getParentIds()).contains(UPDATED_PARENTID);
		assertThat(testDictEntity.getRemark()).isEqualTo(UPDATED_REMARK);
		assertThat(testDictEntity.isLeaf()).isEqualTo(true);
		assertThat(testDictEntity.getDescription()).isEqualTo(UPDATED_DESCRIPTION);
		assertThat(testDictEntity.getDelFlag()).isEqualTo(DictEntity.FLAG_NORMAL);
    }


    @Test
    @Transactional
    public void updateDictExistingCode() throws Exception {

        dictService.save(dict);
        // Update the dict
        DictEntity updatedDictEntity = dictService.findOneById(dict.getId());

		DictDataVo managedDictVM = new DictDataVo();
		managedDictVM.setName(DEFAULT_ANOTHER_NAME);
		managedDictVM.setVal(DEFAULT_ANOTHER_VAL);
		managedDictVM.setParentId(DEFAULT_ANOTHER_PARENTID);
		managedDictVM.setCode(DEFAULT_ANOTHER_CODE);
		managedDictVM.setShow(DEFAULT_SHOW);
		managedDictVM.setSort(DEFAULT_SORT);
		managedDictVM.setRemark(DEFAULT_REMARK);
		managedDictVM.setDescription(DEFAULT_DESCRIPTION);
        managedDictVM.setId(updatedDictEntity.getId());
        restDictMockMvc.perform(post(DEFAULT_API_URL)
                .contentType(TestUtil.APPLICATION_JSON_UTF8)
                .content(TestUtil.convertObjectToJsonBytes(managedDictVM)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(CommonConstants.FAIL))
                .andExpect(jsonPath("$.message").isNotEmpty());

		// Update the dict
		DictEntity updatedDictEntityAfter = dictService.findOneById(dict.getId());
		assertThat(updatedDictEntityAfter.getCode()).isEqualTo(updatedDictEntity.getCode());
    }


    @Test
    @Transactional
    public void deleteDict() throws Exception {
        // Initialize the database
        dictService.save(dict);
        long databaseSizeBeforeDelete = dictService.findCount();

        // Delete the dict
        restDictMockMvc.perform(delete(DEFAULT_API_URL+"{id}", dict.getId())
                .accept(TestUtil.APPLICATION_JSON_UTF8))
                .andExpect(status().isOk());

        // Validate the database is empty
        long databaseSizeAfterDelete = dictService.findCount();
        assertThat(databaseSizeAfterDelete == databaseSizeBeforeDelete - 1);
    }

    @Test
    @Transactional
    public void testDictEquals() throws Exception {
        TestUtil.equalsVerifier(DictEntity.class);
        DictEntity dictEntity1 = new DictEntity();
        dictEntity1.setId("1");
        dictEntity1.setName("Dict1");
        DictEntity dictEntity2 = new DictEntity();
        dictEntity2.setId(dictEntity1.getId());
        dictEntity2.setName(dictEntity1.getName());
        assertThat(dictEntity1).isEqualTo(dictEntity2);
        dictEntity2.setId("2");
        dictEntity2.setName("Dict2");
        assertThat(dictEntity1).isNotEqualTo(dictEntity2);
        dictEntity1.setId(null);
        assertThat(dictEntity1).isNotEqualTo(dictEntity2);
    }

}
