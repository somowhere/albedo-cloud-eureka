package com.albedo.java.common.core.vo;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.Data;
import org.apache.commons.lang.StringEscapeUtils;

@Data
public class PageModel<T> extends Page<T> {

    private static final long serialVersionUID = 1L;

    /**
     * 查询条件json
     */
    private String queryConditionJson;


	public void setQueryConditionJson(String queryConditionJson) {
		this.queryConditionJson = StringEscapeUtils.unescapeHtml(queryConditionJson);
	}

}
