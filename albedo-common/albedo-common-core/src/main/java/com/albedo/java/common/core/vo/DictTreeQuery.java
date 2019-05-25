package com.albedo.java.common.core.vo;

import io.swagger.annotations.ApiModel;
import lombok.Data;
import lombok.ToString;

/**
 * Created by somewhere on 2017/3/2.
 */
@Data
@ApiModel
@ToString
public class DictTreeQuery {

    private String extId;
    private String type;
    private String all;

}
