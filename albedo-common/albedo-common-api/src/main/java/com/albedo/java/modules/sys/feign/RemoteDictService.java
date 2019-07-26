package com.albedo.java.modules.sys.feign;

import com.albedo.java.common.core.constant.SecurityConstants;
import com.albedo.java.common.core.constant.ServiceNameConstants;
import com.albedo.java.common.core.util.R;
import com.albedo.java.modules.sys.feign.factory.RemoteUserServiceFallbackFactory;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;

@FeignClient(contextId = "remoteDictService", value = ServiceNameConstants.UMPS_SERVICE,
	fallbackFactory = RemoteUserServiceFallbackFactory.class)
public interface RemoteDictService {

	@GetMapping("/dict/all")
	R<String> getDictAll(@RequestHeader(SecurityConstants.FROM) String from);
}
