package com.albedo.java.web.rest;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.exception.GlobalExceptionHandler;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.modules.admin.AlbedoAdminApplication;
import com.albedo.java.modules.admin.domain.*;
import com.albedo.java.modules.admin.resource.RoleResource;
import com.albedo.java.modules.admin.service.*;
import com.albedo.java.modules.admin.vo.RoleDataVo;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.google.common.collect.Lists;
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
 * Test class for the RoleResource REST resource.
 *
 * @see RoleResource
 */
@SpringBootTest(classes = AlbedoAdminApplication.class)
@Slf4j
public class RoleEntityResourceIntTest {


	private String DEFAULT_API_URL;

	private static final String DEFAULT_ANOTHER_NAME = "ANOTHER_NAME";
	private static final String DEFAULT_NAME = "NAME1";
	private static final String UPDATED_NAME = "NAME2";
	private static final String DEFAULT_ANOTHER_CODE = "ANOTHER_CODE";
	private static final String DEFAULT_CODE = "CODE1";
	private static final String UPDATED_CODE = "CODE2";
	private static final String DEFAULT_LOCKFLAG = CommonConstants.STR_YES;
	private static final String UPDATED_LOCKFLAG = CommonConstants.STR_NO;
	private static final String DEFAULT_DATASCOPE = CommonConstants.STR_YES;
	private static final String UPDATED_DATASCOPE = CommonConstants.STR_NO;
	private static final String DEFAULT_REMARK = "REMARK1";
	private static final String UPDATED_REMARK = "REMARK2";
	private static final String DEFAULT_DESCRIPTION = "DESCRIPTION1";
	private static final String UPDATED_DESCRIPTION = "DESCRIPTION2";


	@Autowired
	private RoleService roleService;
	@Autowired
	private MenuService menuService;
	@Autowired
	private DeptService deptService;
	@Autowired
	private RoleMenuService roleMenuService;
	@Autowired
	private RoleDeptService roleDeptService;

	private MockMvc restRoleMockMvc;
	@Autowired
	private MappingJackson2HttpMessageConverter jacksonMessageConverter;
	@Autowired
	private GlobalExceptionHandler globalExceptionHandler;

	private RoleDataVo role;

	private RoleDataVo anotherRole = new RoleDataVo();
	@BeforeEach
	public void setup() {
		DEFAULT_API_URL = "/role/";
		MockitoAnnotations.initMocks(this);
		final RoleResource roleResource = new RoleResource(roleService, roleMenuService);
		this.restRoleMockMvc = MockMvcBuilders.standaloneSetup(roleResource)
			.setControllerAdvice(globalExceptionHandler)
			.setConversionService(createFormattingConversionService())
			.setMessageConverters(jacksonMessageConverter)
			.build();
	}

	/**
	 * Create a RoleEntity.
	 *
	 * This is a static method, as tests for other entities might also need it,
	 * if they test an domain which has a required relationship to the RoleEntity domain.
	 */
	public RoleDataVo createEntity() {
		RoleDataVo role = new RoleDataVo();
		role.setName(DEFAULT_NAME);
		role.setCode(DEFAULT_CODE);
		role.setLockFlag(DEFAULT_LOCKFLAG);
		role.setDataScope(DEFAULT_DATASCOPE);
		role.setRemark(DEFAULT_REMARK);
		role.setDescription(DEFAULT_DESCRIPTION);
		return role;
	}

	@BeforeEach
	public void initTest() {
		role = createEntity();
		// Initialize the database
		List<MenuEntity> allMenuEntities = menuService.findAll();
		List<DeptEntity> allDeptEntity = deptService.findAll();
		anotherRole.setName(DEFAULT_ANOTHER_NAME);
		anotherRole.setCode(DEFAULT_ANOTHER_CODE);
		anotherRole.setLockFlag(DEFAULT_LOCKFLAG);
		anotherRole.setDataScope(DEFAULT_DATASCOPE);
		anotherRole.setRemark(DEFAULT_REMARK);
		anotherRole.setDescription(DEFAULT_DESCRIPTION);
		anotherRole.setMenuIdList(CollUtil.extractToList(allMenuEntities, MenuEntity.F_ID));
		anotherRole.setDeptIdList(CollUtil.extractToList(allDeptEntity, MenuEntity.F_ID));
		roleService.save(anotherRole);
		role.setMenuIdList(anotherRole.getMenuIdList());
		role.setDeptIdList(anotherRole.getDeptIdList());
	}

