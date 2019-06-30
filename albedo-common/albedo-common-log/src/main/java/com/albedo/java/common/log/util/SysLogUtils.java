/*
 *  Copyright (c) 2019-2020, 冷冷 (somewhere0813@gmail.com).
 *  <p>
 *  Licensed under the GNU Lesser General Public License 3.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *  <p>
 * https://www.gnu.org/licenses/lgpl.html
 *  <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.albedo.java.common.log.util;

import cn.hutool.core.util.URLUtil;
import cn.hutool.extra.servlet.ServletUtil;
import cn.hutool.http.HttpUtil;
import com.albedo.java.modules.sys.domain.Log;
import com.albedo.java.common.core.constant.CommonConstants;
import lombok.experimental.UtilityClass;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.provider.OAuth2Authentication;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.Objects;

/**
 * 系统日志工具类
 *
 * @author L.cm
 */
@UtilityClass
public class SysLogUtils {
	public Log getSysLog() {
		HttpServletRequest request = ((ServletRequestAttributes) Objects
			.requireNonNull(RequestContextHolder.getRequestAttributes())).getRequest();
		Log log = new Log();
		log.setCreatedBy(Objects.requireNonNull(getUsername()));
		log.setType(CommonConstants.STATUS_NORMAL);
		log.setRemoteAddr(ServletUtil.getClientIP(request));
		log.setRequestUri(URLUtil.getPath(request.getRequestURI()));
		log.setMethod(request.getMethod());
		log.setUserAgent(request.getHeader("user-agent"));
		log.setParams(HttpUtil.toParams(request.getParameterMap()));
		log.setServiceId(getClientId());
		return log;
	}

	/**
	 * 获取客户端
	 *
	 * @return clientId
	 */
	private String getClientId() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication instanceof OAuth2Authentication) {
			OAuth2Authentication auth2Authentication = (OAuth2Authentication) authentication;
			return auth2Authentication.getOAuth2Request().getClientId();
		}
		return null;
	}

	/**
	 * 获取用户名称
	 *
	 * @return username
	 */
	private String getUsername() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication == null) {
			return null;
		}
		return authentication.getName();
	}

}
