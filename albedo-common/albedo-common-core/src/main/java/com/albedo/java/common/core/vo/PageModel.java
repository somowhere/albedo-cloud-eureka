package com.albedo.java.common.core.vo;

import cn.hutool.core.util.ArrayUtil;
import com.albedo.java.common.core.util.CollUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.google.common.collect.Lists;
import lombok.Data;
import org.apache.commons.lang.StringEscapeUtils;

import java.util.Collections;
import java.util.List;

@Data
public class PageModel<T> implements IPage<T> {

	private static final long serialVersionUID = 1L;

	/**
	 * 查询数据列表
	 */
	private List<T> records = Collections.emptyList();
	/**
	 * 总数
	 */
	private long total = 0;
	/**
	 * 每页显示条数，默认 10
	 */
	private long size = 10;
	/**
	 * 当前页
	 */
	private long current = 1;
	/**
	 * SQL 排序 ASC 数组
	 */
	private List<String> ascList=Lists.newArrayList();
	/**
	 * SQL 排序 DESC 数组
	 */
	private List<String> descList=Lists.newArrayList();
	/**
	 * 自动优化 COUNT SQL
	 */
	private boolean optimizeCountSql = true;
	/**
	 * 是否进行 count 查询
	 */
	private boolean isSearchCount = true;

	public PageModel() {
		// to do nothing
	}

	/**
	 * 分页构造函数
	 *
	 * @param current 当前页
	 * @param size    每页显示条数
	 */
	public PageModel(long current, long size) {
		this(current, size, 0);
	}

	public PageModel(long current, long size, long total) {
		this(current, size, total, true);
	}

	public PageModel(long current, long size, boolean isSearchCount) {
		this(current, size, 0, isSearchCount);
	}

	public PageModel(long current, long size, long total, boolean isSearchCount) {
		if (current > 1) {
			this.current = current;
		}
		this.size = size;
		this.total = total;
		this.isSearchCount = isSearchCount;
	}

	/**
	 * 是否存在上一页
	 *
	 * @return true / false
	 */
	public boolean hasPrevious() {
		return this.current > 1;
	}

	/**
	 * 是否存在下一页
	 *
	 * @return true / false
	 */
	public boolean hasNext() {
		return this.current < this.getPages();
	}

	@Override
	public List<T> getRecords() {
		return this.records;
	}

	@Override
	public PageModel<T> setRecords(List<T> records) {
		this.records = records;
		return this;
	}

	@Override
	public long getTotal() {
		return this.total;
	}

	@Override
	public PageModel<T> setTotal(long total) {
		this.total = total;
		return this;
	}

	@Override
	public long getSize() {
		return this.size;
	}

	@Override
	public PageModel<T> setSize(long size) {
		this.size = size;
		return this;
	}

	@Override
	public long getCurrent() {
		return this.current;
	}

	@Override
	public PageModel<T> setCurrent(long current) {
		this.current = current;
		return this;
	}

	@Override
	public String[] ascs() {
		return ArrayUtil.toArray(ascList, String.class);
	}

	public PageModel<T> setAscList(List<String> ascList) {
		if (CollUtil.isNotEmpty(ascList)) {
			this.ascList = ascList;
		}
		return this;
	}


	/**
	 * 升序
	 *
	 * @param asc 升序字段
	 */
	public PageModel<T> addAsc(String asc) {
		ascList.add(asc);
		return this;
	}

	@Override
	public String[] descs() {
		return ArrayUtil.toArray(descList, String.class);
	}

	public PageModel<T> setDescs(List<String> descList) {
		if (CollUtil.isNotEmpty(descList)) {
			this.descList = descList;
		}
		return this;
	}

	/**
	 * 降序
	 *
	 * @param desc 多个降序字段
	 */
	public PageModel<T> addDesc(String desc) {
		descList.add(desc);
		return this;
	}

	@Override
	public boolean optimizeCountSql() {
		return optimizeCountSql;
	}

	@Override
	public boolean isSearchCount() {
		if (total < 0) {
			return false;
		}
		return isSearchCount;
	}

	public PageModel<T> setSearchCount(boolean isSearchCount) {
		this.isSearchCount = isSearchCount;
		return this;
	}

	public PageModel<T> setOptimizeCountSql(boolean optimizeCountSql) {
		this.optimizeCountSql = optimizeCountSql;
		return this;
	}
	/**
	 * 查询条件json
	 */
	private String queryConditionJson;

	public void setQueryConditionJson(String queryConditionJson) {
		this.queryConditionJson = StringEscapeUtils.unescapeHtml(queryConditionJson);
	}

}
