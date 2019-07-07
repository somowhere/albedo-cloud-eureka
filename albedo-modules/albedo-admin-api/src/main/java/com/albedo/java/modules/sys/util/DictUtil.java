package com.albedo.java.modules.sys.util;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.*;
import com.albedo.java.common.core.vo.DictQuery;
import com.albedo.java.common.core.vo.DictResult;
import com.albedo.java.common.core.vo.SelectResult;
import com.albedo.java.modules.sys.domain.Dict;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.apache.commons.lang.StringUtils;
import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;

import java.util.List;
import java.util.Map;

/**
 * 数据字典工具类 copyright 2014 albedo all right reserved author somewhere created on
 * 2015年1月27日 上午9:52:55
 */
public class DictUtil {
	public static CacheManager cacheManager = SpringContextHolder.getBean(CacheManager.class);

	/**
	 * 业务数据
	 */
	private static final String DICT_BIZPARENT_ID = "1";
	private static final String DICT_SYSPARENT_ID = "5ea249bb780348eb8ea6a0efade684a6";
    /**
     * 获取ehcache中所有字典对象
     */
    public static List<Dict> getDictList() {
		Cache cache = cacheManager.getCache(Dict.CACHE_DICT_DETAILS);
		if (cache != null && cache.get(Dict.CACHE_DICT_ALL) != null) {
			return (List<Dict>) cache.get(Dict.CACHE_DICT_ALL).get();
		}
		return null;
    }

    /**
     * 根据code 和 原始值 获取数据字典name
     *
     * @param code
     * @param val
     * @return
     */
    public static String getVal(String code, String val) {
        Dict dict = getDictByCodeAndVal(code, val);
        return dict == null ? null : dict.getName();
    }

    /**
     * 根据code 和 原始值 获取数据字典name
     *
     * @param code
     * @param values
     * @return
     */
    public static String getNamesByValues(String code, String values) {
        String[] split = values.split(",");
        List<String> names = Lists.newArrayList();
        List<Dict> dictList = getDictListByCode(code);
        for (Dict dict : dictList) {
            for (String s : split) {
                if (ObjectUtil.isNotEmpty(dict.getId()) && dict.getVal().equals(s)) {
                    names.add(dict.getName());
                }
            }
        }
        return StringUtils.join(names, ",");
    }

    /**
     * 根据code 和 name 获取数据字典原始值 下级
     *
     * @param code
     * @param name
     * @return
     */
    public static String getValByName(String code, String name) {
        List<Dict> dictList = getDictListByCode(code);
        for (Dict dict : dictList) {
            if (ObjectUtil.isNotEmpty(dict.getId()) && dict.getName().equals(name)) {
                return dict.getVal();
            }
        }
        return null;
    }

    public static String getNameByVal(String code, Object val) {
        String valStr = val == null ? "" : String.valueOf(val);
        return getNameByVal(code, valStr);
    }

    /**
     * 根据code 和 name 获取数据字典原始值 下级
     *
     * @param code
     * @param val
     * @return
     */
    public static String getNameByVal(String code, String val) {
        List<Dict> dictList = getDictListByCode(code);
        for (Dict dict : dictList) {
            if (ObjectUtil.isNotEmpty(dict.getId()) && dict.getVal().equals(val)) {
                return dict.getName();
            }
        }
        return null;
    }

    /**
     * 根据val 和 原始值 获取数据字典name
     *
     * @param code
     * @param val
     * @return
     */
    public static String getVal(String code, String val, String defaultStr) {
        Dict dict = getDictByCodeAndVal(code, val);
        return dict == null ? defaultStr : dict.getName();
    }

    /**
     * 根据code 和 编码 获取数据字典name
     *
     * @param code
     * @param val
     * @return
     */
    public static String getCode(String code, Object val) {
        Dict dict = null;
        List<Dict> dictList = getDictListByCode(code);
        for (Dict item : dictList) {
            if (ObjectUtil.isNotEmpty(item.getId()) && item.getCode().equals(val)) {
                dict = item;
                break;
            }
        }
        return dict == null ? null : dict.getName();
    }

    /**
     * 根据code 和 原始值 获取数据字典对象
     *
     * @param code
     * @param val
     * @return
     */
    public static Dict getValItem(String code, String val) {
        Dict dict = getDictByCodeAndVal(code, val);
        return dict == null ? null : dict;
    }

    /**
     * 根据code 和 编码 获取数据字典对象
     *
     * @param code
     * @param val
     * @return
     */
    public static Dict getCodeItem(String code, String val) {
        Dict dict = null;
        List<Dict> dictList = getDictListByCode(code);
        for (Dict item : dictList) {
            if (ObjectUtil.isNotEmpty(item.getId()) && item.getCode().equals(val)) {
                dict = item;
                break;
            }
        }
        return dict == null ? null : dict;
    }

    /**
     * 根据code 和 编码 获取数据字典对象
     *
     * @param code
     * @param val
     * @return
     */
    public static Dict getCodeItemByVal(String code, String val) {
        Dict dict = null;
        List<Dict> dictList = getDictListByCode(code);
        for (Dict item : dictList) {
            if (ObjectUtil.isNotEmpty(item.getId()) && item.getVal().equals(val)) {
                dict = item;
                break;
            }
        }
        return dict == null ? null : dict;
    }

    /**
     * 根据code 和 编码 获取数据字典对象
     *
     * @param code
     * @param val
     * @return
     */
    public static String getCodeValByVal(String code, String val) {
        Dict dict = null;
        List<Dict> dictList = getDictListByCode(code);
        for (Dict item : dictList) {
            if (ObjectUtil.isNotEmpty(item.getId()) && item.getVal().equals(val)) {
                dict = item;
                break;
            }
        }
        return dict == null ? null : dict.getVal();
    }

