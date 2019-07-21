package com.albedo.java.modules.admin.util;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.constant.SecurityConstants;
import com.albedo.java.common.core.util.*;
import com.albedo.java.common.core.vo.SelectResult;
import com.albedo.java.modules.admin.domain.DictEntity;
import com.albedo.java.modules.admin.feign.RemoteDictService;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;

import java.util.List;
import java.util.Map;

/**
 * 数据字典工具类 copyright 2014 albedo all right reserved author somewhere created on
 * 2015年1月27日 上午9:52:55
 */
@Slf4j
public class DictUtil {
	public static CacheManager cacheManager = SpringContextHolder.getBean(CacheManager.class);
	public static RemoteDictService remoteDictService = SpringContextHolder.getBean(RemoteDictService.class);
    public static List<DictEntity> getDictList() {
		Cache cache = cacheManager.getCache(DictEntity.CACHE_DICT_DETAILS);
		if (cache != null && cache.get(DictEntity.CACHE_DICT_ALL) != null) {
			return (List<DictEntity>) cache.get(DictEntity.CACHE_DICT_ALL).get();
		}
		try{
			String dictListStr = remoteDictService.getDictAll(SecurityConstants.FROM_IN).getData();
			if(ObjectUtil.isNotEmpty(dictListStr)){
				List<DictEntity> dictEntityList = Json.parseArray(dictListStr, DictEntity.class);
				cache.put(DictEntity.CACHE_DICT_ALL, dictEntityList);
				return dictEntityList;
			}
		}catch (Exception e){
			log.warn("{}",e);
		}
		return null;
    }

    /**
     * 根据code 和 编码 获取数据字典对象
     *
     * @param code
     * @return
     */
    public static DictEntity getCodeItem(String code) {
        DictEntity dictEntity = null;
        List<DictEntity> list = DictUtil.getDictList();
        for (DictEntity item : list) {
            if (item.getCode().equals(code)) {
                dictEntity = item;

            }
        }
        return dictEntity == null ? null : dictEntity;
    }

    /**
     * 根据code 和 编码 获取数据字典对象 本级
     *
     * @param code
     * @return
     */
    public static String getCodeItemVal(String code) {
        DictEntity dictEntity = getCodeItem(code);
        return dictEntity == null ? null : dictEntity.getVal();
    }

	public static Map<String,List<SelectResult>> getSelectResultListByCodes(String... codes) {
    	return getSelectResultListByCodes(DictUtil.getDictList(), codes);
	}
    public static Map<String,List<SelectResult>> getSelectResultListByCodes(List<DictEntity> dictEntityList, String... codes) {
		Map<String, List<SelectResult>> map = Maps.newHashMap();
		if(ObjectUtil.isEmpty(dictEntityList)){
			return map;
		}
		List<DictEntity> dictEntityCodes = Lists.newArrayList();
		if(ObjectUtil.isNotEmpty(codes)){
			for(String codeItem : codes){
				for(DictEntity dictEntity : dictEntityList){
					//命中的数据字段
					if(codeItem.equals(dictEntity.getCode())){
						dictEntityCodes.add(dictEntity);
						break;
					}
				}
//                if(Globals.UA_SYS_CITY.equals(codeItem)){
//                    map.put(Globals.UA_SYS_CITY, repository.findCitys());
//                }
			}
		}else{
			dictEntityCodes = dictEntityList;
		}
		dictEntityCodes.forEach(dict ->{
			List<SelectResult> dictTempList = getDictList(dictEntityList, dict);
			if(CollUtil.isNotEmpty(dictTempList)){
				map.put(dict.getCode(), dictTempList);
			}
		});
//        if(!map.containsKey(Globals.UA_SYS_CITY) && PublicUtil.isEmpty(codeList)){
//            map.put(Globals.UA_SYS_CITY, repository.findCitys());
//        }

		return map;
    }

	private static List<SelectResult> getDictList(List<DictEntity> dictEntityList, DictEntity dictEntity) {
		List<SelectResult> list = Lists.newLinkedList();
		if(CollUtil.isNotEmpty(dictEntityList)){
			for(DictEntity item : dictEntityList){
				if(CommonConstants.YES.equals(item.getShow()) && StringUtil.isNotEmpty(item.getParentId()) && item.getParentId().equals(dictEntity.getId())){
					list.add(new SelectResult(item.getVal(), item.getName(), item.getVersion()));
				}
			}
		}
		return list;
	}

}
