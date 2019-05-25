package com.albedo.java.modules.sys.feign;

import com.albedo.java.common.core.constant.SecurityConstants;
import com.albedo.java.common.core.constant.ServiceNameConstants;
import com.albedo.java.common.core.util.R;
import com.albedo.java.modules.sys.dto.GenSchemeDTO;
import com.albedo.java.modules.sys.entity.Dict;
import com.albedo.java.modules.sys.feign.factory.RemoteUserServiceFallbackFactory;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;

import java.util.List;

@FeignClient(value = ServiceNameConstants.UMPS_SERVICE,
	fallbackFactory = RemoteUserServiceFallbackFactory.class)
public interface RemoteMenuService {

	@GetMapping("/menu/gen")
	R<List<Dict>> saveByGenScheme(@RequestBody GenSchemeDTO genSchemeDTO
		, @RequestHeader(SecurityConstants.FROM) String from);

}
