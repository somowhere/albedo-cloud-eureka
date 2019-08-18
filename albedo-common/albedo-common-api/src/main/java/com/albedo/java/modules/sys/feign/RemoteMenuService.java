package com.albedo.java.modules.sys.feign;

import com.albedo.java.common.core.constant.SecurityConstants;
import com.albedo.java.common.core.constant.ServiceNameConstants;
import com.albedo.java.common.core.util.R;
import com.albedo.java.modules.sys.domain.Dict;
import com.albedo.java.modules.sys.feign.factory.RemoteUserServiceFallbackFactory;
import com.albedo.java.modules.sys.domain.vo.GenSchemeDataVo;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;

import java.util.List;

@FeignClient(contextId = "remoteMenuService", value = ServiceNameConstants.UMPS_SERVICE,
	fallbackFactory = RemoteUserServiceFallbackFactory.class)
public interface RemoteMenuService {

	@PostMapping("/menu/gen")
	R<List<Dict>> saveByGenScheme(@RequestBody GenSchemeDataVo schemeDataVo
		, @RequestHeader(SecurityConstants.FROM) String from);

}
