/**
 * Copyright &copy; 2018 <a href="https://github.com/somewhereMrli/albedo-boot">albedo-boot</a> All rights reserved.
 */
package com.albedo.java.modules.test.web;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.Json;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.core.vo.QueryCondition;
import com.albedo.java.common.persistence.DynamicSpecifications;
import com.albedo.java.common.persistence.SpecificationDetail;
import com.albedo.java.common.persistence.domain.BaseEntity;
import com.albedo.java.common.core.util.DateUtil;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.exception.GlobalExceptionHandler;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.ClassUtil;
import com.albedo.java.modules.test.domain.TestBook;
import com.albedo.java.modules.test.domain.vo.TestBookDataVo;
import com.albedo.java.modules.test.repository.TestBookRepository;
import com.albedo.java.modules.test.service.TestBookService;
import com.albedo.java.modules.test.web.TestBookResource;
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
 * Test class for the TestBookResource REST controller.
 *
 * @see TestBookResource
 */
@SpringBootTest(classes = com.albedo.java.modules.AlbedoGenApplication.class)
@Slf4j
public class TestBookResourceIntTest {

    private String DEFAULT_API_URL;
	/** DEFAULT_TITLE title_  :  标题 */
	private static final String DEFAULT_TITLE = "A";
	/** UPDATED_TITLE title_  :  标题 */
    private static final String UPDATED_TITLE = "B";
	/** DEFAULT_AUTHOR author_  :  作者 */
	private static final String DEFAULT_AUTHOR = "A";
	/** UPDATED_AUTHOR author_  :  作者 */
    private static final String UPDATED_AUTHOR = "B";
	/** DEFAULT_NAME name_  :  名称 */
	private static final String DEFAULT_NAME = "A";
	/** UPDATED_NAME name_  :  名称 */
    private static final String UPDATED_NAME = "B";
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
	private TestBookService testBookService;

	private MockMvc restTestBookMockMvc;
	@Autowired
	private MappingJackson2HttpMessageConverter jacksonMessageConverter;
	@Autowired
	private GlobalExceptionHandler globalExceptionHandler;

	private TestBookDataVo testBookDataVo;