	@Test
	@Transactional
	public void createRole() throws Exception {
		List<RoleEntity> databaseSizeBeforeCreate = roleService.list();

		// Create the RoleEntity
		restRoleMockMvc.perform(post(DEFAULT_API_URL)
			.contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(role)))
			.andExpect(status().isOk());

		// Validate the RoleEntity in the database
		List<RoleEntity> roleEntityList = roleService.list();
		assertThat(roleEntityList).hasSize(databaseSizeBeforeCreate.size() + 1);
		RoleEntity testRoleEntity = roleService.findOne(Wrappers.<RoleEntity>query().lambda()
			.eq(RoleEntity::getName, role.getName()));
		assertThat(testRoleEntity.getName()).isEqualTo(DEFAULT_NAME);
		assertThat(testRoleEntity.getCode()).isEqualTo(DEFAULT_CODE);
		assertThat(testRoleEntity.getRemark()).isEqualTo(DEFAULT_REMARK);
		assertThat(testRoleEntity.getDescription()).isEqualTo(DEFAULT_DESCRIPTION);
		assertThat(testRoleEntity.getDelFlag()).isEqualTo(RoleEntity.FLAG_NORMAL);
	}

	@Test
	@Transactional
	public void getRolePage() throws Exception {
		// Initialize the database
		roleService.save(role);
		// Get all the roles
		restRoleMockMvc.perform(get(DEFAULT_API_URL)
			.param(PageModel.F_DESC, RoleEntity.F_SQL_CREATEDDATE)
			.accept(MediaType.APPLICATION_JSON))
			.andExpect(status().isOk())
			.andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
			.andExpect(jsonPath("$.data.records.[*].name").value(hasItem(DEFAULT_NAME)))
			.andExpect(jsonPath("$.data.records.[*].code").value(hasItem(DEFAULT_CODE)))
			.andExpect(jsonPath("$.data.records.[*].remark").value(hasItem(DEFAULT_REMARK)))
			.andExpect(jsonPath("$.data.records.[*].description").value(hasItem(DEFAULT_DESCRIPTION)))
		;
	}

	@Test
	@Transactional
	public void getRole() throws Exception {
		// Initialize the database
		roleService.save(role);

		// Get the role
		restRoleMockMvc.perform(get(DEFAULT_API_URL+"{id}", role.getId()))
			.andExpect(status().isOk())
			.andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
			.andExpect(jsonPath("$.data.name").value(DEFAULT_NAME))
			.andExpect(jsonPath("$.data.code").value(DEFAULT_CODE))
			.andExpect(jsonPath("$.data.remark").value(DEFAULT_REMARK))
			.andExpect(jsonPath("$.data.description").value(DEFAULT_DESCRIPTION));
	}

	@Test
	@Transactional
	public void getNonExistingRole() throws Exception {
		restRoleMockMvc.perform(get("/admin/role/ddd/unknown"))
			.andExpect(status().isNotFound());
	}

	@Test
	@Transactional
	public void updateRole() throws Exception {
		// Initialize the database
		roleService.save(role);
		int databaseSizeBeforeUpdate = roleService.list().size();

		// Update the role
		RoleEntity updatedRoleEntity = roleService.findOneById(role.getId());


		RoleDataVo managedRoleVM = new RoleDataVo();
		managedRoleVM.setName(UPDATED_NAME);
		managedRoleVM.setCode(UPDATED_CODE);
		managedRoleVM.setRemark(UPDATED_REMARK);
		managedRoleVM.setLockFlag(UPDATED_LOCKFLAG);
		managedRoleVM.setDataScope(UPDATED_DATASCOPE);
		managedRoleVM.setDescription(UPDATED_DESCRIPTION);
		managedRoleVM.setMenuIdList(Lists.newArrayList(anotherRole.getMenuIdList().get(0)));
		managedRoleVM.setDeptIdList(Lists.newArrayList(anotherRole.getDeptIdList().get(0)));
		managedRoleVM.setId(updatedRoleEntity.getId());
		restRoleMockMvc.perform(post(DEFAULT_API_URL)
			.contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(managedRoleVM)))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.code").value(CommonConstants.SUCCESS));

		// Validate the RoleEntity in the database
		List<RoleEntity> roleEntityList = roleService.list();
		assertThat(roleEntityList).hasSize(databaseSizeBeforeUpdate);
		RoleEntity testRoleEntity = roleService.findOneById(updatedRoleEntity.getId());
		List<RoleMenuEntity> listRoleMenuEntities = roleMenuService.list(Wrappers.<RoleMenuEntity>query().lambda()
			.eq(RoleMenuEntity::getRoleId, testRoleEntity.getId()));
		assertThat(listRoleMenuEntities.size()).isEqualTo(1);
		assertThat(listRoleMenuEntities.get(0).getMenuId()).isEqualTo(anotherRole.getMenuIdList().get(0));
		List<RoleDeptEntity> listRoleDeptEntity = roleDeptService.list(Wrappers.<RoleDeptEntity>query().lambda()
			.eq(RoleDeptEntity::getRoleId, testRoleEntity.getId()));
		assertThat(listRoleDeptEntity.size()).isEqualTo(1);
		assertThat(listRoleDeptEntity.get(0).getDeptId()).isEqualTo(anotherRole.getDeptIdList().get(0));
		assertThat(testRoleEntity.getName()).isEqualTo(UPDATED_NAME);
		assertThat(testRoleEntity.getCode()).isEqualTo(UPDATED_CODE);
