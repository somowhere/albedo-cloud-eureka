package com.albedo.java;

import cn.hutool.core.codec.Base64;
import org.jasypt.encryption.StringEncryptor;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.web.WebAppConfiguration;

public class Base64Test {


	@Test
	public void getPass() {


		System.out.println(Base64.encode("albedo:albedo"));

	}

}
