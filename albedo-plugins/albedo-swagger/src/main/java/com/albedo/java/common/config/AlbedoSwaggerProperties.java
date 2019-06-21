package com.albedo.java.common.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.ConfigurationPropertiesBinding;
import org.springframework.stereotype.Component;

/**
 * Created by somewhere on 9/7/16.
 */

@Component
@ConfigurationProperties(prefix = "application.swagger", ignoreUnknownFields = false)
@Data
public class AlbedoSwaggerProperties {
    private String title = "Application API";
    private String description = "API documentation";
    private String version = "0.0.1";
    private String termsOfServiceUrl;
    private String contactName;
    private String contactUrl;
    private String contactEmail;
    private String license;
    private String licenseUrl;
    private String defaultIncludePattern = "/api/.*";
    private String host;
    private String[] protocols = {};
    private boolean useDefaultResponseMessages=true;
}
