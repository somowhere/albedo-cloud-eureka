/**
 * Copyright &copy; 2018 <a href="https://github.com/somewhereMrli/albedo-boot">albedo-boot</a> All rights reserved.
 */
package com.albedo.java.modules.test.domain.vo;

import com.albedo.java.common.core.vo.DataEntityVo;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.*;
import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 * 测试书籍管EntityVo 测试书籍
 * @author admin
 * @version 2019-07-25 17:51:48
 */
@Data @ToString @NoArgsConstructor @AllArgsConstructor
public class TestBookDataVo extends DataEntityVo<String> {

	private static final long serialVersionUID = 1L;
	/** F_TITLE title_  :  标题 */
	public static final String F_TITLE = "title";
	/** F_AUTHOR author_  :  作者 */
	public static final String F_AUTHOR = "author";
	/** F_NAME name_  :  名称 */
	public static final String F_NAME = "name";
	/** F_EMAIL email_  :  邮箱 */
	public static final String F_EMAIL = "email";
	/** F_PHONE phone_  :  手机 */
	public static final String F_PHONE = "phone";
	/** F_ACTIVATED activated_  :  activated_ */
	public static final String F_ACTIVATED = "activated";
	/** F_NUMBER number_  :  key */
	public static final String F_NUMBER = "number";
	/** F_MONEY money_  :  money_ */
	public static final String F_MONEY = "money";
	/** F_AMOUNT amount_  :  amount_ */
	public static final String F_AMOUNT = "amount";
	/** F_RESETDATE reset_date  :  reset_date */
	public static final String F_RESETDATE = "resetDate";

	//columns START
	/** title 标题 */
 @Size(max=32)
	private String title;
	/** author 作者 */
 @NotBlank @Size(max=50)
	private String author;
	/** name 名称 */
 @Size(max=50)
	private String name;
	/** email 邮箱 */
 @Email @Size(max=100)
	private String email;
	/** phone 手机 */
 @Size(max=32)
	private String phone;
	/** activated activated_ */
 @NotNull 
	private Integer activated;
	/** number key */
 
	private Long number;
	/** money money_ */
 
	private Double money;
	/** amount amount_ */
 
	private Double amount;
	/** resetDate reset_date */
 
	private Date resetDate;
	//columns END

}
