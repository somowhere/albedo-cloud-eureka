/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.albedo.java.common.persistence.domain;

import com.albedo.java.common.core.annotation.DictType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;

/**
 * Entity支持类
 *
 * @author lj
 * @version 2014-05-16
 */
public abstract class BaseEntity<T extends GeneralEntity> extends GeneralEntity<T> {

    private static final long serialVersionUID = 1L;
    @TableField(value = GeneralEntity.F_SQL_DELFLAG)
    @TableLogic(delval = "1")
    protected String delFlag;

    public BaseEntity() {
        super();
        this.delFlag = FLAG_NORMAL;
    }

	public String getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}
}