	private TestBookDataVo anotherTestBookDataVo = new TestBookDataVo();
	@BeforeEach
	public void setup() {
		DEFAULT_API_URL = "/testBook/";
		MockitoAnnotations.initMocks(this);
		final TestBookResource testBookResource = new TestBookResource(testBookService);
		this.restTestBookMockMvc = MockMvcBuilders.standaloneSetup(testBookResource)
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
    public static TestBookDataVo createEntity() {
        TestBookDataVo testBookDataVo = ClassUtil.createObj(TestBookDataVo.class, Lists.newArrayList(
		 TestBookDataVo.F_TITLE
		,TestBookDataVo.F_AUTHOR
		,TestBookDataVo.F_NAME
		,TestBookDataVo.F_EMAIL
		,TestBookDataVo.F_PHONE
		,TestBookDataVo.F_ACTIVATED
		,TestBookDataVo.F_NUMBER
		,TestBookDataVo.F_MONEY
		,TestBookDataVo.F_AMOUNT
		,TestBookDataVo.F_RESETDATE
		,TestBookDataVo.F_DESCRIPTION
        ), 
	
		 DEFAULT_TITLE
	
		,DEFAULT_AUTHOR
	
		,DEFAULT_NAME
	
		,DEFAULT_EMAIL
	
		,DEFAULT_PHONE
	
		,DEFAULT_ACTIVATED
	
		,DEFAULT_NUMBER
	
		,DEFAULT_MONEY
	
		,DEFAULT_AMOUNT
	
		,DEFAULT_RESETDATE
	
	
	
	
	
		,DEFAULT_DESCRIPTION
	
	
	);
        return testBookDataVo;
    }

    @BeforeEach
    public void initTest() {
        testBookDataVo = createEntity();
    }

    @Test
    @Transactional
    public void createTestBook() throws Exception {
        int databaseSizeBeforeCreate = testBookService.findAll().size();
        // Create the TestBook
        restTestBookMockMvc.perform(post(DEFAULT_API_URL)
			.param(PageModel.F_DESC, TestBook.F_SQL_CREATEDDATE)
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(testBookDataVo)))
            .andExpect(status().isOk());
        ;
        // Validate the TestBook in the database
        List<TestBook> testBookList = testBookService.findAll(
            Wrappers.<TestBook>query().lambda().orderByAsc(
				TestBook::getCreatedDate
			)
        );
        assertThat(testBookList).hasSize(databaseSizeBeforeCreate + 1);
        TestBook testTestBook = testBookList.get(testBookList.size() - 1);
		assertThat(testTestBook.getTitle()).isEqualTo(DEFAULT_TITLE);
		assertThat(testTestBook.getAuthor()).isEqualTo(DEFAULT_AUTHOR);
		assertThat(testTestBook.getName()).isEqualTo(DEFAULT_NAME);
		assertThat(testTestBook.getEmail()).isEqualTo(DEFAULT_EMAIL);
		assertThat(testTestBook.getPhone()).isEqualTo(DEFAULT_PHONE);
		assertThat(testTestBook.getActivated()).isEqualTo(DEFAULT_ACTIVATED);
		assertThat(testTestBook.getNumber()).isEqualTo(DEFAULT_NUMBER);
		assertThat(testTestBook.getMoney()).isEqualTo(DEFAULT_MONEY);
		assertThat(testTestBook.getAmount()).isEqualTo(DEFAULT_AMOUNT);
		assertThat(testTestBook.getResetDate()).isEqualTo(DEFAULT_RESETDATE);
		assertThat(testTestBook.getDescription()).isEqualTo(DEFAULT_DESCRIPTION);
    }

    @Test
    @Transactional
    public void checkAuthorIsRequired() throws Exception {
        int databaseSizeBeforeTest = testBookService.findAll().size();
        // set the field null
        testBookDataVo.setAuthor(null);

        // Create the TestBook, which fails.

        restTestBookMockMvc.perform(post(DEFAULT_API_URL)
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(testBookDataVo)))
            .andExpect(status().isBadRequest());