    /**
     * 根据code 和 编码 获取数据字典对象
     *
     * @param code
     * @param val
     * @return
     */
    public static String getCodeNameByVal(String code, String val) {
        Dict dict = null;
        List<Dict> dictList = getDictListByCode(code);
        for (Dict item : dictList) {
            if (ObjectUtil.isNotEmpty(item.getId()) && item.getVal().equals(val)) {
                dict = item;
                break;
            }
        }
        return dict == null ? null : dict.getName();
    }

    /**
     * 根据code 和 编码 获取数据字典对象
     *
     * @param code
     * @return
     */
    public static Dict getCodeItem(String code) {
        Dict dict = null;
        List<Dict> list = DictUtil.getDictList();
        for (Dict item : list) {
            if (item.getCode().equals(code)) {
                dict = item;

            }
        }
        return dict == null ? null : dict;
    }

    /**
     * 根据code 和 编码 获取数据字典对象 本级
     *
     * @param code
     * @return
     */
    public static String getCodeItemVal(String code) {
        Dict dict = getCodeItem(code);
        return dict == null ? null : dict.getVal();
    }
    public static List<Dict> getDictList(DictQuery dictQuery) {
        if (ObjectUtil.isNotEmpty(dictQuery.getFilter())) {
            return getDictListFilterVal(dictQuery.getCode(), dictQuery.getFilter());
        }
        return getDictList(dictQuery.getCode());
    }
    public static List<Dict> getDictList(String code) {
        List<Dict> itemList = Lists.newArrayList();
        for (Dict item : getDictListByCode(code)) {
            itemList.add(item);
        }
        return itemList;
    }

    public static List<Dict> getDictListFilterVal(String code, String filters) {
        List<Dict> itemList = Lists.newArrayList();
        List<String> filterList = ObjectUtil.isEmpty(filters) ? null : Lists.newArrayList(filters.split(","));
        for (Dict item : getDictListByCode(code)) {
            if ((ObjectUtil.isEmpty(filterList) || !filterList.contains(item.getVal())))
                itemList.add(item);
        }
        return itemList;
    }

    public static List<Dict> getDictListContainVal(String code, String contains) {
        List<Dict> itemList = Lists.newArrayList();
        List<String> filterList = ObjectUtil.isEmpty(contains) ? null : Lists.newArrayList(contains.split(","));
        for (Dict item : getDictListByCode(code)) {
            if (ObjectUtil.isNotEmpty(filterList)
                    && filterList.contains(item.getVal()))
                itemList.add(item);
        }
        return itemList;
    }

    public static List<Dict> getAllDictList(String code) {


        return getDictListByCode(code);
    }

    private static Dict getDictByCodeAndVal(String code, String val) {
        List<Dict> dictList = getDictListByCode(code);
        for (Dict dict : dictList) {
            if (ObjectUtil.isNotEmpty(dict.getId()) && dict.getVal().equals(val)) {
                return dict;
            }
        }
        return null;
    }

    private static List<Dict> getDictListByCode(String code) {
        List<Dict> dictAllList = DictUtil.getDictList(),dictList = Lists.newArrayList();
		for (Dict dict : dictAllList) {
			if (StringUtil.isNotEmpty(dict.getParentCode())) {
				if(dict.getParentCode().equals(code)){
					dictList.add(dict);
				}
			}
		}
        return dictList;
    }

    public static List<DictResult> parseDictVm(List<Dict> dictList) {
        List<DictResult> rsList = null;
        if (ObjectUtil.isNotEmpty(dictList)) {
            rsList = Lists.newArrayList();
            for (Dict dict : dictList) {
                rsList.add(new DictResult(dict.getName(), dict.getCode(), dict.getVal()));
            }
        }
        return rsList;
    }
	public static Map<String,List<SelectResult>> getSelectResultListByCodes(String... codes) {
    	return getSelectResultListByCodes(DictUtil.getDictList(), codes);
	}
    public static Map<String,List<SelectResult>> getSelectResultListByCodes(List<Dict> dictList, String... codes) {
		Map<String, List<SelectResult>> map = Maps.newHashMap();
		if(ObjectUtil.isEmpty(dictList)){
			return map;
		}
		List<Dict> dictCodes = Lists.newArrayList();
		if(ObjectUtil.isEmpty(codes)){
			for(Dict dict : dictList){
				//业务字典
				if(DICT_BIZPARENT_ID.equals(dict.getParentId())||DICT_SYSPARENT_ID.equals(dict.getParentId())){
					dictCodes.add(dict);
				}
			}
		}else{
			for(String codeItem : codes){
				for(Dict dict : dictList){
					//命中的数据字段
					if(codeItem.equals(dict.getCode())){
						dictCodes.add(dict);
						break;
					}
				}
//                if(Globals.UA_SYS_CITY.equals(codeItem)){
//                    map.put(Globals.UA_SYS_CITY, repository.findCitys());
//                }
			}
		}
		dictCodes.forEach(dict -> map.put(dict.getCode(), getDictList(dictList, dict)));
//        if(!map.containsKey(Globals.UA_SYS_CITY) && PublicUtil.isEmpty(codeList)){
//            map.put(Globals.UA_SYS_CITY, repository.findCitys());
//        }

		return map;
    }

	private static List<SelectResult> getDictList(List<Dict> dictList, Dict dict) {
		List<SelectResult> list = Lists.newLinkedList();
		if(CollUtil.isNotEmpty(dictList)){
			for(Dict item : dictList){
				if(CommonConstants.YES.equals(item.getShow()) && StringUtil.isNotEmpty(item.getParentId()) && item.getParentId().equals(dict.getId())){
					list.add(new SelectResult(item.getVal(), item.getName(), item.getVersion()));
				}
			}
		}
		return list;
	}

}
