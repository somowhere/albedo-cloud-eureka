/*
 *  Copyright (c) 2019-2020, somowhere (somewhere0813@gmail.com).
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

package com.albedo.java.modules.sys.feign.fallback;

import com.albedo.java.common.core.util.R;
import com.albedo.java.modules.sys.domain.Dict;
import com.albedo.java.modules.sys.feign.RemoteMenuService;
import com.albedo.java.modules.sys.domain.vo.GenSchemeDataVo;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * @author lijie
 * @date 2019/5/1
 */
@Slf4j
@Component
public class RemoteMenuServiceFallbackImpl implements RemoteMenuService {
	@Setter
	private Throwable cause;

	/**
	 * 生成菜单
	 *
	 * @param schemeDataVo
	 */
	@Override
	public R<List<Dict>> saveByGenScheme(GenSchemeDataVo schemeDataVo, String from) {
		log.error("feign 查询数据字典信息失败:{}", schemeDataVo, cause);
		return null;
	}


}
