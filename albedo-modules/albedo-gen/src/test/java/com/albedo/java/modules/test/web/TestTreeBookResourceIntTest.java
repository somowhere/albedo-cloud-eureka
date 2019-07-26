/**
 * Copyright &copy; 2018 <a href="https://github.com/somewhereMrli/albedo-boot">albedo-boot</a> All rights reserved.
 */
package com.albedo.java.modules.test.web;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.Json;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.core.vo.QueryCondition;
import com.albedo.java.common.core.util.DateUtil;
import com.albedo.java.common.core.exception.GlobalExceptionHandler;
import com.albedo.java.common.core.util.ClassUtil;
import com.albedo.java.modules.test.domain.TestTreeBook;
import com.albedo.java.modules.test.domain.vo.TestTreeBookDataVo;
import com.albedo.java.modules.test.service.TestTreeBookService;
import com.albedo.java.modules.TestUtil;
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
import org.apache.commons.lang3.time.DateUtils;
import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import java.util.Date;
import java.util.List;

/**
 * Test class for the TestTreeBookResource REST controller.
 *
 * @see TestTreeBookResource
 */
@SpringBootTest(classes = com.albedo.java.modules.AlbedoGenApplication.class)
@Slf4j
public class TestTreeBookResourceIntTest {

    private String DEFAULT_API_URL;
	/** DEFAULT_PARENTID parent_id  :  parent_id */
	private static final String DEFAULT_PARENTID = "A";
	/** UPDATED_PARENTID parent_id  :  parent_id */
    private static final String UPDATED_PARENTID = "B";
	/** DEFAULT_NAME name  :  部门名称 */
	private static final String DEFAULT_NAME = "A";
	/** UPDATED_NAME name  :  部门名称 */
    private static final String UPDATED_NAME = "B";
	/** DEFAULT_SORT sort  :  排序 */
	private static final int DEFAULT_SORT = 0;
	/** UPDATED_SORT sort  :  排序 */
    private static final int UPDATED_SORT = 1;
	/** DEFAULT_AUTHOR author_  :  作者 */
	private static final String DEFAULT_AUTHOR = "A";
	/** UPDATED_AUTHOR author_  :  作者 */
    private static final String UPDATED_AUTHOR = "B";
	/** DEFAULT_EMAIL email_  :  邮箱 */
	private static final String DEFAULT_EMAIL = "1@albedo.com";
	/** UPDATED_EMAIL email_  :  邮箱 */
    private static final String UPDATED_EMAIL = "2@albedo.com";
	/** DEFAULT_PHONE phone_  :  手机 */
	private static final String DEFAULT_PHONE = "A";
	/** UPDATED_PHONE phone_  :  手机 */
    private static final String UPDATED_PHONE = "B";
	/** DEFAULT_ACTIVATED activated_  :  activated_ */
	private static final int DEFAULT_ACTIVATED = 0;
	/** UPDATED_ACTIVATED activated_  :  activated_ */
    private static final int UPDATED_ACTIVATED = 1;
	/** DEFAULT_NUMBER number_  :  key */
	private static final Long DEFAULT_NUMBER = 0l;
	/** UPDATED_NUMBER number_  :  key */
    private static final Long UPDATED_NUMBER = 1l;
	/** DEFAULT_MONEY money_  :  money_ */
	private static final double DEFAULT_MONEY = 0;
	/** UPDATED_MONEY money_  :  money_ */
    private static final double UPDATED_MONEY = 1;
	/** DEFAULT_AMOUNT amount_  :  amount_ */
	private static final double DEFAULT_AMOUNT = 0;
	/** UPDATED_AMOUNT amount_  :  amount_ */
    private static final double UPDATED_AMOUNT = 1;
	/** DEFAULT_RESETDATE reset_date  :  reset_date */
	private static final Date DEFAULT_RESETDATE = DateUtil.parse(DateUtil.format(new Date(),DateUtil.TIME_FORMAT),DateUtil.TIME_FORMAT).toJdkDate();
	/** UPDATED_RESETDATE reset_date  :  reset_date */
    private static final Date UPDATED_RESETDATE = DateUtils.addDays(DEFAULT_RESETDATE, 1);
	/** DEFAULT_DESCRIPTION description  :  备注 */
	private static final String DEFAULT_DESCRIPTION = "A";
	/** UPDATED_DESCRIPTION description  :  备注 */
    private static final String UPDATED_DESCRIPTION = "B";

    @Autowired
	private TestTreeBookService testTreeBookService;

	private MockMvc restTestTreeBookMockMvc;
	@Autowired
	private MappingJackson2HttpMessageConverter jacksonMessageConverter;
	@Autowired
	private GlobalExceptionHandler globalExceptionHandler;

	private TestTreeBookDataVo testTreeBookDataVo;

