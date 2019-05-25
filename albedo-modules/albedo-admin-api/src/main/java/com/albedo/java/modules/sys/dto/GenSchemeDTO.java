package com.albedo.java.modules.sys.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@AllArgsConstructor
public class GenSchemeDTO {
	private String schemeName;
	private String parentMenuId;
	private String url;

}
