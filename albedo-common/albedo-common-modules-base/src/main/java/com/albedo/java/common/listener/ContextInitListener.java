package com.albedo.java.common.listener;

import com.albedo.java.common.base.BaseInit;
import com.albedo.java.common.base.BaseInterface;
import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.util.SpringContextHolder;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;

import java.lang.reflect.Method;
import java.util.Map;

@Slf4j
public class ContextInitListener implements ApplicationRunner {

	@Override
	public void run(ApplicationArguments args) throws Exception {
		log.debug(">>>>> spring afterPropertiesSet 初始化开始 <<<<<");
		// spring初始化完毕后，通过反射调用所有使用BaseInit注解的afterPropertiesSet方法
		Map<String, Object> baseServices = SpringContextHolder.getApplicationContext().getBeansWithAnnotation(BaseInit.class);
		if (ObjectUtil.isNotEmpty(baseServices)) {
			for (Object service : baseServices.values()) {
				log.debug(">>>>> {}.afterPropertiesSet()", service.getClass().getName());
				try {
					Method initMapper = service.getClass().getMethod("afterPropertiesSet");
					initMapper.invoke(service);
				} catch (Exception e) {
					log.error("初始化BaseInit的afterPropertiesSet方法异常{}", e);
					e.printStackTrace();
				}
			}
		}
		log.debug(">>>>> spring afterPropertiesSet 初始化完毕 <<<<<");
		// 系统入口初始化
		log.debug(">>>>> spring init 初始化开始 <<<<<");
		Map<String, BaseInterface> baseInterfaceBeans = SpringContextHolder.getApplicationContext().getBeansOfType(BaseInterface.class);
		if (ObjectUtil.isNotEmpty(baseInterfaceBeans)) {
			for (Object service : baseInterfaceBeans.values()) {
				log.debug(">>>>> {}.init()", service.getClass().getName());
				try {
					Method init = service.getClass().getMethod("init");
					init.invoke(service);
				} catch (Exception e) {
					log.error("初始化BaseInterface的init方法异常{}", e);
					e.printStackTrace();
				}
			}
		}

		log.debug(">>>>> spring init 初始化完毕 <<<<<");

	}
}

