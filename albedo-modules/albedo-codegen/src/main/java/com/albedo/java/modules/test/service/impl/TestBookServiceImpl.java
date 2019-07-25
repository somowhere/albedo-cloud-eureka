/**
 * Copyright &copy; 2018 <a href="https://github.com/somewhereMrli/albedo-boot">albedo-boot</a> All rights reserved.
 */
package com.albedo.java.modules.test.service.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.albedo.java.common.persistence.service.impl.DataVoServiceImpl;
import com.albedo.java.modules.test.service.TestBookService;
import com.albedo.java.modules.test.domain.TestBook;
import com.albedo.java.modules.test.domain.vo.TestBookDataVo;
import com.albedo.java.modules.test.repository.TestBookRepository;

/**
 * 测试书籍管ServiceImpl 测试书籍
 * @author admin
 * @version 2019-07-25 17:51:48
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class TestBookServiceImpl extends DataVoServiceImpl<TestBookRepository, TestBook, String, TestBookDataVo> implements TestBookService{

}