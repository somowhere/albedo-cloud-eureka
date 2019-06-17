package com.albedo.java.web.rest;

import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.exception.GlobalExceptionHandler;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.modules.sys.AlbedoAdminApplication;
import com.albedo.java.modules.sys.controller.UserController;
import com.albedo.java.modules.sys.vo.UserDataVo;
import com.albedo.java.modules.sys.entity.Dept;
import com.albedo.java.modules.sys.entity.Role;
import com.albedo.java.modules.sys.entity.User;
import com.albedo.java.modules.sys.service.DeptService;
import com.albedo.java.modules.sys.service.RoleService;
import com.albedo.java.modules.sys.service.UserService;
import com.albedo.java.modules.sys.util.DictUtil;
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
 * Test class for the UserResource REST controller.
 *
 * @see com.albedo.java.modules.sys.controller.UserController
 */
@SpringBootTest(classes = AlbedoAdminApplication.class)
@Slf4j
public class UserResourceIntTest {


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


    @Autowired
    private UserService userService;
	@Autowired
	private RoleService roleService;
	@Autowired
	private DeptService deptService;
    @Autowired
    private ApplicationProperties applicationProperties;

    private MockMvc restUserMockMvc;
	@Autowired
	private MappingJackson2HttpMessageConverter jacksonMessageConverter;
	@Autowired
	private GlobalExceptionHandler globalExceptionHandler;

    private UserDataVo user;
	private List<Role> roleList;
	private List<Dept> deptList;
    @BeforeEach
    public void setup() {
		DEFAULT_API_URL = applicationProperties.getAdminPath("/sys/user/");
		MockitoAnnotations.initMocks(this);
		final UserController userController = new UserController(userService);
		this.restUserMockMvc = MockMvcBuilders.standaloneSetup(userController)
			.addPlaceholderValue("application.adminPath", applicationProperties.getAdminPath())
			.setControllerAdvice(globalExceptionHandler)
			.setConversionService(createFormattingConversionService())
			.setMessageConverters(jacksonMessageConverter)
			.build();
    }

    /**
     * Create a User.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which has a required relationship to the User entity.
     */
    public UserDataVo createEntity() {
		UserDataVo user = new UserDataVo();
        user.setUsername(DEFAULT_USERNAME);
        user.setPassword(DEFAULT_PASSWORD);
        user.setNewpassword1(DEFAULT_PASSWORD);
		user.setEmail(DEFAULT_EMAIL);
        user.setPhone(DEFAULT_PHONE);
		user.setQqOpenid(DEFAULT_QQOPENID);
        user.setDeptId(deptList.get(0).getId());
        user.setRoleIdList(CollUtil.extractToList(roleList, Role.F_ID));
        return user;
    }

    @BeforeEach
    public void initTest() {
        deptList = deptService.list();
        roleList = roleService.list();
        user = createEntity();
        // Initialize the database

		UserDataVo anotherUser = new UserDataVo();
		anotherUser.setUsername(DEFAULT_ANOTHER_USERNAME);
		anotherUser.setPassword(DEFAULT_PASSWORD);
		anotherUser.setEmail(DEFAULT_ANOTHER_EMAIL);
		anotherUser.setPhone(DEFAULT_PHONE);
		anotherUser.setDeptId(deptList.get(0).getId());
		anotherUser.setRoleIdList(CollUtil.extractToList(roleList, Role.F_ID));
        userService.saveUser(anotherUser);
	}

    @Test
    @Transactional
    public void createUser() throws Exception {
        List<User> databaseSizeBeforeCreate = userService.list();

        // Create the User
        restUserMockMvc.perform(post(DEFAULT_API_URL)
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(user)))
            .andExpect(status().isOk());