	private TestTreeBookDataVo anotherTestTreeBookDataVo = new TestTreeBookDataVo();
	@BeforeEach
	public void setup() {
		DEFAULT_API_URL = "/testTreeBook/";
		MockitoAnnotations.initMocks(this);
		final TestTreeBookResource testTreeBookResource = new TestTreeBookResource(testTreeBookService);
		this.restTestTreeBookMockMvc = MockMvcBuilders.standaloneSetup(testTreeBookResource)
			.setControllerAdvice(globalExceptionHandler)
			.setConversionService(TestUtil.createFormattingConversionService())
			.setMessageConverters(jacksonMessageConverter)
			.build();
	}

    /**
     * Create an entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static TestTreeBookDataVo createEntity() {
        TestTreeBookDataVo testTreeBookDataVo = ClassUtil.createObj(TestTreeBookDataVo.class, Lists.newArrayList(
		 TestTreeBook.F_PARENTID
		,TestTreeBook.F_NAME
		,TestTreeBook.F_SORT
		,TestTreeBook.F_AUTHOR
		,TestTreeBook.F_EMAIL
		,TestTreeBook.F_PHONE
		,TestTreeBook.F_ACTIVATED
		,TestTreeBook.F_NUMBER
		,TestTreeBook.F_MONEY
		,TestTreeBook.F_AMOUNT
		,TestTreeBook.F_RESETDATE
		,TestTreeBook.F_DESCRIPTION
        ), 
	
		 DEFAULT_PARENTID
	
	
		,DEFAULT_NAME
	
		,DEFAULT_SORT
	
	
		,DEFAULT_AUTHOR
	
		,DEFAULT_EMAIL
	
		,DEFAULT_PHONE
	
		,DEFAULT_ACTIVATED
	
		,DEFAULT_NUMBER
	
		,DEFAULT_MONEY
	
		,DEFAULT_AMOUNT
	
		,DEFAULT_RESETDATE
	
	
	
	
	
	
	
		,DEFAULT_DESCRIPTION
	);
        return testTreeBookDataVo;
    }

    @BeforeEach
    public void initTest() {
        testTreeBookDataVo = createEntity();
    }

    @Test
    @Transactional
    public void createTestTreeBook() throws Exception {
        int databaseSizeBeforeCreate = testTreeBookService.findAll().size();
        // Create the TestTreeBook
        restTestTreeBookMockMvc.perform(post(DEFAULT_API_URL)
			.param(PageModel.F_DESC, TestTreeBook.F_SQL_CREATEDDATE)
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(testTreeBookDataVo)))
            .andExpect(status().isOk());
        ;
        // Validate the TestTreeBook in the database
        List<TestTreeBook> testTreeBookList = testTreeBookService.findAll(
            Wrappers.<TestTreeBook>query().lambda().orderByAsc(
				TestTreeBook::getCreatedDate
			)
        );
        assertThat(testTreeBookList).hasSize(databaseSizeBeforeCreate + 1);
        TestTreeBook testTestTreeBook = testTreeBookList.get(testTreeBookList.size() - 1);
		assertThat(testTestTreeBook.getParentId()).isEqualTo(DEFAULT_PARENTID);
		assertThat(testTestTreeBook.getName()).isEqualTo(DEFAULT_NAME);
		assertThat(testTestTreeBook.getSort()).isEqualTo(DEFAULT_SORT);
		assertThat(testTestTreeBook.getAuthor()).isEqualTo(DEFAULT_AUTHOR);
		assertThat(testTestTreeBook.getEmail()).isEqualTo(DEFAULT_EMAIL);
		assertThat(testTestTreeBook.getPhone()).isEqualTo(DEFAULT_PHONE);
		assertThat(testTestTreeBook.getActivated()).isEqualTo(DEFAULT_ACTIVATED);
		assertThat(testTestTreeBook.getNumber()).isEqualTo(DEFAULT_NUMBER);
		assertThat(testTestTreeBook.getMoney()).isEqualTo(DEFAULT_MONEY);
		assertThat(testTestTreeBook.getAmount()).isEqualTo(DEFAULT_AMOUNT);
		assertThat(testTestTreeBook.getResetDate()).isEqualTo(DEFAULT_RESETDATE);
		assertThat(testTestTreeBook.getDescription()).isEqualTo(DEFAULT_DESCRIPTION);
    }
    @Test
    @Transactional
    public void createTestTreeBookWithExistingPhone() throws Exception {
        testTreeBookService.save(testTreeBookDataVo);
        int databaseSizeBeforeCreate = testTreeBookService.findAll().size();

        // Create the TestTreeBook with an existing ID
        TestTreeBookDataVo testTreeBookDataVoNew = ClassUtil.createObj(TestTreeBookDataVo.class, Lists.newArrayList(TestTreeBookDataVo.F_ID, TestTreeBookDataVo.F_PHONE),
            null, testTreeBookDataVo.getPhone());

        // An entity with an existing ID cannot be created, so this API call must fail
        restTestTreeBookMockMvc.perform(post(DEFAULT_API_URL)
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(testTreeBookDataVoNew)))
            .andExpect(status().isBadRequest());

        // Validate the TestTreeBook in the database
        List<TestTreeBook> testTreeBookList = testTreeBookService.findAll();
        assertThat(testTreeBookList).hasSize(databaseSizeBeforeCreate);
    }

    @Test
    @Transactional
    public void checkAuthorIsRequired() throws Exception {
        int databaseSizeBeforeTest = testTreeBookService.findAll().size();
        // set the field null
        testTreeBookDataVo.setAuthor(null);

        // Create the TestTreeBook, which fails.

        restTestTreeBookMockMvc.perform(post(DEFAULT_API_URL)
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(testTreeBookDataVo)))
            .andExpect(status().isBadRequest());

        List<TestTreeBook> testTreeBookList = testTreeBookService.findAll();
        assertThat(testTreeBookList).hasSize(databaseSizeBeforeTest);
    }
    @Test
    @Transactional
    public void checkActivatedIsRequired() throws Exception {
        int databaseSizeBeforeTest = testTreeBookService.findAll().size();
        // set the field null
        testTreeBookDataVo.setActivated(null);

        // Create the TestTreeBook, which fails.

        restTestTreeBookMockMvc.perform(post(DEFAULT_API_URL)
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(testTreeBookDataVo)))
            .andExpect(status().isBadRequest());

        List<TestTreeBook> testTreeBookList = testTreeBookService.findAll();
        assertThat(testTreeBookList).hasSize(databaseSizeBeforeTest);
    }


    @Test
    @Transactional
    public void getAllTestTreeBooks() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList
        restTestTreeBookMockMvc.perform(get(DEFAULT_API_URL))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.data.records.[*].id").value(hasItem(testTreeBookDataVo.getId())))
                                        .andExpect(jsonPath("$.data.records.[*].email").value(hasItem(DEFAULT_EMAIL)))
                .andExpect(jsonPath("$.data.records.[*].phone").value(hasItem(DEFAULT_PHONE)))
                    .andExpect(jsonPath("$.data.records.[*].number").value(hasItem(DEFAULT_NUMBER.intValue())))
                .andExpect(jsonPath("$.data.records.[*].money").value(hasItem(DEFAULT_MONEY)))
                .andExpect(jsonPath("$.data.records.[*].amount").value(hasItem(DEFAULT_AMOUNT)))
                .andExpect(jsonPath("$.data.records.[*].resetDate").value(hasItem(DateUtil.formatDateTime(DEFAULT_RESETDATE))))
                                        .andExpect(jsonPath("$.data.records.[*].description").value(hasItem(DEFAULT_DESCRIPTION)))
    ;
    }

    @Test
    @Transactional
    public void getTestTreeBook() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get the testTreeBook
        restTestTreeBookMockMvc.perform(get(DEFAULT_API_URL+"{id}", testTreeBookDataVo.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.data.id").value(testTreeBookDataVo.getId()))
                                        .andExpect(jsonPath("$.data.email").value(DEFAULT_EMAIL))
                .andExpect(jsonPath("$.data.phone").value(DEFAULT_PHONE))
                    .andExpect(jsonPath("$.data.number").value(DEFAULT_NUMBER))
                .andExpect(jsonPath("$.data.money").value(DEFAULT_MONEY))
                .andExpect(jsonPath("$.data.amount").value(DEFAULT_AMOUNT))
                .andExpect(jsonPath("$.data.resetDate").value(DateUtil.formatDateTime(DEFAULT_RESETDATE)))
                                        .andExpect(jsonPath("$.data.description").value(DEFAULT_DESCRIPTION))
    ;
    }
    @Test
    @Transactional
    public void getAllTestTreeBooksByParentIdIsEqualToSomething() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where parentId equals to DEFAULT_PARENTID
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
        QueryCondition.eq(TestTreeBook.F_PARENTID, DEFAULT_PARENTID)
        );

        // Get all the testTreeBookList where parentId equals to UPDATED_PARENTID
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
        QueryCondition.eq(TestTreeBook.F_PARENTID, UPDATED_PARENTID)
        );
    }

    @Test
    @Transactional
    public void getAllTestTreeBooksByParentIdIsInShouldWork() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where parentId in DEFAULT_PARENTID or UPDATED_PARENTID
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
         QueryCondition.in(TestTreeBook.F_PARENTID, Lists.newArrayList(DEFAULT_PARENTID, DEFAULT_PARENTID))
        );

        // Get all the testTreeBookList where parentId equals to UPDATED_PARENTID
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
         QueryCondition.in(TestTreeBook.F_PARENTID, Lists.newArrayList(UPDATED_PARENTID))
        );
    }

    @Test
    @Transactional
    public void getAllTestTreeBooksByParentIdIsNullOrNotNull() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where parentId is not null
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()), QueryCondition.isNotNull(TestTreeBook.F_PARENTID));

        // Get all the testTreeBookList where parentId is null
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()), QueryCondition.isNull(TestTreeBook.F_PARENTID));
    }
    @Test
    @Transactional
    public void getAllTestTreeBooksByNameIsEqualToSomething() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where name equals to DEFAULT_NAME
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
        QueryCondition.eq(TestTreeBook.F_NAME, DEFAULT_NAME)
        );

        // Get all the testTreeBookList where name equals to UPDATED_NAME
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
        QueryCondition.eq(TestTreeBook.F_NAME, UPDATED_NAME)
        );
    }

    @Test
    @Transactional
    public void getAllTestTreeBooksByNameIsInShouldWork() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where name in DEFAULT_NAME or UPDATED_NAME
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
         QueryCondition.in(TestTreeBook.F_NAME, Lists.newArrayList(DEFAULT_NAME, DEFAULT_NAME))
        );

        // Get all the testTreeBookList where name equals to UPDATED_NAME
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
         QueryCondition.in(TestTreeBook.F_NAME, Lists.newArrayList(UPDATED_NAME))
        );
    }

    @Test
    @Transactional
    public void getAllTestTreeBooksByNameIsNullOrNotNull() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where name is not null
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()), QueryCondition.isNotNull(TestTreeBook.F_NAME));

        // Get all the testTreeBookList where name is null
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()), QueryCondition.isNull(TestTreeBook.F_NAME));
    }
    @Test
    @Transactional
    public void getAllTestTreeBooksBySortIsEqualToSomething() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where sort equals to DEFAULT_SORT
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
        QueryCondition.eq(TestTreeBook.F_SORT, DEFAULT_SORT)
        );

        // Get all the testTreeBookList where sort equals to UPDATED_SORT
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
        QueryCondition.eq(TestTreeBook.F_SORT, UPDATED_SORT)
        );
    }

    @Test
    @Transactional
    public void getAllTestTreeBooksBySortIsInShouldWork() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where sort in DEFAULT_SORT or UPDATED_SORT
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
         QueryCondition.in(TestTreeBook.F_SORT, Lists.newArrayList(DEFAULT_SORT, DEFAULT_SORT))
        );

        // Get all the testTreeBookList where sort equals to UPDATED_SORT
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
         QueryCondition.in(TestTreeBook.F_SORT, Lists.newArrayList(UPDATED_SORT))
        );
    }

    @Test
    @Transactional
    public void getAllTestTreeBooksBySortIsNullOrNotNull() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where sort is not null
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()), QueryCondition.isNotNull(TestTreeBook.F_SORT));

        // Get all the testTreeBookList where sort is null
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()), QueryCondition.isNull(TestTreeBook.F_SORT));
    }
    @Test
    @Transactional
    public void getAllTestTreeBooksByEmailIsEqualToSomething() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where email equals to DEFAULT_EMAIL
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
        QueryCondition.eq(TestTreeBook.F_EMAIL, DEFAULT_EMAIL)
        );

        // Get all the testTreeBookList where email equals to UPDATED_EMAIL
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
        QueryCondition.eq(TestTreeBook.F_EMAIL, UPDATED_EMAIL)
        );
    }

    @Test
    @Transactional
    public void getAllTestTreeBooksByEmailIsInShouldWork() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where email in DEFAULT_EMAIL or UPDATED_EMAIL
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
         QueryCondition.in(TestTreeBook.F_EMAIL, Lists.newArrayList(DEFAULT_EMAIL, DEFAULT_EMAIL))
        );

        // Get all the testTreeBookList where email equals to UPDATED_EMAIL
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
         QueryCondition.in(TestTreeBook.F_EMAIL, Lists.newArrayList(UPDATED_EMAIL))
        );
    }

    @Test
    @Transactional
    public void getAllTestTreeBooksByEmailIsNullOrNotNull() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where email is not null
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()), QueryCondition.isNotNull(TestTreeBook.F_EMAIL));

        // Get all the testTreeBookList where email is null
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()), QueryCondition.isNull(TestTreeBook.F_EMAIL));
    }
    @Test
    @Transactional
    public void getAllTestTreeBooksByPhoneIsEqualToSomething() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where phone equals to DEFAULT_PHONE
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
        QueryCondition.eq(TestTreeBook.F_PHONE, DEFAULT_PHONE)
        );

        // Get all the testTreeBookList where phone equals to UPDATED_PHONE
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
        QueryCondition.eq(TestTreeBook.F_PHONE, UPDATED_PHONE)
        );
    }

    @Test
    @Transactional
    public void getAllTestTreeBooksByPhoneIsInShouldWork() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where phone in DEFAULT_PHONE or UPDATED_PHONE
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
         QueryCondition.in(TestTreeBook.F_PHONE, Lists.newArrayList(DEFAULT_PHONE, DEFAULT_PHONE))
        );

        // Get all the testTreeBookList where phone equals to UPDATED_PHONE
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
         QueryCondition.in(TestTreeBook.F_PHONE, Lists.newArrayList(UPDATED_PHONE))
        );
    }

    @Test
    @Transactional
    public void getAllTestTreeBooksByPhoneIsNullOrNotNull() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where phone is not null
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()), QueryCondition.isNotNull(TestTreeBook.F_PHONE));

        // Get all the testTreeBookList where phone is null
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()), QueryCondition.isNull(TestTreeBook.F_PHONE));
    }
    @Test
    @Transactional
    public void getAllTestTreeBooksByNumberIsEqualToSomething() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where number equals to DEFAULT_NUMBER
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
        QueryCondition.eq(TestTreeBook.F_NUMBER, DEFAULT_NUMBER)
        );

        // Get all the testTreeBookList where number equals to UPDATED_NUMBER
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
        QueryCondition.eq(TestTreeBook.F_NUMBER, UPDATED_NUMBER)
        );
    }

    @Test
    @Transactional
    public void getAllTestTreeBooksByNumberIsInShouldWork() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where number in DEFAULT_NUMBER or UPDATED_NUMBER
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
         QueryCondition.in(TestTreeBook.F_NUMBER, Lists.newArrayList(DEFAULT_NUMBER, DEFAULT_NUMBER))
        );

        // Get all the testTreeBookList where number equals to UPDATED_NUMBER
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
         QueryCondition.in(TestTreeBook.F_NUMBER, Lists.newArrayList(UPDATED_NUMBER))
        );
    }

    @Test
    @Transactional
    public void getAllTestTreeBooksByNumberIsNullOrNotNull() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where number is not null
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()), QueryCondition.isNotNull(TestTreeBook.F_NUMBER));

        // Get all the testTreeBookList where number is null
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()), QueryCondition.isNull(TestTreeBook.F_NUMBER));
    }
    @Test
    @Transactional
    public void getAllTestTreeBooksByMoneyIsEqualToSomething() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where money equals to DEFAULT_MONEY
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
        QueryCondition.eq(TestTreeBook.F_MONEY, DEFAULT_MONEY)
        );

        // Get all the testTreeBookList where money equals to UPDATED_MONEY
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
        QueryCondition.eq(TestTreeBook.F_MONEY, UPDATED_MONEY)
        );
    }

    @Test
    @Transactional
    public void getAllTestTreeBooksByMoneyIsInShouldWork() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where money in DEFAULT_MONEY or UPDATED_MONEY
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
         QueryCondition.in(TestTreeBook.F_MONEY, Lists.newArrayList(DEFAULT_MONEY, DEFAULT_MONEY))
        );

        // Get all the testTreeBookList where money equals to UPDATED_MONEY
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
         QueryCondition.in(TestTreeBook.F_MONEY, Lists.newArrayList(UPDATED_MONEY))
        );
    }

    @Test
    @Transactional
    public void getAllTestTreeBooksByMoneyIsNullOrNotNull() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where money is not null
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()), QueryCondition.isNotNull(TestTreeBook.F_MONEY));

        // Get all the testTreeBookList where money is null
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()), QueryCondition.isNull(TestTreeBook.F_MONEY));
    }
    @Test
    @Transactional
    public void getAllTestTreeBooksByMoneyIsGreaterThanOrEqualToSomething() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where money greater than or equals to DEFAULT_MONEY
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
         QueryCondition.ge(TestTreeBook.F_MONEY, DEFAULT_MONEY)
        );

        // Get all the testTreeBookList where money greater than or equals to UPDATED_MONEY
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
         QueryCondition.ge(TestTreeBook.F_MONEY, UPDATED_MONEY)
        );
    }

    @Test
    @Transactional
    public void getAllTestTreeBooksByMoneyIsLessThanSomething() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where money less than or equals to DEFAULT_SORT
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
         QueryCondition.lt(TestTreeBook.F_MONEY, DEFAULT_MONEY)
        );

        // Get all the testTreeBookList where money less than or equals to UPDATED_SORT
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
         QueryCondition.lt(TestTreeBook.F_MONEY, UPDATED_MONEY)
        );
    }
    @Test
    @Transactional
    public void getAllTestTreeBooksByAmountIsEqualToSomething() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where amount equals to DEFAULT_AMOUNT
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
        QueryCondition.eq(TestTreeBook.F_AMOUNT, DEFAULT_AMOUNT)
        );

        // Get all the testTreeBookList where amount equals to UPDATED_AMOUNT
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
        QueryCondition.eq(TestTreeBook.F_AMOUNT, UPDATED_AMOUNT)
        );
    }

    @Test
    @Transactional
    public void getAllTestTreeBooksByAmountIsInShouldWork() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where amount in DEFAULT_AMOUNT or UPDATED_AMOUNT
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
         QueryCondition.in(TestTreeBook.F_AMOUNT, Lists.newArrayList(DEFAULT_AMOUNT, DEFAULT_AMOUNT))
        );

        // Get all the testTreeBookList where amount equals to UPDATED_AMOUNT
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
         QueryCondition.in(TestTreeBook.F_AMOUNT, Lists.newArrayList(UPDATED_AMOUNT))
        );
    }

    @Test
    @Transactional
    public void getAllTestTreeBooksByAmountIsNullOrNotNull() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where amount is not null
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()), QueryCondition.isNotNull(TestTreeBook.F_AMOUNT));

        // Get all the testTreeBookList where amount is null
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()), QueryCondition.isNull(TestTreeBook.F_AMOUNT));
    }
    @Test
    @Transactional
    public void getAllTestTreeBooksByAmountIsGreaterThanOrEqualToSomething() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where amount greater than or equals to DEFAULT_AMOUNT
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
         QueryCondition.ge(TestTreeBook.F_AMOUNT, DEFAULT_AMOUNT)
        );

        // Get all the testTreeBookList where amount greater than or equals to UPDATED_AMOUNT
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
         QueryCondition.ge(TestTreeBook.F_AMOUNT, UPDATED_AMOUNT)
        );
    }

    @Test
    @Transactional
    public void getAllTestTreeBooksByAmountIsLessThanSomething() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where amount less than or equals to DEFAULT_SORT
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
         QueryCondition.lt(TestTreeBook.F_AMOUNT, DEFAULT_AMOUNT)
        );

        // Get all the testTreeBookList where amount less than or equals to UPDATED_SORT
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
         QueryCondition.lt(TestTreeBook.F_AMOUNT, UPDATED_AMOUNT)
        );
    }
    @Test
    @Transactional
    public void getAllTestTreeBooksByResetDateIsEqualToSomething() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where resetDate equals to DEFAULT_RESETDATE
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
        new QueryCondition(TestTreeBook.F_RESETDATE, QueryCondition.Operator.eq, DateUtil.formatDateTime(DEFAULT_RESETDATE), CommonConstants.TYPE_DATE)
);

        // Get all the testTreeBookList where resetDate equals to UPDATED_RESETDATE
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
        new QueryCondition(TestTreeBook.F_RESETDATE, QueryCondition.Operator.eq, DateUtil.formatDateTime(UPDATED_RESETDATE), CommonConstants.TYPE_DATE)
);
    }

    @Test
    @Transactional
    public void getAllTestTreeBooksByResetDateIsInShouldWork() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where resetDate in DEFAULT_RESETDATE or UPDATED_RESETDATE
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
        new QueryCondition(TestTreeBook.F_RESETDATE, QueryCondition.Operator.in, DateUtil.formatDateTime(DEFAULT_RESETDATE), CommonConstants.TYPE_DATE)
);

        // Get all the testTreeBookList where resetDate equals to UPDATED_RESETDATE
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
        new QueryCondition(TestTreeBook.F_RESETDATE, QueryCondition.Operator.in, DateUtil.formatDateTime(UPDATED_RESETDATE), CommonConstants.TYPE_DATE)
);
    }

    @Test
    @Transactional
    public void getAllTestTreeBooksByResetDateIsNullOrNotNull() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where resetDate is not null
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()), QueryCondition.isNotNull(TestTreeBook.F_RESETDATE));

        // Get all the testTreeBookList where resetDate is null
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()), QueryCondition.isNull(TestTreeBook.F_RESETDATE));
    }
    @Test
    @Transactional
    public void getAllTestTreeBooksByResetDateIsGreaterThanOrEqualToSomething() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where resetDate greater than or equals to DEFAULT_RESETDATE
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
        new QueryCondition(TestTreeBook.F_RESETDATE, QueryCondition.Operator.ge, DateUtil.formatDateTime(DEFAULT_RESETDATE), CommonConstants.TYPE_DATE)
);

        // Get all the testTreeBookList where resetDate greater than or equals to UPDATED_RESETDATE
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
        new QueryCondition(TestTreeBook.F_RESETDATE, QueryCondition.Operator.ge, DateUtil.formatDateTime(UPDATED_RESETDATE), CommonConstants.TYPE_DATE)
);
    }

    @Test
    @Transactional
    public void getAllTestTreeBooksByResetDateIsLessThanSomething() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where resetDate less than or equals to DEFAULT_SORT
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
        new QueryCondition(TestTreeBook.F_RESETDATE, QueryCondition.Operator.lt, DateUtil.formatDateTime(DEFAULT_RESETDATE), CommonConstants.TYPE_DATE)
);

        // Get all the testTreeBookList where resetDate less than or equals to UPDATED_SORT
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
        new QueryCondition(TestTreeBook.F_RESETDATE, QueryCondition.Operator.lt, DateUtil.formatDateTime(UPDATED_RESETDATE), CommonConstants.TYPE_DATE)
);
    }
    @Test
    @Transactional
    public void getAllTestTreeBooksByDescriptionIsEqualToSomething() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where description equals to DEFAULT_DESCRIPTION
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
        QueryCondition.eq(TestTreeBook.F_DESCRIPTION, DEFAULT_DESCRIPTION)
        );

        // Get all the testTreeBookList where description equals to UPDATED_DESCRIPTION
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
        QueryCondition.eq(TestTreeBook.F_DESCRIPTION, UPDATED_DESCRIPTION)
        );
    }

    @Test
    @Transactional
    public void getAllTestTreeBooksByDescriptionIsInShouldWork() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where description in DEFAULT_DESCRIPTION or UPDATED_DESCRIPTION
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
         QueryCondition.in(TestTreeBook.F_DESCRIPTION, Lists.newArrayList(DEFAULT_DESCRIPTION, DEFAULT_DESCRIPTION))
        );

        // Get all the testTreeBookList where description equals to UPDATED_DESCRIPTION
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()),
         QueryCondition.in(TestTreeBook.F_DESCRIPTION, Lists.newArrayList(UPDATED_DESCRIPTION))
        );
    }

    @Test
    @Transactional
    public void getAllTestTreeBooksByDescriptionIsNullOrNotNull() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        // Get all the testTreeBookList where description is not null
        defaultTestTreeBookShouldBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()), QueryCondition.isNotNull(TestTreeBook.F_DESCRIPTION));

        // Get all the testTreeBookList where description is null
        defaultTestTreeBookShouldNotBeFound(QueryCondition.eq(TestTreeBook.F_ID, testTreeBookDataVo.getId()), QueryCondition.isNull(TestTreeBook.F_DESCRIPTION));
    }

    /**
     * Executes the search, and checks that the default entity is returned
     */
    private void defaultTestTreeBookShouldBeFound(QueryCondition... queryCondition) throws Exception {
        restTestTreeBookMockMvc.perform(get(DEFAULT_API_URL).param("queryConditionJson", Json.toJSONString(Lists.newArrayList(queryCondition))))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.data.records").isArray())
            .andExpect(jsonPath("$.data.records.[*].id").value(hasItem(testTreeBookDataVo.getId())))
                                        .andExpect(jsonPath("$.data.records.[*].email").value(hasItem(DEFAULT_EMAIL)))
                .andExpect(jsonPath("$.data.records.[*].phone").value(hasItem(DEFAULT_PHONE)))
                    .andExpect(jsonPath("$.data.records.[*].number").value(hasItem(DEFAULT_NUMBER.intValue())))
                .andExpect(jsonPath("$.data.records.[*].money").value(hasItem(DEFAULT_MONEY)))
                .andExpect(jsonPath("$.data.records.[*].amount").value(hasItem(DEFAULT_AMOUNT)))
                .andExpect(jsonPath("$.data.records.[*].resetDate").value(hasItem(DateUtil.formatDateTime(DEFAULT_RESETDATE))))
                                        .andExpect(jsonPath("$.data.records.[*].description").value(hasItem(DEFAULT_DESCRIPTION)))
    ;
    }

