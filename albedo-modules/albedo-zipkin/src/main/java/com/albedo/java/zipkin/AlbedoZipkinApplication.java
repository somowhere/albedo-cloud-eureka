package com.albedo.java.zipkin;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.cloud.client.SpringCloudApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.core.env.Environment;
import zipkin.storage.mysql.MySQLStorage;
import zipkin2.server.internal.EnableZipkinServer;

import javax.sql.DataSource;
import java.net.InetAddress;

/**
 * 服务链路追踪
 *
 * @author lishangbu
 * @date 2019/2/23
 */
@EnableZipkinServer
@SpringCloudApplication
@Slf4j
public class AlbedoZipkinApplication {
	static String SERVER_PORT = "server.port";
	static String SPRING_APPLICATION_NAME = "spring.application.name";


	public static void main(String[] args) throws Exception {
		SpringApplication app = new SpringApplication(AlbedoZipkinApplication.class);
		final ApplicationContext applicationContext = app.run(args);
		Environment env = applicationContext.getEnvironment();

		log.info("\n----------------------------------------------------------\n\t" +
				"Application '{}' is running! Access URLs:\n\t" +
				"Local: \t\thttp://localhost:{}\n\t" +
				"External: \thttp://{}:{}\n----------------------------------------------------------",
			env.getProperty(SPRING_APPLICATION_NAME),
			env.getProperty(SERVER_PORT),
			InetAddress.getLocalHost().getHostAddress(),
			env.getProperty(SERVER_PORT));
	}

	@Bean
	public MySQLStorage mySQLStorage(DataSource datasource) {
		return MySQLStorage.builder().datasource(datasource).executor(Runnable::run).build();
	}
}
