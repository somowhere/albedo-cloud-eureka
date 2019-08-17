package com.albedo.java.common.core.config;

import com.albedo.java.common.core.util.StringUtil;
import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;

/**
 * Properties specific to albedo.
 * <p>
 * <p>
 * Properties are configured in the application.yml file.
 * </p>
 */
@Configuration
@ConfigurationProperties(prefix = "application", ignoreInvalidFields = true)
@Data
@RefreshScope
public class ApplicationProperties {

	private final CorsConfiguration cors = new CorsConfiguration();
	private String defaultView;
	private String name = "albedo";
	private String jedisKeyPrefix = "";
	private String urlSuffix = ".html";
	private Boolean developMode = true;
	private Boolean cluster = false;
	private String staticFileDirectory = "";
	private String logPath = ".logs/";


//    public String getStaticUrlPath(String strs) {
//        return StringUtil.toAppendStr( "/file/get", strs);
//    }

	public String getStaticFileDirectory(String strs) {
		return StringUtil.toAppendStr(
			staticFileDirectory, strs);
	}


}
