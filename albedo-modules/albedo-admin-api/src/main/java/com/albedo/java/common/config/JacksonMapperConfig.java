package com.albedo.java.common.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class JacksonMapperConfig {

	@Bean
	public ObjectMapper myObjectMapper() {
		return new ObjectMapper().registerModule(new CustomFieldModule());
	}

}
