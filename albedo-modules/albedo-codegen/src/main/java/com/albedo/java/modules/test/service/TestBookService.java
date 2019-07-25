/**
 * Copyright &copy; 2018 <a href="https://github.com/somewhereMrli/albedo-boot">albedo-boot</a> All rights reserved.
 */
package com.albedo.java.modules.test.service;

import com.albedo.java.common.persistence.service.DataVoService;
import com.albedo.java.modules.test.domain.TestBook;
import com.albedo.java.modules.test.domain.vo.TestBookDataVo;
import com.albedo.java.modules.test.repository.TestBookRepository;

/**
 * 测试书籍管Service 测试书籍
 * @author admin
 * @version 2019-07-25 17:51:48
 */
public interface TestBookService extends DataVoService<TestBookRepository, TestBook, String, TestBookDataVo>{

}