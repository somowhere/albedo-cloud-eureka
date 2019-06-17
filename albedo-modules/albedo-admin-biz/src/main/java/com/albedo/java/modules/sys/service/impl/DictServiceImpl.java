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

package com.albedo.java.modules.sys.service.impl;

import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.SelectResult;
import com.albedo.java.common.persistence.service.impl.TreeVoServiceImpl;
import com.albedo.java.modules.sys.vo.DictDataVo;
import com.albedo.java.modules.sys.entity.Dict;
import com.albedo.java.modules.sys.repository.DictRepository;
import com.albedo.java.modules.sys.service.DictService;
import com.albedo.java.modules.sys.util.DictUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * 字典表 服务实现类
 * </p>
 *
 * @author lengleng
 * @since 2019/2/1
 */
@Service
public class DictServiceImpl extends
	TreeVoServiceImpl<DictRepository, Dict, DictDataVo> implements DictService {

	public List<Dict> findAllByStatusOrderBySortAsc(Integer status) {
		return repository.findRelationList(
			new QueryWrapper<Dict>().eq(super.getClassNameProfix(Dict.F_SQL_STATUS), status)
				.orderByAsc(super.getClassNameProfix(Dict.F_SQL_SORT))
		);

	}
	public Map<String, List<SelectResult>> findCodeStr(String codes) {
		return findCodes(StringUtil.isNotEmpty(codes) ?
			codes.split(StringUtil.SPLIT_DEFAULT) : null);
	}
	public Map<String,List<SelectResult>> findCodes(String... codes) {
		return DictUtil.getSelectResultListByCodes(codes);
	}


}
