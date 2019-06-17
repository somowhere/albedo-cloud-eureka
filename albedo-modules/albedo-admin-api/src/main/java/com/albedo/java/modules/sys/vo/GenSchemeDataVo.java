package com.albedo.java.modules.sys.vo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@AllArgsConstructor
public class GenSchemeDataVo {
	private String schemeName;
	private String parentMenuId;
	private String url;

}
