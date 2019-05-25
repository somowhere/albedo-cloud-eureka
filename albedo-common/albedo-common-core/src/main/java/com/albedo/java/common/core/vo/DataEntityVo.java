package com.albedo.java.common.core.vo;

import lombok.Data;

import java.io.Serializable;

/**
 * 通常的数据基类 copyright 2014 albedo all right reserved author somewhere created on 2014年12月31日 下午1:57:09
 */
@Data
public class DataEntityVo<PK extends Serializable> extends GeneralEntityVo {

    private PK id;
    private Integer status = FLAG_NORMAL;
    private String description;

}
