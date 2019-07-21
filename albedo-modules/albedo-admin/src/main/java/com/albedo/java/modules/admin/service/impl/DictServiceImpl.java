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

package com.albedo.java.modules.admin.service.impl;

import com.albedo.java.common.core.annotation.BaseInit;
import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.SelectResult;
import com.albedo.java.common.persistence.service.impl.TreeVoServiceImpl;
import com.albedo.java.modules.admin.domain.DictEntity;
import com.albedo.java.modules.admin.repository.DictRepository;
import com.albedo.java.modules.admin.service.DictService;
import com.albedo.java.modules.admin.util.DictUtil;
import com.albedo.java.modules.admin.vo.DictDataVo;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * 字典表 服务实现类
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
@Service
@BaseInit(method = "refresh")
public class DictServiceImpl extends
	TreeVoServiceImpl<DictRepository, DictEntity, DictDataVo> implements DictService {

	@Autowired
	private CacheManager cacheManager;

	public List<DictEntity> findAllOrderBySort(){
		return baseMapper.selectList(Wrappers.<DictEntity>query().lambda().orderByAsc(
			DictEntity::getSort
		));
	}

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public Map<String, List<SelectResult>> findCodeStr(String codes) {
		return findCodes(StringUtil.isNotEmpty(codes) ?
			codes.split(StringUtil.SPLIT_DEFAULT) : null);
	}

	@Cacheable(value = DictEntity.CACHE_DICT_DETAILS,key="'"+ DictEntity.CACHE_DICT_RESULT_ALL+"'")
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public Map<String,List<SelectResult>> findCodes(String... codes) {
		return DictUtil.getSelectResultListByCodes(findAllOrderBySort(), codes);
	}

	public void refresh() {
		Cache cache = cacheManager.getCache(DictEntity.CACHE_DICT_DETAILS);
		if (cache == null || cache.get(DictEntity.CACHE_DICT_ALL) == null ||
			ObjectUtil.isEmpty(cache.get(DictEntity.CACHE_DICT_ALL))) {
			List<DictEntity> dictEntityList = findAllOrderBySort();
			cache.put(DictEntity.CACHE_DICT_ALL, dictEntityList);
		}
	}




}