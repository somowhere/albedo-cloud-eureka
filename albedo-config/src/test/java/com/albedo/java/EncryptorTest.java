package com.albedo.java;

import com.albedo.java.config.AlbedoConfigApplication;
import org.jasypt.encryption.StringEncryptor;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringBootTest(classes = AlbedoConfigApplication.class)
@WebAppConfiguration
public class EncryptorTest {

	@Autowired
	StringEncryptor encryptor;

	/**
	 * albedo:ToJTk3p6JF+h0gsHeHVRoQ==
	 * albedo1:sGfB6KY7Zq0BTfwbWYxnWw==
	 * gen:FGKBtFgGcI+XAg5c+7EAJg==
	 * gen1:PE5+ODGIk7rfbiaZXHVhow==
	 * app:auouy8Jb/Fat5gUe6ZPObA==
	 * app1:rx3fzaHBQSaXX0UptjhKUA==
	 * daemon:4kJuzb5ms1VTlf1VhpftCQ==
	 * daemon1:NNYYGamSt/R8ITj+Bm6vDg==
	 */
	@Test
	public void getPass() {

		String albedo = encryptor.encrypt("albedo");
		String albedo1 = encryptor.encrypt("albedo");
		System.out.println("albedo:"+albedo);
		System.out.println("albedo1:"+albedo1);


		String gen = encryptor.encrypt("gen");
		String gen1 = encryptor.encrypt("gen");
		System.out.println("gen:"+gen);
		System.out.println("gen1:"+gen1);


		String app = encryptor.encrypt("app");
		String app1 = encryptor.encrypt("app");
		System.out.println("app:"+app);
		System.out.println("app1:"+app1);


		String daemon = encryptor.encrypt("daemon");
		String daemon1 = encryptor.encrypt("daemon");
		System.out.println("daemon:"+daemon);
		System.out.println("daemon1:"+daemon1);


	}

}