    /**
     * Executes the search, and checks that the default entity is not returned
     */
    private void defaultTestTreeBookShouldNotBeFound(QueryCondition... queryCondition) throws Exception {
        restTestTreeBookMockMvc.perform(get(DEFAULT_API_URL).param("queryConditionJson", Json.toJSONString(Lists.newArrayList(queryCondition))))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.data.records").isArray())
            .andExpect(jsonPath("$.data.records").isEmpty());
    }


    @Test
    @Transactional
    public void getNonExistingTestTreeBook() throws Exception {
        // Get the testTreeBook
        restTestTreeBookMockMvc.perform(get(DEFAULT_API_URL+"{id}", Long.MAX_VALUE))
            .andExpect(status().isOk())
			.andExpect(jsonPath("$.data").isEmpty());
    }

    @Test
    @Transactional
    public void updateTestTreeBook() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);

        int databaseSizeBeforeUpdate = testTreeBookService.findAll().size();

        // Update the testTreeBook
        TestTreeBook updatedTestTreeBook = testTreeBookService.findOneById(testTreeBookDataVo.getId());
        // Disconnect from session so that the updates on updatedTestTreeBook are not directly saved in db
        ClassUtil.updateObj(updatedTestTreeBook, Lists.newArrayList(
		 TestTreeBook.F_PARENTID
		,TestTreeBook.F_NAME
		,TestTreeBook.F_SORT
		,TestTreeBook.F_AUTHOR
		,TestTreeBook.F_EMAIL
		,TestTreeBook.F_PHONE
		,TestTreeBook.F_ACTIVATED
		,TestTreeBook.F_NUMBER
		,TestTreeBook.F_MONEY
		,TestTreeBook.F_AMOUNT
		,TestTreeBook.F_RESETDATE
		,TestTreeBook.F_DESCRIPTION
        ), 
	
		 UPDATED_PARENTID
	
	
		,UPDATED_NAME
	
		,UPDATED_SORT
	
	
		,UPDATED_AUTHOR
	
		,UPDATED_EMAIL
	
		,UPDATED_PHONE
	
		,UPDATED_ACTIVATED
	
		,UPDATED_NUMBER
	
		,UPDATED_MONEY
	
		,UPDATED_AMOUNT
	
		,UPDATED_RESETDATE
	
	
	
	
	
	
	
		,UPDATED_DESCRIPTION
	);

        TestTreeBookDataVo testTreeBookVo = testTreeBookService.copyBeanToVo(updatedTestTreeBook);
        restTestTreeBookMockMvc.perform(post(DEFAULT_API_URL)
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(testTreeBookVo)))
            .andExpect(status().isOk());

        // Validate the TestTreeBook in the database
        List<TestTreeBook> testTreeBookList = testTreeBookService.findAll();
        assertThat(testTreeBookList).hasSize(databaseSizeBeforeUpdate);

        TestTreeBook testTestTreeBook = testTreeBookList.stream().filter(item->testTreeBookDataVo.getId().equals(item.getId())).findAny().get();
		assertThat(testTestTreeBook.getParentId()).isEqualTo(UPDATED_PARENTID);
		assertThat(testTestTreeBook.getName()).isEqualTo(UPDATED_NAME);
		assertThat(testTestTreeBook.getSort()).isEqualTo(UPDATED_SORT);
		assertThat(testTestTreeBook.getAuthor()).isEqualTo(UPDATED_AUTHOR);
		assertThat(testTestTreeBook.getEmail()).isEqualTo(UPDATED_EMAIL);
		assertThat(testTestTreeBook.getPhone()).isEqualTo(UPDATED_PHONE);
		assertThat(testTestTreeBook.getActivated()).isEqualTo(UPDATED_ACTIVATED);
		assertThat(testTestTreeBook.getNumber()).isEqualTo(UPDATED_NUMBER);
		assertThat(testTestTreeBook.getMoney()).isEqualTo(UPDATED_MONEY);
		assertThat(testTestTreeBook.getAmount()).isEqualTo(UPDATED_AMOUNT);
		assertThat(testTestTreeBook.getResetDate()).isEqualTo(UPDATED_RESETDATE);
		assertThat(testTestTreeBook.getDescription()).isEqualTo(UPDATED_DESCRIPTION);
    }


    @Test
    @Transactional
    public void deleteTestTreeBook() throws Exception {
        // Initialize the database
        testTreeBookService.save(testTreeBookDataVo);
        int databaseSizeBeforeDelete = testTreeBookService.findAll().size();

        // Get the testTreeBook
        restTestTreeBookMockMvc.perform(delete(DEFAULT_API_URL+"{id}", testTreeBookDataVo.getId())
            .accept(TestUtil.APPLICATION_JSON_UTF8))
            .andExpect(status().isOk());

        // Validate the database is empty
        List<TestTreeBook> testTreeBookList = testTreeBookService.findAll();
        assertThat(testTreeBookList).hasSize(databaseSizeBeforeDelete - 1);
    }

    @Test
    @Transactional
    public void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(TestTreeBook.class);
        TestTreeBook testTreeBook1 = new TestTreeBook();
        testTreeBook1.setId("id1");
        TestTreeBook testTreeBook2 = new TestTreeBook();
        testTreeBook2.setId(testTreeBook1.getId());
        assertThat(testTreeBook1).isEqualTo(testTreeBook2);
        testTreeBook2.setId("id2");
        assertThat(testTreeBook1).isNotEqualTo(testTreeBook2);
        testTreeBook1.setId(null);
        assertThat(testTreeBook1).isNotEqualTo(testTreeBook2);
    }

}