        // Validate the User in the database
        List<User> userList = userService.list();
        assertThat(userList).hasSize(databaseSizeBeforeCreate.size() + 1);
		User testUser = userService.findOne(Wrappers.<User>query().lambda()
			.eq(User::getUsername, user.getUsername()));
        assertThat(testUser.getUsername()).isEqualTo(DEFAULT_USERNAME);
        assertThat(testUser.getPhone()).isEqualTo(DEFAULT_PHONE);
		assertThat(testUser.getEmail()).isEqualTo(DEFAULT_EMAIL);
		assertThat(testUser.getQqOpenid()).isEqualTo(DEFAULT_QQOPENID);
		assertThat(testUser.getStatus()).isEqualTo(User.FLAG_NORMAL);
    }

    @Test
    @Transactional
    public void createUserWithExistingEmail() throws Exception {
		// Initialize the database
		userService.save(user);
        int databaseSizeBeforeCreate = userService.list().size();

        // Create the User
        UserDataVo managedUserVM = createEntity();

        // Create the User
        restUserMockMvc.perform(post(DEFAULT_API_URL)
                .contentType(TestUtil.APPLICATION_JSON_UTF8)
                .content(TestUtil.convertObjectToJsonBytes(managedUserVM)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(CommonConstants.FAIL))
                .andExpect(jsonPath("$.message").isNotEmpty());

        // Validate the User in the database
        List<User> userList = userService.list();
        assertThat(userList).hasSize(databaseSizeBeforeCreate);
    }

    @Test
    @Transactional
    public void getAllUsers() throws Exception {
        // Initialize the database
        userService.save(user);
        // Get all the users
        restUserMockMvc.perform(get(DEFAULT_API_URL+"page")
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
                .andExpect(jsonPath("$.data.records.[*].username").value(hasItem(DEFAULT_USERNAME)))
                .andExpect(jsonPath("$.data.records.[*].qqOpenid").value(hasItem(DEFAULT_QQOPENID)))
                .andExpect(jsonPath("$.data.records.[*].phone").value(hasItem(DEFAULT_PHONE)))
                .andExpect(jsonPath("$.data.records.[*].email").value(hasItem(DEFAULT_EMAIL)))
//			.andExpect(jsonPath("$.data.records.[*].status").value(hasItem(DictUtil.getCode("sys_status", user.getStatus()))))
		;
    }

    @Test
    @Transactional
    public void getUser() throws Exception {
        // Initialize the database
        userService.save(user);

        // Get the user
        restUserMockMvc.perform(get(DEFAULT_API_URL+"{id}", user.getId()))
                .andExpect(status().isOk())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
                .andExpect(jsonPath("$.data.username").value(user.getUsername()))
                .andExpect(jsonPath("$.data.qqOpenid").value(DEFAULT_QQOPENID))
                .andExpect(jsonPath("$.data.phone").value(DEFAULT_PHONE))
                .andExpect(jsonPath("$.data.email").value(DEFAULT_EMAIL));
    }

    @Test
    @Transactional
    public void getNonExistingUser() throws Exception {
        restUserMockMvc.perform(get(applicationProperties.getAdminPath("/sys/user/ddd/unknown")))
                .andExpect(status().isNotFound());
    }

    @Test
    @Transactional
    public void updateUser() throws Exception {
        // Initialize the database
        userService.save(user);
        int databaseSizeBeforeUpdate = userService.list().size();

        // Update the user
        User updatedUser = userService.findOneById(user.getId());


		UserDataVo managedUserVM = new UserDataVo();
		managedUserVM.setUsername(UPDATED_USERNAME);
		managedUserVM.setPassword(UPDATED_PASSWORD);
		managedUserVM.setNewpassword1(UPDATED_PASSWORD);
		managedUserVM.setEmail(UPDATED_EMAIL);
		managedUserVM.setPhone(UPDATED_PHONE);
		managedUserVM.setQqOpenid(UPDATED_QQOPENID);
		managedUserVM.setRoleIdList(CollUtil.extractToList(roleList, Role.F_ID));
        
        managedUserVM.setId(updatedUser.getId());
        restUserMockMvc.perform(post(DEFAULT_API_URL)
                .contentType(TestUtil.APPLICATION_JSON_UTF8)
                .content(TestUtil.convertObjectToJsonBytes(managedUserVM)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(CommonConstants.SUCCESS));

        // Validate the User in the database
        List<User> userList = userService.list();
        assertThat(userList).hasSize(databaseSizeBeforeUpdate);
        User testUser = userService.findOneById(updatedUser.getId());
        assertThat(testUser.getUsername()).isEqualTo(UPDATED_USERNAME);
        assertThat(testUser.getEmail()).isEqualTo(UPDATED_EMAIL);
        assertThat(testUser.getPhone()).isEqualTo(UPDATED_PHONE);
        assertThat(testUser.getQqOpenid()).isEqualTo(UPDATED_QQOPENID);
    }


    @Test
    @Transactional
    public void updateUserExistingEmail() throws Exception {

        userService.save(user);
        // Update the user
        User updatedUser = userService.findOneById(user.getId());



		UserDataVo managedUserVM = new UserDataVo();
		managedUserVM.setUsername(DEFAULT_ANOTHER_USERNAME);
		managedUserVM.setPassword(UPDATED_PASSWORD);
		managedUserVM.setEmail(UPDATED_EMAIL);
		managedUserVM.setPhone(UPDATED_PHONE);
		managedUserVM.setQqOpenid(UPDATED_QQOPENID);
		managedUserVM.setRoleIdList(CollUtil.extractToList(roleList, Role.F_ID));
        managedUserVM.setId(updatedUser.getId());
        restUserMockMvc.perform(post(DEFAULT_API_URL)
                .contentType(TestUtil.APPLICATION_JSON_UTF8)
                .content(TestUtil.convertObjectToJsonBytes(managedUserVM)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(CommonConstants.FAIL))
                .andExpect(jsonPath("$.message").isNotEmpty());

    }

    @Test
    @Transactional
    public void updateUserExistingLogin() throws Exception {

        userService.save(user);
        // Update the user
        User updatedUser = userService.findOneById(user.getId());


		UserDataVo managedUserVM = new UserDataVo();
		managedUserVM.setUsername(UPDATED_USERNAME);
		managedUserVM.setPassword(UPDATED_PASSWORD);
		managedUserVM.setEmail(UPDATED_EMAIL);
		managedUserVM.setPhone(UPDATED_PHONE);
		managedUserVM.setQqOpenid(UPDATED_QQOPENID);
		managedUserVM.setRoleIdList(CollUtil.extractToList(roleList, Role.F_ID));
        managedUserVM.setId(updatedUser.getId());
        restUserMockMvc.perform(post(DEFAULT_API_URL)
                .contentType(TestUtil.APPLICATION_JSON_UTF8)
                .content(TestUtil.convertObjectToJsonBytes(managedUserVM)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(CommonConstants.FAIL))
                .andExpect(jsonPath("$.message").isNotEmpty());
    }
    @Test
    @Transactional
    public void deleteUser() throws Exception {
        // Initialize the database
        userService.save(user);
        long databaseSizeBeforeDelete = userService.findCount();

        // Delete the user
        restUserMockMvc.perform(delete(DEFAULT_API_URL+"{id}", user.getId())
                .accept(TestUtil.APPLICATION_JSON_UTF8))
                .andExpect(status().isOk());

        // Validate the database is empty
        long databaseSizeAfterDelete = userService.findCount();
        assertThat(databaseSizeAfterDelete == databaseSizeBeforeDelete - 1);
    }

    @Test
    @Transactional
    public void testUserEquals() throws Exception {
        TestUtil.equalsVerifier(User.class);
        User user1 = new User();
        user1.setId("1");
        user1.setUsername("Login1");
        User user2 = new User();
        user2.setId(user1.getId());
        user2.setUsername(user1.getUsername());
        assertThat(user1).isEqualTo(user2);
        user2.setId("2");
        user2.setUsername("Login2");
        assertThat(user1).isNotEqualTo(user2);
        user1.setId(null);
        assertThat(user1).isNotEqualTo(user2);
    }

}