        List<TestBook> testBookList = testBookService.findAll();
        assertThat(testBookList).hasSize(databaseSizeBeforeTest);
    }
    @Test
    @Transactional
    public void checkActivatedIsRequired() throws Exception {
        int databaseSizeBeforeTest = testBookService.findAll().size();
        // set the field null
        testBookDataVo.setActivated(null);

        // Create the TestBook, which fails.

        restTestBookMockMvc.perform(post(DEFAULT_API_URL)
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(testBookDataVo)))
            .andExpect(status().isBadRequest());

        List<TestBook> testBookList = testBookService.findAll();
        assertThat(testBookList).hasSize(databaseSizeBeforeTest);
    }


    @Test
    @Transactional
    public void getAllTestBooks() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        // Get all the testBookList
        restTestBookMockMvc.perform(get(DEFAULT_API_URL))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.data.records.[*].id").value(hasItem(testBookDataVo.getId())))
                .andExpect(jsonPath("$.data.records.[*].title").value(hasItem(DEFAULT_TITLE)))
                    .andExpect(jsonPath("$.data.records.[*].name").value(hasItem(DEFAULT_NAME)))
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
    public void getTestBook() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        // Get the testBook
        restTestBookMockMvc.perform(get(DEFAULT_API_URL+"{id}", testBookDataVo.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.data.id").value(testBookDataVo.getId()))
                .andExpect(jsonPath("$.data.title").value(DEFAULT_TITLE))
                    .andExpect(jsonPath("$.data.name").value(DEFAULT_NAME))
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
    public void getAllTestBooksByTitleIsEqualToSomething() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        // Get all the testBookList where title equals to DEFAULT_TITLE
        defaultTestBookShouldBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
        QueryCondition.eq(TestBook.F_TITLE, DEFAULT_TITLE)
        );

        // Get all the testBookList where title equals to UPDATED_TITLE
        defaultTestBookShouldNotBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
        QueryCondition.eq(TestBook.F_TITLE, UPDATED_TITLE)
        );
    }

    @Test
    @Transactional
    public void getAllTestBooksByTitleIsInShouldWork() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        // Get all the testBookList where title in DEFAULT_TITLE or UPDATED_TITLE
        defaultTestBookShouldBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
         QueryCondition.in(TestBook.F_TITLE, Lists.newArrayList(DEFAULT_TITLE, DEFAULT_TITLE))
        );

        // Get all the testBookList where title equals to UPDATED_TITLE
        defaultTestBookShouldNotBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
         QueryCondition.in(TestBook.F_TITLE, Lists.newArrayList(UPDATED_TITLE))
        );
    }

    @Test
    @Transactional
    public void getAllTestBooksByTitleIsNullOrNotNull() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        // Get all the testBookList where title is not null
        defaultTestBookShouldBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()), QueryCondition.isNotNull(TestBook.F_TITLE));

        // Get all the testBookList where title is null
        defaultTestBookShouldNotBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()), QueryCondition.isNull(TestBook.F_TITLE));
    }
    @Test
    @Transactional
    public void getAllTestBooksByNameIsEqualToSomething() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        // Get all the testBookList where name equals to DEFAULT_NAME
        defaultTestBookShouldBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
        QueryCondition.eq(TestBook.F_NAME, DEFAULT_NAME)
        );

        // Get all the testBookList where name equals to UPDATED_NAME
        defaultTestBookShouldNotBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
        QueryCondition.eq(TestBook.F_NAME, UPDATED_NAME)
        );
    }

    @Test
    @Transactional
    public void getAllTestBooksByNameIsInShouldWork() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        // Get all the testBookList where name in DEFAULT_NAME or UPDATED_NAME
        defaultTestBookShouldBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
         QueryCondition.in(TestBook.F_NAME, Lists.newArrayList(DEFAULT_NAME, DEFAULT_NAME))
        );

        // Get all the testBookList where name equals to UPDATED_NAME
        defaultTestBookShouldNotBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
         QueryCondition.in(TestBook.F_NAME, Lists.newArrayList(UPDATED_NAME))
        );
    }

    @Test
    @Transactional
    public void getAllTestBooksByNameIsNullOrNotNull() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        // Get all the testBookList where name is not null
        defaultTestBookShouldBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()), QueryCondition.isNotNull(TestBook.F_NAME));

        // Get all the testBookList where name is null
        defaultTestBookShouldNotBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()), QueryCondition.isNull(TestBook.F_NAME));
    }
    @Test
    @Transactional
    public void getAllTestBooksByEmailIsEqualToSomething() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        // Get all the testBookList where email equals to DEFAULT_EMAIL
        defaultTestBookShouldBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
        QueryCondition.eq(TestBook.F_EMAIL, DEFAULT_EMAIL)
        );

        // Get all the testBookList where email equals to UPDATED_EMAIL
        defaultTestBookShouldNotBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
        QueryCondition.eq(TestBook.F_EMAIL, UPDATED_EMAIL)
        );
    }

    @Test
    @Transactional
    public void getAllTestBooksByEmailIsInShouldWork() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        // Get all the testBookList where email in DEFAULT_EMAIL or UPDATED_EMAIL
        defaultTestBookShouldBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
         QueryCondition.in(TestBook.F_EMAIL, Lists.newArrayList(DEFAULT_EMAIL, DEFAULT_EMAIL))
        );

        // Get all the testBookList where email equals to UPDATED_EMAIL
        defaultTestBookShouldNotBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
         QueryCondition.in(TestBook.F_EMAIL, Lists.newArrayList(UPDATED_EMAIL))
        );
    }

    @Test
    @Transactional
    public void getAllTestBooksByEmailIsNullOrNotNull() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        // Get all the testBookList where email is not null
        defaultTestBookShouldBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()), QueryCondition.isNotNull(TestBook.F_EMAIL));

        // Get all the testBookList where email is null
        defaultTestBookShouldNotBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()), QueryCondition.isNull(TestBook.F_EMAIL));
    }
    @Test
    @Transactional
    public void getAllTestBooksByPhoneIsEqualToSomething() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        // Get all the testBookList where phone equals to DEFAULT_PHONE
        defaultTestBookShouldBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
        QueryCondition.eq(TestBook.F_PHONE, DEFAULT_PHONE)
        );

        // Get all the testBookList where phone equals to UPDATED_PHONE
        defaultTestBookShouldNotBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
        QueryCondition.eq(TestBook.F_PHONE, UPDATED_PHONE)
        );
    }

    @Test
    @Transactional
    public void getAllTestBooksByPhoneIsInShouldWork() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        // Get all the testBookList where phone in DEFAULT_PHONE or UPDATED_PHONE
        defaultTestBookShouldBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
         QueryCondition.in(TestBook.F_PHONE, Lists.newArrayList(DEFAULT_PHONE, DEFAULT_PHONE))
        );

        // Get all the testBookList where phone equals to UPDATED_PHONE
        defaultTestBookShouldNotBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
         QueryCondition.in(TestBook.F_PHONE, Lists.newArrayList(UPDATED_PHONE))
        );
    }

    @Test
    @Transactional
    public void getAllTestBooksByPhoneIsNullOrNotNull() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        // Get all the testBookList where phone is not null
        defaultTestBookShouldBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()), QueryCondition.isNotNull(TestBook.F_PHONE));

        // Get all the testBookList where phone is null
        defaultTestBookShouldNotBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()), QueryCondition.isNull(TestBook.F_PHONE));
    }
    @Test
    @Transactional
    public void getAllTestBooksByNumberIsEqualToSomething() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        // Get all the testBookList where number equals to DEFAULT_NUMBER
        defaultTestBookShouldBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
        QueryCondition.eq(TestBook.F_NUMBER, DEFAULT_NUMBER)
        );

        // Get all the testBookList where number equals to UPDATED_NUMBER
        defaultTestBookShouldNotBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
        QueryCondition.eq(TestBook.F_NUMBER, UPDATED_NUMBER)
        );
    }

    @Test
    @Transactional
    public void getAllTestBooksByNumberIsInShouldWork() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        // Get all the testBookList where number in DEFAULT_NUMBER or UPDATED_NUMBER
        defaultTestBookShouldBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
         QueryCondition.in(TestBook.F_NUMBER, Lists.newArrayList(DEFAULT_NUMBER, DEFAULT_NUMBER))
        );

        // Get all the testBookList where number equals to UPDATED_NUMBER
        defaultTestBookShouldNotBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
         QueryCondition.in(TestBook.F_NUMBER, Lists.newArrayList(UPDATED_NUMBER))
        );
    }

    @Test
    @Transactional
    public void getAllTestBooksByNumberIsNullOrNotNull() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        // Get all the testBookList where number is not null
        defaultTestBookShouldBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()), QueryCondition.isNotNull(TestBook.F_NUMBER));

        // Get all the testBookList where number is null
        defaultTestBookShouldNotBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()), QueryCondition.isNull(TestBook.F_NUMBER));
    }
    @Test
    @Transactional
    public void getAllTestBooksByMoneyIsEqualToSomething() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        // Get all the testBookList where money equals to DEFAULT_MONEY
        defaultTestBookShouldBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
        QueryCondition.eq(TestBook.F_MONEY, DEFAULT_MONEY)
        );

        // Get all the testBookList where money equals to UPDATED_MONEY
        defaultTestBookShouldNotBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
        QueryCondition.eq(TestBook.F_MONEY, UPDATED_MONEY)
        );
    }

    @Test
    @Transactional
    public void getAllTestBooksByMoneyIsInShouldWork() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        // Get all the testBookList where money in DEFAULT_MONEY or UPDATED_MONEY
        defaultTestBookShouldBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
         QueryCondition.in(TestBook.F_MONEY, Lists.newArrayList(DEFAULT_MONEY, DEFAULT_MONEY))
        );

        // Get all the testBookList where money equals to UPDATED_MONEY
        defaultTestBookShouldNotBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
         QueryCondition.in(TestBook.F_MONEY, Lists.newArrayList(UPDATED_MONEY))
        );
    }

    @Test
    @Transactional
    public void getAllTestBooksByMoneyIsNullOrNotNull() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        // Get all the testBookList where money is not null
        defaultTestBookShouldBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()), QueryCondition.isNotNull(TestBook.F_MONEY));

        // Get all the testBookList where money is null
        defaultTestBookShouldNotBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()), QueryCondition.isNull(TestBook.F_MONEY));
    }
    @Test
    @Transactional
    public void getAllTestBooksByMoneyIsGreaterThanOrEqualToSomething() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        // Get all the testBookList where money greater than or equals to DEFAULT_MONEY
        defaultTestBookShouldBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
         QueryCondition.ge(TestBook.F_MONEY, DEFAULT_MONEY)
        );

        // Get all the testBookList where money greater than or equals to UPDATED_MONEY
        defaultTestBookShouldNotBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
         QueryCondition.ge(TestBook.F_MONEY, UPDATED_MONEY)
        );
    }

    @Test
    @Transactional
    public void getAllTestBooksByMoneyIsLessThanSomething() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        // Get all the testBookList where money less than or equals to DEFAULT_SORT
        defaultTestBookShouldNotBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
         QueryCondition.lt(TestBook.F_MONEY, DEFAULT_MONEY)
        );

        // Get all the testBookList where money less than or equals to UPDATED_SORT
        defaultTestBookShouldBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
         QueryCondition.lt(TestBook.F_MONEY, UPDATED_MONEY)
        );
    }
    @Test
    @Transactional
    public void getAllTestBooksByAmountIsEqualToSomething() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        // Get all the testBookList where amount equals to DEFAULT_AMOUNT
        defaultTestBookShouldBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
        QueryCondition.eq(TestBook.F_AMOUNT, DEFAULT_AMOUNT)
        );

        // Get all the testBookList where amount equals to UPDATED_AMOUNT
        defaultTestBookShouldNotBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
        QueryCondition.eq(TestBook.F_AMOUNT, UPDATED_AMOUNT)
        );
    }

    @Test
    @Transactional
    public void getAllTestBooksByAmountIsInShouldWork() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        // Get all the testBookList where amount in DEFAULT_AMOUNT or UPDATED_AMOUNT
        defaultTestBookShouldBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
         QueryCondition.in(TestBook.F_AMOUNT, Lists.newArrayList(DEFAULT_AMOUNT, DEFAULT_AMOUNT))
        );

        // Get all the testBookList where amount equals to UPDATED_AMOUNT
        defaultTestBookShouldNotBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
         QueryCondition.in(TestBook.F_AMOUNT, Lists.newArrayList(UPDATED_AMOUNT))
        );
    }

    @Test
    @Transactional
    public void getAllTestBooksByAmountIsNullOrNotNull() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        // Get all the testBookList where amount is not null
        defaultTestBookShouldBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()), QueryCondition.isNotNull(TestBook.F_AMOUNT));

        // Get all the testBookList where amount is null
        defaultTestBookShouldNotBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()), QueryCondition.isNull(TestBook.F_AMOUNT));
    }
    @Test
    @Transactional
    public void getAllTestBooksByAmountIsGreaterThanOrEqualToSomething() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        // Get all the testBookList where amount greater than or equals to DEFAULT_AMOUNT
        defaultTestBookShouldBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
         QueryCondition.ge(TestBook.F_AMOUNT, DEFAULT_AMOUNT)
        );

        // Get all the testBookList where amount greater than or equals to UPDATED_AMOUNT
        defaultTestBookShouldNotBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
         QueryCondition.ge(TestBook.F_AMOUNT, UPDATED_AMOUNT)
        );
    }

    @Test
    @Transactional
    public void getAllTestBooksByAmountIsLessThanSomething() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        // Get all the testBookList where amount less than or equals to DEFAULT_SORT
        defaultTestBookShouldNotBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
         QueryCondition.lt(TestBook.F_AMOUNT, DEFAULT_AMOUNT)
        );

        // Get all the testBookList where amount less than or equals to UPDATED_SORT
        defaultTestBookShouldBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
         QueryCondition.lt(TestBook.F_AMOUNT, UPDATED_AMOUNT)
        );
    }
    @Test
    @Transactional
    public void getAllTestBooksByResetDateIsEqualToSomething() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        // Get all the testBookList where resetDate equals to DEFAULT_RESETDATE
        defaultTestBookShouldBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
        new QueryCondition(TestBook.F_RESETDATE, QueryCondition.Operator.eq, DateUtil.formatDateTime(DEFAULT_RESETDATE), CommonConstants.TYPE_DATE)
);

        // Get all the testBookList where resetDate equals to UPDATED_RESETDATE
        defaultTestBookShouldNotBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
        new QueryCondition(TestBook.F_RESETDATE, QueryCondition.Operator.eq, DateUtil.formatDateTime(UPDATED_RESETDATE), CommonConstants.TYPE_DATE)
);
    }

    @Test
    @Transactional
    public void getAllTestBooksByResetDateIsInShouldWork() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        // Get all the testBookList where resetDate in DEFAULT_RESETDATE or UPDATED_RESETDATE
        defaultTestBookShouldBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
        new QueryCondition(TestBook.F_RESETDATE, QueryCondition.Operator.in, DateUtil.formatDateTime(DEFAULT_RESETDATE), CommonConstants.TYPE_DATE)
);

        // Get all the testBookList where resetDate equals to UPDATED_RESETDATE
        defaultTestBookShouldNotBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
        new QueryCondition(TestBook.F_RESETDATE, QueryCondition.Operator.in, DateUtil.formatDateTime(UPDATED_RESETDATE), CommonConstants.TYPE_DATE)
);
    }

    @Test
    @Transactional
    public void getAllTestBooksByResetDateIsNullOrNotNull() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        // Get all the testBookList where resetDate is not null
        defaultTestBookShouldBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()), QueryCondition.isNotNull(TestBook.F_RESETDATE));

        // Get all the testBookList where resetDate is null
        defaultTestBookShouldNotBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()), QueryCondition.isNull(TestBook.F_RESETDATE));
    }
    @Test
    @Transactional
    public void getAllTestBooksByResetDateIsGreaterThanOrEqualToSomething() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        // Get all the testBookList where resetDate greater than or equals to DEFAULT_RESETDATE
        defaultTestBookShouldBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
        new QueryCondition(TestBook.F_RESETDATE, QueryCondition.Operator.ge, DateUtil.formatDateTime(DEFAULT_RESETDATE), CommonConstants.TYPE_DATE)
);

        // Get all the testBookList where resetDate greater than or equals to UPDATED_RESETDATE
        defaultTestBookShouldNotBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
        new QueryCondition(TestBook.F_RESETDATE, QueryCondition.Operator.ge, DateUtil.formatDateTime(UPDATED_RESETDATE), CommonConstants.TYPE_DATE)
);
    }

    @Test
    @Transactional
    public void getAllTestBooksByResetDateIsLessThanSomething() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        // Get all the testBookList where resetDate less than or equals to DEFAULT_SORT
        defaultTestBookShouldNotBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
        new QueryCondition(TestBook.F_RESETDATE, QueryCondition.Operator.lt, DateUtil.formatDateTime(DEFAULT_RESETDATE), CommonConstants.TYPE_DATE)
);

        // Get all the testBookList where resetDate less than or equals to UPDATED_SORT
        defaultTestBookShouldBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
        new QueryCondition(TestBook.F_RESETDATE, QueryCondition.Operator.lt, DateUtil.formatDateTime(UPDATED_RESETDATE), CommonConstants.TYPE_DATE)
);
    }
    @Test
    @Transactional
    public void getAllTestBooksByDescriptionIsEqualToSomething() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        // Get all the testBookList where description equals to DEFAULT_DESCRIPTION
        defaultTestBookShouldBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
        QueryCondition.eq(TestBook.F_DESCRIPTION, DEFAULT_DESCRIPTION)
        );

        // Get all the testBookList where description equals to UPDATED_DESCRIPTION
        defaultTestBookShouldNotBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
        QueryCondition.eq(TestBook.F_DESCRIPTION, UPDATED_DESCRIPTION)
        );
    }

    @Test
    @Transactional
    public void getAllTestBooksByDescriptionIsInShouldWork() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        // Get all the testBookList where description in DEFAULT_DESCRIPTION or UPDATED_DESCRIPTION
        defaultTestBookShouldBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
         QueryCondition.in(TestBook.F_DESCRIPTION, Lists.newArrayList(DEFAULT_DESCRIPTION, DEFAULT_DESCRIPTION))
        );

        // Get all the testBookList where description equals to UPDATED_DESCRIPTION
        defaultTestBookShouldNotBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()),
         QueryCondition.in(TestBook.F_DESCRIPTION, Lists.newArrayList(UPDATED_DESCRIPTION))
        );
    }

    @Test
    @Transactional
    public void getAllTestBooksByDescriptionIsNullOrNotNull() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        // Get all the testBookList where description is not null
        defaultTestBookShouldBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()), QueryCondition.isNotNull(TestBook.F_DESCRIPTION));

        // Get all the testBookList where description is null
        defaultTestBookShouldNotBeFound(QueryCondition.eq(TestBook.F_ID, testBookDataVo.getId()), QueryCondition.isNull(TestBook.F_DESCRIPTION));
    }

    /**
     * Executes the search, and checks that the default entity is returned
     */
    private void defaultTestBookShouldBeFound(QueryCondition... queryCondition) throws Exception {
        restTestBookMockMvc.perform(get(DEFAULT_API_URL).param("queryConditionJson", Json.toJSONString(Lists.newArrayList(queryCondition))))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.data.records").isArray())
            .andExpect(jsonPath("$.data.records.[*].id").value(hasItem(testBookDataVo.getId())))
                .andExpect(jsonPath("$.data.records.[*].title").value(hasItem(DEFAULT_TITLE)))
                    .andExpect(jsonPath("$.data.records.[*].name").value(hasItem(DEFAULT_NAME)))
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
    private void defaultTestBookShouldNotBeFound(QueryCondition... queryCondition) throws Exception {
        restTestBookMockMvc.perform(get(DEFAULT_API_URL).param("queryConditionJson", Json.toJSONString(Lists.newArrayList(queryCondition))))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.data.records").isArray())
            .andExpect(jsonPath("$.data.records").isEmpty());
    }


    @Test
    @Transactional
    public void getNonExistingTestBook() throws Exception {
        // Get the testBook
        restTestBookMockMvc.perform(get(DEFAULT_API_URL+"{id}", Long.MAX_VALUE))
            .andExpect(status().isOk())
			.andExpect(jsonPath("$.data").isEmpty());
    }

    @Test
    @Transactional
    public void updateTestBook() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);

        int databaseSizeBeforeUpdate = testBookService.findAll().size();

        // Update the testBook
        TestBook updatedTestBook = testBookService.findOneById(testBookDataVo.getId());
        // Disconnect from session so that the updates on updatedTestBook are not directly saved in db
        ClassUtil.updateObj(updatedTestBook, Lists.newArrayList(
		 TestBook.F_TITLE
		,TestBook.F_AUTHOR
		,TestBook.F_NAME
		,TestBook.F_EMAIL
		,TestBook.F_PHONE
		,TestBook.F_ACTIVATED
		,TestBook.F_NUMBER
		,TestBook.F_MONEY
		,TestBook.F_AMOUNT
		,TestBook.F_RESETDATE
		,TestBook.F_DESCRIPTION
        ), 
	
		 UPDATED_TITLE
	
		,UPDATED_AUTHOR
	
		,UPDATED_NAME
	
		,UPDATED_EMAIL
	
		,UPDATED_PHONE
	
		,UPDATED_ACTIVATED
	
		,UPDATED_NUMBER
	
		,UPDATED_MONEY
	
		,UPDATED_AMOUNT
	
		,UPDATED_RESETDATE
	
	
	
	
	
		,UPDATED_DESCRIPTION
	
	
	);

        TestBookDataVo testBookVo = testBookService.copyBeanToVo(updatedTestBook);
        restTestBookMockMvc.perform(post(DEFAULT_API_URL)
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(testBookVo)))
            .andExpect(status().isOk());

        // Validate the TestBook in the database
        List<TestBook> testBookList = testBookService.findAll();
        assertThat(testBookList).hasSize(databaseSizeBeforeUpdate);

        TestBook testTestBook = testBookList.stream().filter(item->testBookDataVo.getId().equals(item.getId())).findAny().get();
		assertThat(testTestBook.getTitle()).isEqualTo(UPDATED_TITLE);
		assertThat(testTestBook.getAuthor()).isEqualTo(UPDATED_AUTHOR);
		assertThat(testTestBook.getName()).isEqualTo(UPDATED_NAME);
		assertThat(testTestBook.getEmail()).isEqualTo(UPDATED_EMAIL);
		assertThat(testTestBook.getPhone()).isEqualTo(UPDATED_PHONE);
		assertThat(testTestBook.getActivated()).isEqualTo(UPDATED_ACTIVATED);
		assertThat(testTestBook.getNumber()).isEqualTo(UPDATED_NUMBER);
		assertThat(testTestBook.getMoney()).isEqualTo(UPDATED_MONEY);
		assertThat(testTestBook.getAmount()).isEqualTo(UPDATED_AMOUNT);
		assertThat(testTestBook.getResetDate()).isEqualTo(UPDATED_RESETDATE);
		assertThat(testTestBook.getDescription()).isEqualTo(UPDATED_DESCRIPTION);
    }


    @Test
    @Transactional
    public void deleteTestBook() throws Exception {
        // Initialize the database
        testBookService.save(testBookDataVo);
        int databaseSizeBeforeDelete = testBookService.findAll().size();

        // Get the testBook
        restTestBookMockMvc.perform(delete(DEFAULT_API_URL+"{id}", testBookDataVo.getId())
            .accept(TestUtil.APPLICATION_JSON_UTF8))
            .andExpect(status().isOk());

        // Validate the database is empty
        List<TestBook> testBookList = testBookService.findAll();
        assertThat(testBookList).hasSize(databaseSizeBeforeDelete - 1);
    }

    @Test
    @Transactional
    public void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(TestBook.class);
        TestBook testBook1 = new TestBook();
        testBook1.setId("id1");
        TestBook testBook2 = new TestBook();
        testBook2.setId(testBook1.getId());
        assertThat(testBook1).isEqualTo(testBook2);
        testBook2.setId("id2");
        assertThat(testBook1).isNotEqualTo(testBook2);
        testBook1.setId(null);
        assertThat(testBook1).isNotEqualTo(testBook2);
    }

}