//		assertThat(testRoleEntity.getParentIds()).contains(UPDATED_PARENTID);
		assertThat(testRoleEntity.getRemark()).isEqualTo(UPDATED_REMARK);
		assertThat(testRoleEntity.getDescription()).isEqualTo(UPDATED_DESCRIPTION);
		assertThat(testRoleEntity.getDelFlag()).isEqualTo(RoleEntity.FLAG_NORMAL);
	}

	@Test
	@Transactional
	public void deleteRole() throws Exception {
		// Initialize the database
		roleService.save(role);
		long databaseSizeBeforeDelete = roleService.findCount();

		// Delete the role
		restRoleMockMvc.perform(delete(DEFAULT_API_URL+"{id}", role.getId())
			.accept(TestUtil.APPLICATION_JSON_UTF8))
			.andExpect(status().isOk());

		// Validate the database is empty
		long databaseSizeAfterDelete = roleService.findCount();
		assertThat(databaseSizeAfterDelete == databaseSizeBeforeDelete - 1);
	}

	@Test
	@Transactional
	public void testRoleEquals() throws Exception {
		TestUtil.equalsVerifier(RoleEntity.class);
		RoleEntity roleEntity1 = new RoleEntity();
		roleEntity1.setId("1");
		roleEntity1.setName("Role1");
		RoleEntity roleEntity2 = new RoleEntity();
		roleEntity2.setId(roleEntity1.getId());
		roleEntity2.setName(roleEntity1.getName());
		assertThat(roleEntity1).isEqualTo(roleEntity2);
		roleEntity2.setId("2");
		roleEntity2.setName("Role2");
		assertThat(roleEntity1).isNotEqualTo(roleEntity2);
		roleEntity1.setId(null);
		assertThat(roleEntity1).isNotEqualTo(roleEntity2);
	}

}
