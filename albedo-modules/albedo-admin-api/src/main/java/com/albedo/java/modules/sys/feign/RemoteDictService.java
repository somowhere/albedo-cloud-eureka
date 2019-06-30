package com.albedo.java.modules.sys.feign;

import com.albedo.java.common.core.constant.SecurityConstants;
import com.albedo.java.common.core.constant.ServiceNameConstants;
import com.albedo.java.common.core.util.R;
import com.albedo.java.modules.sys.domain.Dict;
import com.albedo.java.modules.sys.feign.factory.RemoteUserServiceFallbackFactory;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;

import java.util.List;

@FeignClient(contextId = "remoteDictService", value = ServiceNameConstants.UMPS_SERVICE,
	fallbackFactory = RemoteUserServiceFallbackFactory.class)
public interface RemoteDictService {

	@GetMapping("/dict/type/{code}")
	R<List<Dict>> getDictByCode(@PathVariable("code") String code
		, @RequestHeader(SecurityConstants.FROM) String from);


	@GetMapping("/dict/all")
	R<List<Dict>> getDictAll(@RequestHeader(SecurityConstants.FROM) String from);
}
