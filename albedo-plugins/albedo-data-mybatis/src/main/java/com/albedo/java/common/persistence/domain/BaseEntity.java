/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.albedo.java.common.persistence.domain;

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
    @TableField(value = GeneralEntity.F_STATUS)
    @TableLogic(delval = "-1")
    protected Integer status;

    public BaseEntity() {
        super();
        this.status = FLAG_NORMAL;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

}
