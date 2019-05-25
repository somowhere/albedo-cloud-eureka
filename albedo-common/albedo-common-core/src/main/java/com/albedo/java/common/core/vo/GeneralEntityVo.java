package com.albedo.java.common.core.vo;

import lombok.Data;

import java.io.Serializable;

/**
 * 通常的数据基类 copyright 2014 albedo all right reserved author somewhere created on 2014年12月31日 下午1:57:09
 */
@Data
public class GeneralEntityVo<ID extends Serializable> implements Serializable {

    /*** 状态 正常 */
    public static final Integer FLAG_NORMAL = 1;
    /*** 状态 停用 */
    public static final Integer FLAG_UNABLE = 0;
    /*** 状态 已删除 */
    public static final Integer FLAG_DELETE = -1;
    /**
     * 状态（-1：删除；0：停用 1：正常）
     */
    public static final String F_STATUS = "status";
    /*** ID */
    public static final String F_ID = "id";
    public static final String F_CREATEDBY = "createdBy";
    public static final String F_CREATOR = "creator";
    public static final String F_CREATEDDATE = "createdDate";
    public static final String F_LASTMODIFIEDBY = "lastModifiedBy";
    public static final String F_MODIFIER = "modifier";
    public static final String F_LASTMODIFIEDDATE = "lastModifiedDate";
    public static final String F_VERSION = "version";
    public static final String F_DESCRIPTION = "description";
    private static final long serialVersionUID = 1L;


}
