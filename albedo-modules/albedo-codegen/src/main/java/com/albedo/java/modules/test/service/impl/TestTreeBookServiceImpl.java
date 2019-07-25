/**
 * Copyright &copy; 2018 <a href="https://github.com/somewhereMrli/albedo-boot">albedo-boot</a> All rights reserved.
 */
package com.albedo.java.modules.test.service.impl;


import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.albedo.java.common.persistence.service.impl.TreeVoServiceImpl;
import com.albedo.java.modules.test.domain.TestTreeBook;
import com.albedo.java.modules.test.domain.vo.TestTreeBookDataVo;
import com.albedo.java.modules.test.repository.TestTreeBookRepository;
import com.albedo.java.modules.test.service.TestTreeBookService;


/**
 * 测试树书管Service 测试树书
 * @author admin
 * @version 2019-07-25 20:28:39
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class TestTreeBookServiceImpl extends TreeVoServiceImpl<TestTreeBookRepository, TestTreeBook, TestTreeBookDataVo> implements TestTreeBookService{


}