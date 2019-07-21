package com.albedo.java.modules.admin.vo;


import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class GenSchemeDataVo {
	private String schemeName;
	private String parentMenuId;
	private String url;

}
