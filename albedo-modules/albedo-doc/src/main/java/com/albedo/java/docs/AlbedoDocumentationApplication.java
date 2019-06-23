package com.albedo.java.docs;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

import springfox.documentation.swagger2.annotations.EnableSwagger2;
/**
 * 
 * @author satish sharma
 *
 */
@EnableSwagger2
@EnableScheduling
@SpringBootApplication
public class AlbedoDocumentationApplication {

	public static void main(String[] args) {
		SpringApplication.run(AlbedoDocumentationApplication.class, args);
	}
}
