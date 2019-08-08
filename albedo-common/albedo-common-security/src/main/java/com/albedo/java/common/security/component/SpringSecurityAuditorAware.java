package com.albedo.java.common.security.component;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.security.util.SecurityUtils;
import org.springframework.data.domain.AuditorAware;
import org.springframework.stereotype.Component;

import java.util.Optional;

/**
 * Implementation of AuditorAware based on Spring Security.
 */
@Component
public class SpringSecurityAuditorAware implements AuditorAware<String> {

	@Override
	public Optional<String> getCurrentAuditor() {
		return Optional.of(SecurityUtils.getUser() == null ? CommonConstants.SYSTEM
			: SecurityUtils.getUser().getId());
	}
}
