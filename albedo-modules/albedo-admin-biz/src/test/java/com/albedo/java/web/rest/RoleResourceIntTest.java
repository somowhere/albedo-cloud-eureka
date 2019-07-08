package com.albedo.java.web.rest;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.exception.GlobalExceptionHandler;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.modules.sys.AlbedoAdminApplication;
import com.albedo.java.modules.sys.domain.Menu;
import com.albedo.java.modules.sys.domain.Role;
import com.albedo.java.modules.sys.domain.RoleMenu;
import com.albedo.java.modules.sys.resource.RoleResource;
import com.albedo.java.modules.sys.service.MenuService;
import com.albedo.java.modules.sys.service.RoleMenuService;
import com.albedo.java.modules.sys.service.RoleService;
import com.albedo.java.modules.sys.vo.RoleDataVo;
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
public class RoleResourceIntTest {


	private String DEFAULT_API_URL;

	private static final String DEFAULT_ANOTHER_NAME = "ANOTHER_NAME";
	private static final String DEFAULT_NAME = "NAME1";
	private static final String UPDATED_NAME = "NAME2";
	private static final String DEFAULT_ANOTHER_CODE = "ANOTHER_CODE";
	private static final String DEFAULT_CODE = "CODE1";
	private static final String UPDATED_CODE = "CODE2";
	private static final String DEFAULT_REMARK = "REMARK1";
	private static final String UPDATED_REMARK = "REMARK2";
	private static final String DEFAULT_DESCRIPTION = "DESCRIPTION1";
	private static final String UPDATED_DESCRIPTION = "DESCRIPTION2";


	@Autowired
	private RoleService roleService;
	@Autowired
	private MenuService menuService;
	@Autowired
	private RoleMenuService roleMenuService;

	private MockMvc restRoleMockMvc;
	@Autowired
	private MappingJackson2HttpMessageConverter jacksonMessageConverter;
	@Autowired
	private GlobalExceptionHandler globalExceptionHandler;

	private RoleDataVo role;

	private RoleDataVo anotherRole = new RoleDataVo();
	@BeforeEach
	public void setup() {
		DEFAULT_API_URL = "/sys/role/";
		MockitoAnnotations.initMocks(this);
		final RoleResource roleResource = new RoleResource(roleService, roleMenuService);
		this.restRoleMockMvc = MockMvcBuilders.standaloneSetup(roleResource)
			.setControllerAdvice(globalExceptionHandler)
			.setConversionService(createFormattingConversionService())
			.setMessageConverters(jacksonMessageConverter)
			.build();
	}

	/**
	 * Create a Role.
	 *
	 * This is a static method, as tests for other entities might also need it,
	 * if they test an domain which has a required relationship to the Role domain.
	 */
	public RoleDataVo createEntity() {
		RoleDataVo role = new RoleDataVo();
		role.setName(DEFAULT_NAME);
		role.setCode(DEFAULT_CODE);
		role.setRemark(DEFAULT_REMARK);
		role.setDescription(DEFAULT_DESCRIPTION);
		return role;
	}

	@BeforeEach
	public void initTest() {
		role = createEntity();
		// Initialize the database
		List<Menu> all = menuService.findAll();
		anotherRole.setName(DEFAULT_ANOTHER_NAME);
		anotherRole.setCode(DEFAULT_ANOTHER_CODE);
		anotherRole.setRemark(DEFAULT_REMARK);
		anotherRole.setDescription(DEFAULT_DESCRIPTION);
		anotherRole.setMenuIdList(CollUtil.extractToList(all, Menu.F_ID));
		roleService.save(anotherRole);
		role.setMenuIdList(anotherRole.getMenuIdList());
	}

	@Test
	@Transactional
	public void createRole() throws Exception {
		List<Role> databaseSizeBeforeCreate = roleService.list();

		// Create the Role
		restRoleMockMvc.perform(post(DEFAULT_API_URL)
			.contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(role)))
			.andExpect(status().isOk());

		// Validate the Role in the database
		List<Role> roleList = roleService.list();
		assertThat(roleList).hasSize(databaseSizeBeforeCreate.size() + 1);
		Role testRole = roleService.findOne(Wrappers.<Role>query().lambda()
			.eq(Role::getName, role.getName()));
		assertThat(testRole.getName()).isEqualTo(DEFAULT_NAME);
		assertThat(testRole.getCode()).isEqualTo(DEFAULT_CODE);
		assertThat(testRole.getRemark()).isEqualTo(DEFAULT_REMARK);
		assertThat(testRole.getDescription()).isEqualTo(DEFAULT_DESCRIPTION);
		assertThat(testRole.getDelFlag()).isEqualTo(Role.FLAG_NORMAL);
	}

	@Test
	@Transactional
	public void getRolePage() throws Exception {
		// Initialize the database
		roleService.save(role);
		// Get all the roles
		restRoleMockMvc.perform(get(DEFAULT_API_URL)
			.param(PageModel.F_DESC, Role.F_SQL_CREATEDDATE)
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
		restRoleMockMvc.perform(get("/sys/role/ddd/unknown"))
			.andExpect(status().isNotFound());
	}

	@Test
	@Transactional
	public void updateRole() throws Exception {
		// Initialize the database
		roleService.save(role);
		int databaseSizeBeforeUpdate = roleService.list().size();

		// Update the role
		Role updatedRole = roleService.findOneById(role.getId());


		RoleDataVo managedRoleVM = new RoleDataVo();
		managedRoleVM.setName(UPDATED_NAME);
		managedRoleVM.setCode(UPDATED_CODE);
		managedRoleVM.setRemark(UPDATED_REMARK);
		managedRoleVM.setDescription(UPDATED_DESCRIPTION);
		managedRoleVM.setMenuIdList(Lists.newArrayList(anotherRole.getMenuIdList().get(0)));
		managedRoleVM.setId(updatedRole.getId());
		restRoleMockMvc.perform(post(DEFAULT_API_URL)
			.contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(managedRoleVM)))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.code").value(CommonConstants.SUCCESS));

		// Validate the Role in the database
		List<Role> roleList = roleService.list();
		assertThat(roleList).hasSize(databaseSizeBeforeUpdate);
		Role testRole = roleService.findOneById(updatedRole.getId());
		List<RoleMenu> list = roleMenuService.list(Wrappers.<RoleMenu>query().lambda()
			.eq(RoleMenu::getRoleId, testRole.getId()));
		assertThat(list.size()).isEqualTo(1);
		assertThat(list.get(0).getMenuId()).isEqualTo(anotherRole.getMenuIdList().get(0));
		assertThat(testRole.getName()).isEqualTo(UPDATED_NAME);
		assertThat(testRole.getCode()).isEqualTo(UPDATED_CODE);
//		assertThat(testRole.getParentIds()).contains(UPDATED_PARENTID);
		assertThat(testRole.getRemark()).isEqualTo(UPDATED_REMARK);
		assertThat(testRole.getDescription()).isEqualTo(UPDATED_DESCRIPTION);
		assertThat(testRole.getDelFlag()).isEqualTo(Role.FLAG_NORMAL);
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
		TestUtil.equalsVerifier(Role.class);
		Role role1 = new Role();
		role1.setId("1");
		role1.setName("Role1");
		Role role2 = new Role();
		role2.setId(role1.getId());
		role2.setName(role1.getName());
		assertThat(role1).isEqualTo(role2);
		role2.setId("2");
		role2.setName("Role2");
		assertThat(role1).isNotEqualTo(role2);
		role1.setId(null);
		assertThat(role1).isNotEqualTo(role2);
	}

}
