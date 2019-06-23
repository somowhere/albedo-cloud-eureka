package com.albedo.java.docs;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.SpringCloudApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.core.env.Environment;
import org.springframework.scheduling.annotation.EnableScheduling;

import springfox.documentation.swagger2.annotations.EnableSwagger2;

import java.net.InetAddress;
import java.net.UnknownHostException;

/**
 * 
 * @author satish sharma
 *
 */
@EnableScheduling
@SpringCloudApplication
@Slf4j
public class AlbedoDocApplication {

	static String SERVER_PORT = "server.port";
	static String SPRING_APPLICATION_NAME = "spring.application.name";

	public static void main(String[] args) throws Exception {
		SpringApplication app = new SpringApplication(AlbedoDocApplication.class);
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
}
