/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50725
 Source Host           : localhost:3306
 Source Schema         : albedo

 Target Server Type    : MySQL
 Target Server Version : 50725
 File Encoding         : 65001

 Date: 26/07/2019 14:04:05
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gen_scheme
-- ----------------------------
DROP TABLE IF EXISTS `gen_scheme`;
CREATE TABLE `gen_scheme`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编号',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `category` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类',
  `view_type` char(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '视图类型 0  普通表格 1  表格采用ajax刷新',
  `package_name` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `sub_module_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成子模块名',
  `function_name` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_name_simple` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成功能名（简写）',
  `function_author` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_table_id` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成表编号',
  `version` int(11) NULL DEFAULT 0 COMMENT '默认0，必填，离线乐观锁',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '生成方案' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_scheme
-- ----------------------------
INSERT INTO `gen_scheme` VALUES ('1c1992737bd35ddf11beb91e034017e4', '终端管理', 'curd_front', NULL, 'com.albedo.java.modules', 'admin', NULL, '终端', '终端', 'admin', '8addcc278d31bbee16b6936d7a70c98d', 0, NULL, '1', '2019-07-26 11:17:58.565', '1', '2019-07-26 11:17:58.565', '0');
INSERT INTO `gen_scheme` VALUES ('36096a9886fe251a9b755fcfaf766b42', '测试树书管理', 'treeTable', NULL, 'com.albedo.java.modules', 'test', NULL, '测试树书管', '测试树书', 'admin', '581ba5dfe75066b5a4769b3ed83c4ce1', 2, NULL, '1', '2019-07-26 11:16:47.994', '1', '2019-07-25 14:58:40.247', '1');
INSERT INTO `gen_scheme` VALUES ('362bf45dff219f95d092d767dac4f5fb', '测试书籍管理', 'curd', NULL, 'com.albedo.java.modules', 'test', NULL, '测试书籍管', '测试书籍', 'admin', '7c0d6295f674ada7a7cf4d651250d855', 12, NULL, '1', '2019-07-26 11:16:49.604', '1', '2019-07-25 14:58:59.178', '1');

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编号',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `comments` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `class_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '实体类名称',
  `parent_table` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关联父表',
  `parent_table_fk` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关联父表外键',
  `version` int(11) NULL DEFAULT 0 COMMENT '默认0，必填，离线乐观锁',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE,
  INDEX `gen_table_name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES ('581ba5dfe75066b5a4769b3ed83c4ce1', 'test_tree_book', '  测试树书', 'TestTreeBook', NULL, NULL, 3, NULL, '1', '2019-07-26 11:12:21.107', '1', '2019-07-25 17:28:07.111', '1');
INSERT INTO `gen_table` VALUES ('6aed6fe18521d641a443171fa9e92893', 'test_book', '测试书籍', 'TestBook', '', NULL, 8, NULL, '1', '2019-07-25 14:55:22.657', '1', '2019-07-25 10:21:37.999', '1');
INSERT INTO `gen_table` VALUES ('7c0d6295f674ada7a7cf4d651250d855', 'test_book', '测试书籍', 'TestBook', NULL, NULL, 2, NULL, '1', '2019-07-26 11:12:19.118', '1', '2019-07-25 17:18:40.452', '1');
INSERT INTO `gen_table` VALUES ('8addcc278d31bbee16b6936d7a70c98d', 'sys_oauth_client_detail', '终端信息表', 'OauthClientDetail', NULL, NULL, 0, NULL, '1', '2019-07-26 11:12:02.506', '1', '2019-07-26 11:12:02.506', '0');
INSERT INTO `gen_table` VALUES ('db46c9935ed8caae04bcefd5c6ea7f28', 'test_tree_book', '测试树书', 'TestTreeBook', NULL, NULL, 0, NULL, '1', '2019-07-25 14:55:24.738', '1', '2019-07-25 10:28:01.402', '1');

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编号',
  `gen_table_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '归属表编号',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `comments` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述备注',
  `jdbc_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列的数据类型的字节长度',
  `java_type` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` bit(1) NULL DEFAULT NULL COMMENT '是否主键',
  `is_unique` bit(1) NULL DEFAULT NULL COMMENT '是否唯一（1：是；0：否）',
  `is_null` bit(1) NULL DEFAULT NULL COMMENT '是否可为空',
  `is_insert` bit(1) NULL DEFAULT NULL COMMENT '是否为插入字段',
  `is_edit` bit(1) NULL DEFAULT NULL COMMENT '是否编辑字段',
  `is_list` bit(1) NULL DEFAULT NULL COMMENT '是否列表字段',
  `is_query` bit(1) NULL DEFAULT NULL COMMENT '是否查询字段',
  `query_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '查询方式（等于、不等于、大于、小于、范围、左LIKE、右LIKE、左右LIKE）',
  `show_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段生成方案（文本框、文本域、下拉框、复选框、单选框、字典选择、人员选择、部门选择、区域选择）',
  `dict_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典类型',
  `settings` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '其它设置（扩展字段JSON）',
  `sort` decimal(10, 0) NULL DEFAULT NULL COMMENT '排序（升序）',
  `version` int(11) NULL DEFAULT 0 COMMENT '默认0，必填，离线乐观锁',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `gen_table_column_table_id`(`gen_table_id`) USING BTREE,
  INDEX `gen_table_column_name`(`name`) USING BTREE,
  INDEX `gen_table_column_sort`(`sort`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES ('003c7074b886f3e6f151ebdd98586d03', '581ba5dfe75066b5a4769b3ed83c4ce1', 'created_date', '创建时间', NULL, 'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 160, 3, NULL, '1', '2019-07-25 14:58:19.000', '1', '2019-07-25 17:28:07.177', '0');
INSERT INTO `gen_table_column` VALUES ('0877c9b6356cb28709c518b774145f5e', '6aed6fe18521d641a443171fa9e92893', 'number_', 'key', NULL, 'int(11)', 'Integer', 'number', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 80, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.066', '0');
INSERT INTO `gen_table_column` VALUES ('0af5ef4e4d6bc356a6509b2f5ee3bb42', '581ba5dfe75066b5a4769b3ed83c4ce1', 'del_flag', '0-正常，1-删除', NULL, 'char(1)', 'String', 'delFlag', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 180, 3, NULL, '1', '2019-07-25 14:58:19.000', '1', '2019-07-25 17:28:07.184', '0');
INSERT INTO `gen_table_column` VALUES ('0b9410298327f9ab090208e959d3dabb', 'db46c9935ed8caae04bcefd5c6ea7f28', 'created_by', 'created_by', NULL, 'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 70, 0, NULL, '1', '2019-07-25 10:28:01.429', '1', '2019-07-25 10:28:01.429', '0');
INSERT INTO `gen_table_column` VALUES ('11afe5a647bae97e46700b72da26053c', '7c0d6295f674ada7a7cf4d651250d855', 'created_date', 'created_date', NULL, 'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 130, 2, NULL, '1', '2019-07-25 14:55:56.000', '1', '2019-07-25 17:18:40.505', '0');
INSERT INTO `gen_table_column` VALUES ('13ade9ca23ead1d93e6b34b35e790605', '6aed6fe18521d641a443171fa9e92893', 'version_', 'version_', NULL, 'int(11)', 'Long', 'version', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 180, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.113', '0');
INSERT INTO `gen_table_column` VALUES ('17a287cb8e93372566a2bde5bea27898', '581ba5dfe75066b5a4769b3ed83c4ce1', 'activated_', 'activated_', NULL, 'bit(1)', 'Integer', 'activated', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'radio', 'sys_flag', NULL, 100, 3, NULL, '1', '2019-07-25 14:58:19.000', '1', '2019-07-25 17:28:07.157', '0');
INSERT INTO `gen_table_column` VALUES ('1c523c474827dfd56bef223e63a83ca7', '7c0d6295f674ada7a7cf4d651250d855', 'phone_', '手机', NULL, 'varchar(32)', 'String', 'phone', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 60, 2, NULL, '1', '2019-07-25 14:55:56.000', '1', '2019-07-25 17:18:40.482', '0');
INSERT INTO `gen_table_column` VALUES ('213279786f4cfe1ba1bf51cf7a727e4a', '7c0d6295f674ada7a7cf4d651250d855', 'created_by', 'created_by', NULL, 'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 120, 2, NULL, '1', '2019-07-25 14:55:56.000', '1', '2019-07-25 17:18:40.501', '0');
INSERT INTO `gen_table_column` VALUES ('23955926ea0d6cc2f0fb9fa8678fbf55', '8addcc278d31bbee16b6936d7a70c98d', 'refresh_token_validity', '刷新令牌有效时间', NULL, 'int(11)', 'Long', 'refreshTokenValidity', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 90, 0, NULL, '1', '2019-07-26 11:12:02.545', '1', '2019-07-26 11:12:02.545', '0');
INSERT INTO `gen_table_column` VALUES ('23e957ff7b9c732514bf0ee5332817f0', 'db46c9935ed8caae04bcefd5c6ea7f28', 'last_modified_by', 'last_modified_by', NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 90, 0, NULL, '1', '2019-07-25 10:28:01.431', '1', '2019-07-25 10:28:01.431', '0');
INSERT INTO `gen_table_column` VALUES ('2f5562914e21030f3cf341864cb6bf8a', '581ba5dfe75066b5a4769b3ed83c4ce1', 'reset_date', 'reset_date', NULL, 'timestamp(3)', 'java.util.Date', 'resetDate', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'dateselect', '', NULL, 140, 3, NULL, '1', '2019-07-25 14:58:19.000', '1', '2019-07-25 17:28:07.170', '0');
INSERT INTO `gen_table_column` VALUES ('369de751f2a36663b39f3d1d94236431', '581ba5dfe75066b5a4769b3ed83c4ce1', 'number_', 'key', NULL, 'int(11)', 'Long', 'number', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 110, 3, NULL, '1', '2019-07-25 14:58:19.000', '1', '2019-07-25 17:28:07.160', '0');
INSERT INTO `gen_table_column` VALUES ('3caf8556b0edd037e47d3fcf9b1cb06c', '6aed6fe18521d641a443171fa9e92893', 'created_date', 'created_date', NULL, 'timestamp', 'java.util.Date', 'createdDate', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 130, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.089', '0');
INSERT INTO `gen_table_column` VALUES ('3e75a10aa0cb5eee1c45cdad10d1bd3a', '6aed6fe18521d641a443171fa9e92893', 'id_', 'id_', NULL, 'varchar(32)', 'String', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.028', '0');
INSERT INTO `gen_table_column` VALUES ('42f20b67074e0cf8595793c4a199ac60', 'db46c9935ed8caae04bcefd5c6ea7f28', 'leaf', '1 叶子节点 0 非叶子节点', NULL, 'bit(1)', 'Integer', 'leaf', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 60, 0, NULL, '1', '2019-07-25 10:28:01.428', '1', '2019-07-25 10:28:01.428', '0');
INSERT INTO `gen_table_column` VALUES ('4a454825fbabfbae670596aca6c0fc83', '8addcc278d31bbee16b6936d7a70c98d', 'client_secret', '客户端密钥', NULL, 'varchar(256)', 'String', 'clientSecret', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 30, 0, NULL, '1', '2019-07-26 11:12:02.533', '1', '2019-07-26 11:12:02.533', '0');
INSERT INTO `gen_table_column` VALUES ('4f93112d3f008fcf4ab3a35a89e2c3be', '7c0d6295f674ada7a7cf4d651250d855', 'description', '备注', NULL, 'varchar(255)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'textarea', '', NULL, 160, 2, NULL, '1', '2019-07-25 14:55:56.000', '1', '2019-07-25 17:18:40.515', '0');
INSERT INTO `gen_table_column` VALUES ('5e6815bcc98ef19b69a5a8a87d4f599d', '581ba5dfe75066b5a4769b3ed83c4ce1', 'parent_id', 'parent_id', NULL, 'varchar(32)', 'String', 'parentId', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 20, 3, NULL, '1', '2019-07-25 14:58:19.000', '1', '2019-07-25 17:28:07.129', '0');
INSERT INTO `gen_table_column` VALUES ('5f43bc1fa39527edd1fbbd3e987d189e', '7c0d6295f674ada7a7cf4d651250d855', 'money_', 'money_', NULL, 'decimal(20,2)', 'Double', 'money', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 90, 2, NULL, '1', '2019-07-25 14:55:56.000', '1', '2019-07-25 17:18:40.492', '0');
INSERT INTO `gen_table_column` VALUES ('5f5e73a6ff49b05991615a59ebc77ccd', '581ba5dfe75066b5a4769b3ed83c4ce1', 'leaf', '1 叶子节点 0 非叶子节点', NULL, 'bit(1)', 'Integer', 'leaf', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 60, 3, NULL, '1', '2019-07-25 14:58:19.000', '1', '2019-07-25 17:28:07.144', '0');
INSERT INTO `gen_table_column` VALUES ('65816071ee11e7e55d153f891e0b863c', '7c0d6295f674ada7a7cf4d651250d855', 'number_', 'key', NULL, 'int(11)', 'Long', 'number', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 80, 2, NULL, '1', '2019-07-25 14:55:56.000', '1', '2019-07-25 17:18:40.489', '0');
INSERT INTO `gen_table_column` VALUES ('6760b607f3fdd951d2c94053e76226c5', '581ba5dfe75066b5a4769b3ed83c4ce1', 'money_', 'money_', NULL, 'decimal(20,2)', 'Double', 'money', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 120, 3, NULL, '1', '2019-07-25 14:58:19.000', '1', '2019-07-25 17:28:07.163', '0');
INSERT INTO `gen_table_column` VALUES ('677b52a641d567bc68fd5e9964cfcbd1', '6aed6fe18521d641a443171fa9e92893', 'last_modified_date', 'last_modified_date', NULL, 'timestamp', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 150, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.099', '0');
INSERT INTO `gen_table_column` VALUES ('6c394ff7afd679500cdf1603f5518d29', '7c0d6295f674ada7a7cf4d651250d855', 'del_flag', '0-正常，1-删除', NULL, 'char(1)', 'String', 'delFlag', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 180, 2, NULL, '1', '2019-07-25 14:55:56.000', '1', '2019-07-25 17:18:40.522', '0');
INSERT INTO `gen_table_column` VALUES ('6c6faf1de9039435e863732118ba6237', 'db46c9935ed8caae04bcefd5c6ea7f28', 'name', '部门名称', NULL, 'varchar(50)', 'String', 'name', b'0', b'1', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 40, 0, NULL, '1', '2019-07-25 10:28:01.425', '1', '2019-07-25 10:28:01.425', '0');
INSERT INTO `gen_table_column` VALUES ('6fd517bdaf9bb1c3d97f93e98d2d5818', '8addcc278d31bbee16b6936d7a70c98d', 'resource_ids', '资源ID', NULL, 'varchar(256)', 'String', 'resourceIds', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 110, 0, NULL, '1', '2019-07-26 11:12:02.531', '1', '2019-07-26 11:12:02.531', '0');
INSERT INTO `gen_table_column` VALUES ('71d61913c75cfbd8e292ea8556a704b0', '8addcc278d31bbee16b6936d7a70c98d', 'client_id', '客户端ID', NULL, 'varchar(32)', 'String', 'clientId', b'1', b'0', b'0', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 10, 0, NULL, '1', '2019-07-26 11:12:02.527', '1', '2019-07-26 11:12:02.527', '0');
INSERT INTO `gen_table_column` VALUES ('7644a064412105de9eec01bdc2ac3de2', '6aed6fe18521d641a443171fa9e92893', 'phone_', '手机', NULL, 'varchar(32)', 'String', 'phone', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 60, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.056', '0');
INSERT INTO `gen_table_column` VALUES ('7899be0c46d895b71a0db0b0975fe181', 'db46c9935ed8caae04bcefd5c6ea7f28', 'created_date', '创建时间', NULL, 'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 80, 0, NULL, '1', '2019-07-25 10:28:01.430', '1', '2019-07-25 10:28:01.430', '0');
INSERT INTO `gen_table_column` VALUES ('7a818e013b9dddc9d59d3e03549f496c', '6aed6fe18521d641a443171fa9e92893', 'description_', '备注', NULL, 'varchar(255)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'textarea', '', NULL, 170, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.108', '0');
INSERT INTO `gen_table_column` VALUES ('7c781fe7b465cf0138963a0da4a21256', 'db46c9935ed8caae04bcefd5c6ea7f28', 'last_modified_date', '修改时间', NULL, 'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 100, 0, NULL, '1', '2019-07-25 10:28:01.432', '1', '2019-07-25 10:28:01.432', '0');
INSERT INTO `gen_table_column` VALUES ('81671246990e2d74946097449c13d8cc', 'db46c9935ed8caae04bcefd5c6ea7f28', 'id', 'id', NULL, 'varchar(32)', 'String', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 0, NULL, '1', '2019-07-25 10:28:01.418', '1', '2019-07-25 10:28:01.418', '0');
INSERT INTO `gen_table_column` VALUES ('84e7532b134e28f3b94328f12e815c48', '581ba5dfe75066b5a4769b3ed83c4ce1', 'last_modified_date', '修改时间', NULL, 'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 190, 3, NULL, '1', '2019-07-25 14:58:19.000', '1', '2019-07-25 17:28:07.188', '0');
INSERT INTO `gen_table_column` VALUES ('85362f26891e9d126ede2279c8609b59', '581ba5dfe75066b5a4769b3ed83c4ce1', 'phone_', '手机', NULL, 'varchar(32)', 'String', 'phone', b'0', b'1', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 90, 3, NULL, '1', '2019-07-25 14:58:19.000', '1', '2019-07-25 17:28:07.153', '0');
INSERT INTO `gen_table_column` VALUES ('85d8630eed04192268495c134ad37c91', '7c0d6295f674ada7a7cf4d651250d855', 'name_', '名称', NULL, 'varchar(50)', 'String', 'name', b'0', b'1', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 40, 2, NULL, '1', '2019-07-25 14:55:56.000', '1', '2019-07-25 17:18:40.475', '0');
INSERT INTO `gen_table_column` VALUES ('8874a7c3155a56474176b5c7995f352a', '581ba5dfe75066b5a4769b3ed83c4ce1', 'amount_', 'amount_', NULL, 'double(11,2)', 'Double', 'amount', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 130, 3, NULL, '1', '2019-07-25 14:58:19.000', '1', '2019-07-25 17:28:07.166', '0');
INSERT INTO `gen_table_column` VALUES ('99994d3d43b891b812b9db40e53a771b', '6aed6fe18521d641a443171fa9e92893', 'status_', 'status_', NULL, 'int(11)', 'Long', 'status', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 160, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.103', '0');
INSERT INTO `gen_table_column` VALUES ('9aba5223e11aecae8be66326c6b884fb', '581ba5dfe75066b5a4769b3ed83c4ce1', 'sort', '排序', NULL, 'int(11)', 'Long', 'sort', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 50, 3, NULL, '1', '2019-07-25 14:58:19.000', '1', '2019-07-25 17:28:07.141', '0');
INSERT INTO `gen_table_column` VALUES ('9b803522d4c92864080d9341a87ac895', 'db46c9935ed8caae04bcefd5c6ea7f28', 'description', '备注', NULL, 'varchar(100)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'textarea', '', NULL, 120, 0, NULL, '1', '2019-07-25 10:28:01.433', '1', '2019-07-25 10:28:01.433', '0');
INSERT INTO `gen_table_column` VALUES ('9bfd8282cd36b26c5e53715a1a40293b', '6aed6fe18521d641a443171fa9e92893', 'money_', 'money_', NULL, 'decimal(20,2)', 'Double', 'money', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 90, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.071', '0');
INSERT INTO `gen_table_column` VALUES ('9d2e9436870e1b3f8208fd724f69b5c6', '581ba5dfe75066b5a4769b3ed83c4ce1', 'created_by', 'created_by', NULL, 'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 150, 3, NULL, '1', '2019-07-25 14:58:19.000', '1', '2019-07-25 17:28:07.174', '0');
INSERT INTO `gen_table_column` VALUES ('9e2ff24156f8f7c5bfba82790c50be20', '581ba5dfe75066b5a4769b3ed83c4ce1', 'last_modified_by', 'last_modified_by', NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 170, 3, NULL, '1', '2019-07-25 14:58:19.000', '1', '2019-07-25 17:28:07.181', '0');
INSERT INTO `gen_table_column` VALUES ('9f620d41a276ede01cf4be9301f37a2d', '6aed6fe18521d641a443171fa9e92893', 'name_', '名称', NULL, 'varchar(50)', 'String', 'name', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 40, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.046', '0');
INSERT INTO `gen_table_column` VALUES ('9f9e94582c7f96573ee2ce0f5422d58a', '7c0d6295f674ada7a7cf4d651250d855', 'version', 'version', NULL, 'int(11)', 'Long', 'version', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 170, 2, NULL, '1', '2019-07-25 14:55:56.000', '1', '2019-07-25 17:18:40.519', '0');
INSERT INTO `gen_table_column` VALUES ('a172d22697aa8f970ddb6dbebdf1b84b', 'db46c9935ed8caae04bcefd5c6ea7f28', 'parent_id', 'parent_id', NULL, 'varchar(32)', 'String', 'parentId', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 20, 0, NULL, '1', '2019-07-25 10:28:01.422', '1', '2019-07-25 10:28:01.422', '0');
INSERT INTO `gen_table_column` VALUES ('a2b0b641d21440d8920ac63337ee265f', '581ba5dfe75066b5a4769b3ed83c4ce1', 'author_', '作者', NULL, 'varchar(50)', 'String', 'author', b'0', b'0', b'0', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 70, 3, NULL, '1', '2019-07-25 14:58:19.000', '1', '2019-07-25 17:28:07.147', '0');
INSERT INTO `gen_table_column` VALUES ('a7645dc329637ff9ed3b1bf1a07a43b6', '581ba5dfe75066b5a4769b3ed83c4ce1', 'id', 'id', NULL, 'varchar(32)', 'String', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 3, NULL, '1', '2019-07-25 14:58:19.000', '1', '2019-07-25 17:28:07.125', '0');
INSERT INTO `gen_table_column` VALUES ('a76d66fe331b2e564a830fcf457a7377', '6aed6fe18521d641a443171fa9e92893', 'activated_', 'activated_', NULL, 'bit(1)', 'Integer', 'activated', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 70, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.061', '0');
INSERT INTO `gen_table_column` VALUES ('aa239c70b49d022c7080a1b627e30db7', '8addcc278d31bbee16b6936d7a70c98d', 'scope', '作用域', NULL, 'varchar(256)', 'String', 'scope', b'0', b'0', b'0', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 40, 0, NULL, '1', '2019-07-26 11:12:02.534', '1', '2019-07-26 11:12:02.534', '0');
INSERT INTO `gen_table_column` VALUES ('ab00fc0a1f91793a5a751a3d2bcc95b2', '8addcc278d31bbee16b6936d7a70c98d', 'autoapprove', '是否自动放行', NULL, 'varchar(256)', 'String', 'autoapprove', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 45, 0, NULL, '1', '2019-07-26 11:12:02.547', '1', '2019-07-26 11:12:02.547', '0');
INSERT INTO `gen_table_column` VALUES ('b25f05215a6dc316fcc02a07d8a19e36', '8addcc278d31bbee16b6936d7a70c98d', 'access_token_validity', '请求令牌有效时间', NULL, 'int(11)', 'Long', 'accessTokenValidity', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 80, 0, NULL, '1', '2019-07-26 11:12:02.542', '1', '2019-07-26 11:12:02.542', '0');
INSERT INTO `gen_table_column` VALUES ('b261660f4374ab99c042700277ab66af', 'db46c9935ed8caae04bcefd5c6ea7f28', 'del_flag', '0-正常，1-删除', NULL, 'char(1)', 'String', 'delFlag', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 130, 0, NULL, '1', '2019-07-25 10:28:01.434', '1', '2019-07-25 10:28:01.434', '0');
INSERT INTO `gen_table_column` VALUES ('b525639e645119a9f69f2472166d0e34', '581ba5dfe75066b5a4769b3ed83c4ce1', 'name', '部门名称', NULL, 'varchar(50)', 'String', 'name', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 40, 3, NULL, '1', '2019-07-25 14:58:19.000', '1', '2019-07-25 17:28:07.137', '0');
INSERT INTO `gen_table_column` VALUES ('b8a151c7c7aac1309493648b8666e7c5', '6aed6fe18521d641a443171fa9e92893', 'created_by', 'created_by', NULL, 'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 120, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.085', '0');
INSERT INTO `gen_table_column` VALUES ('ba4fe0313cadacd1a484a7e47a47258f', '7c0d6295f674ada7a7cf4d651250d855', 'reset_date', 'reset_date', NULL, 'timestamp(3)', 'java.util.Date', 'resetDate', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'dateselect', '', NULL, 110, 2, NULL, '1', '2019-07-25 14:55:56.000', '1', '2019-07-25 17:18:40.498', '0');
INSERT INTO `gen_table_column` VALUES ('bcbff4f8f7380f2f0b37311bca509ad1', '581ba5dfe75066b5a4769b3ed83c4ce1', 'email_', '邮箱', NULL, 'varchar(100)', 'String', 'email', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 80, 3, NULL, '1', '2019-07-25 14:58:19.000', '1', '2019-07-25 17:28:07.150', '0');
INSERT INTO `gen_table_column` VALUES ('bd48ae3b1ebe195921c5da3c9ebdfdc9', '581ba5dfe75066b5a4769b3ed83c4ce1', 'version', 'version', NULL, 'int(11)', 'Long', 'version', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 200, 3, NULL, '1', '2019-07-25 14:58:19.000', '1', '2019-07-25 17:28:07.191', '0');
INSERT INTO `gen_table_column` VALUES ('c05bf82fde1d193dba8e3dc8982eabb9', '581ba5dfe75066b5a4769b3ed83c4ce1', 'parent_ids', '父菜单IDs', NULL, 'varchar(2000)', 'String', 'parentIds', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 30, 3, NULL, '1', '2019-07-25 14:58:19.000', '1', '2019-07-25 17:28:07.133', '0');
INSERT INTO `gen_table_column` VALUES ('c6c341b71d428cf7f261b4f3a4027ac0', '7c0d6295f674ada7a7cf4d651250d855', 'last_modified_date', 'last_modified_date', NULL, 'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 150, 2, NULL, '1', '2019-07-25 14:55:56.000', '1', '2019-07-25 17:18:40.511', '0');
INSERT INTO `gen_table_column` VALUES ('c90414ff74d0b32507dafe3aea3e6b91', '7c0d6295f674ada7a7cf4d651250d855', 'email_', '邮箱', NULL, 'varchar(100)', 'String', 'email', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 50, 2, NULL, '1', '2019-07-25 14:55:56.000', '1', '2019-07-25 17:18:40.478', '0');
INSERT INTO `gen_table_column` VALUES ('c9782de5e492e62b8872e6c9fe63f83f', '6aed6fe18521d641a443171fa9e92893', 'amount_', 'amount_', NULL, 'double(11,2)', 'Double', 'amount', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 100, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.076', '0');
INSERT INTO `gen_table_column` VALUES ('cb0cc60e1f568ed16b8e70cc6651e141', '8addcc278d31bbee16b6936d7a70c98d', 'additional_information', '扩展信息', NULL, 'varchar(4096)', 'String', 'additionalInformation', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 100, 0, NULL, '1', '2019-07-26 11:12:02.546', '1', '2019-07-26 11:12:02.546', '0');
INSERT INTO `gen_table_column` VALUES ('d0fbc71db584f5483b108f47c24b7b24', '7c0d6295f674ada7a7cf4d651250d855', 'title_', '标题', NULL, 'varchar(32)', 'String', 'title', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 20, 2, NULL, '1', '2019-07-25 14:55:56.000', '1', '2019-07-25 17:18:40.468', '0');
INSERT INTO `gen_table_column` VALUES ('d39e2a5d74ca674d1a59666b1005d258', '6aed6fe18521d641a443171fa9e92893', 'title_', '标题', NULL, 'varchar(32)', 'String', 'title', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 20, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.036', '0');
INSERT INTO `gen_table_column` VALUES ('d4aa80d1a3ab880d96f6e3114b1c1ab6', '8addcc278d31bbee16b6936d7a70c98d', 'web_server_redirect_uri', '重定向地址', NULL, 'varchar(256)', 'String', 'webServerRedirectUri', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 60, 0, NULL, '1', '2019-07-26 11:12:02.539', '1', '2019-07-26 11:12:02.539', '0');
INSERT INTO `gen_table_column` VALUES ('d51560e8721d5d9aa0300c25f3855155', '7c0d6295f674ada7a7cf4d651250d855', 'author_', '作者', NULL, 'varchar(50)', 'String', 'author', b'0', b'0', b'0', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 30, 2, NULL, '1', '2019-07-25 14:55:56.000', '1', '2019-07-25 17:18:40.471', '0');
INSERT INTO `gen_table_column` VALUES ('d88ff10db4f84147d504fc0fbd605ceb', '7c0d6295f674ada7a7cf4d651250d855', 'activated_', 'activated_', NULL, 'bit(1)', 'Integer', 'activated', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'radio', 'sys_flag', NULL, 70, 2, NULL, '1', '2019-07-25 14:55:56.000', '1', '2019-07-25 17:18:40.485', '0');
INSERT INTO `gen_table_column` VALUES ('e04faad4cee1eec6ee3cdc7636276c1b', '6aed6fe18521d641a443171fa9e92893', 'reset_date', 'reset_date', NULL, 'timestamp', 'java.util.Date', 'resetDate', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'dateselect', '', NULL, 110, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.080', '0');
INSERT INTO `gen_table_column` VALUES ('e0f3898711892f794bfb15ba30c407e5', 'db46c9935ed8caae04bcefd5c6ea7f28', 'sort', '排序', NULL, 'int(11)', 'Long', 'sort', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 50, 0, NULL, '1', '2019-07-25 10:28:01.426', '1', '2019-07-25 10:28:01.426', '0');
INSERT INTO `gen_table_column` VALUES ('e4f79152724169162574489621e68f46', '8addcc278d31bbee16b6936d7a70c98d', 'authorities', '权限', NULL, 'varchar(256)', 'String', 'authorities', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 70, 0, NULL, '1', '2019-07-26 11:12:02.540', '1', '2019-07-26 11:12:02.540', '0');
INSERT INTO `gen_table_column` VALUES ('e572dd69b916c5db2ad3b0ab5a593572', '6aed6fe18521d641a443171fa9e92893', 'author_', '作者', NULL, 'varchar(50)', 'String', 'author', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 30, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.041', '0');
INSERT INTO `gen_table_column` VALUES ('e706aed2cd00c7b2df701c707a2c3650', '6aed6fe18521d641a443171fa9e92893', 'email_', '邮箱', NULL, 'varchar(100)', 'String', 'email', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 50, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.051', '0');
INSERT INTO `gen_table_column` VALUES ('e7d739918f4395bf018c8536c54ba8a8', '8addcc278d31bbee16b6936d7a70c98d', 'authorized_grant_types', '授权方式', NULL, 'varchar(256)', 'String', 'authorizedGrantTypes', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 50, 0, NULL, '1', '2019-07-26 11:12:02.536', '1', '2019-07-26 11:12:02.536', '0');
INSERT INTO `gen_table_column` VALUES ('ea3302c65612ea668ace61cb3049741a', 'db46c9935ed8caae04bcefd5c6ea7f28', 'version', 'version', NULL, 'int(11)', 'Long', 'version', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 110, 0, NULL, '1', '2019-07-25 10:28:01.433', '1', '2019-07-25 10:28:01.433', '0');
INSERT INTO `gen_table_column` VALUES ('ebd42b7dd2a110a29bccae26e329cb91', '581ba5dfe75066b5a4769b3ed83c4ce1', 'description', '备注', NULL, 'varchar(100)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'textarea', '', NULL, 210, 3, NULL, '1', '2019-07-25 14:58:19.000', '1', '2019-07-25 17:28:07.194', '0');
INSERT INTO `gen_table_column` VALUES ('ee7ec3af0723d0011f252e02caaf5cb6', 'db46c9935ed8caae04bcefd5c6ea7f28', 'parent_ids', '父菜单IDs', NULL, 'varchar(2000)', 'String', 'parentIds', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 30, 0, NULL, '1', '2019-07-25 10:28:01.423', '1', '2019-07-25 10:28:01.423', '0');
INSERT INTO `gen_table_column` VALUES ('f1cfb69740f1af1ac96cefad012b3925', '7c0d6295f674ada7a7cf4d651250d855', 'amount_', 'amount_', NULL, 'double(11,2)', 'Double', 'amount', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 100, 2, NULL, '1', '2019-07-25 14:55:56.000', '1', '2019-07-25 17:18:40.495', '0');
INSERT INTO `gen_table_column` VALUES ('f7e752965899142d20993833ddf7dae4', '7c0d6295f674ada7a7cf4d651250d855', 'id', 'id', NULL, 'varchar(32)', 'String', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 2, NULL, '1', '2019-07-25 14:55:56.000', '1', '2019-07-25 17:18:40.463', '0');
INSERT INTO `gen_table_column` VALUES ('fb5e5e7f6f8f63073ec7db1c83db54e1', '6aed6fe18521d641a443171fa9e92893', 'last_modified_by', 'last_modified_by', NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 140, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.094', '0');
INSERT INTO `gen_table_column` VALUES ('fe7dddf98e8ee756fab853223deb1e24', '7c0d6295f674ada7a7cf4d651250d855', 'last_modified_by', 'last_modified_by', NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 140, 2, NULL, '1', '2019-07-25 14:55:56.000', '1', '2019-07-25 17:18:40.508', '0');

-- ----------------------------
-- Table structure for gen_table_fk
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_fk`;
CREATE TABLE `gen_table_fk`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编号',
  `gen_table_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '归属表编号',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `comments` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `jdbc_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列的数据类型的字节长度',
  `java_type` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否主键',
  `is_unique` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '是否唯一（1：是；0：否）',
  `is_null` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否可为空',
  `is_insert` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段',
  `is_edit` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段',
  `is_list` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否列表字段',
  `is_query` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否查询字段',
  `query_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '查询方式（等于、不等于、大于、小于、范围、左LIKE、右LIKE、左右LIKE）',
  `show_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段生成方案（文本框、文本域、下拉框、复选框、单选框、字典选择、人员选择、部门选择、区域选择）',
  `dict_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典类型',
  `settings` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '其它设置（扩展字段JSON）',
  `sort` decimal(10, 0) NULL DEFAULT NULL COMMENT '排序（升序）',
  `version` int(11) NULL DEFAULT 0 COMMENT '默认0，必填，离线乐观锁',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `gen_table_column_table_id`(`gen_table_id`) USING BTREE,
  INDEX `gen_table_column_name`(`name`) USING BTREE,
  INDEX `gen_table_column_sort`(`sort`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `parent_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `parent_ids` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父菜单IDs',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门名称',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `leaf` bit(1) NULL DEFAULT b'0' COMMENT '1 叶子节点 0 非叶子节点',
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
  `version` int(11) NOT NULL,
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES ('1', '-1', NULL, '山东农信', NULL, b'0', '', '2018-01-22 19:00:23.000', NULL, '2019-07-04 16:57:18.000', 0, '', '0');
INSERT INTO `sys_dept` VALUES ('10', '8', NULL, '院校沙县', NULL, b'0', '', '2018-12-10 21:19:26.000', NULL, '2019-06-15 10:56:41.000', 0, '', '0');
INSERT INTO `sys_dept` VALUES ('2', '-1', NULL, '沙县国际', NULL, b'0', '', '2018-01-22 19:00:38.000', NULL, '2019-07-04 16:57:22.000', 0, '', '0');
INSERT INTO `sys_dept` VALUES ('3', '1', NULL, '潍坊农信', NULL, b'0', '', '2018-01-22 19:00:44.000', NULL, '2019-06-15 10:56:41.000', 0, '', '0');
INSERT INTO `sys_dept` VALUES ('4', '3', NULL, '高新农信', 30, b'0', '', '2018-01-22 19:00:52.000', '1', '2019-07-14 09:02:57.000', 6, '', '0');
INSERT INTO `sys_dept` VALUES ('5', '4', NULL, '院校农信', 30, b'0', '', '2018-01-22 19:00:57.000', '1', '2019-07-14 09:10:44.000', 1, '', '0');
INSERT INTO `sys_dept` VALUES ('5f86e2a82b040b1f618aefc62f403024', '5', '5,', '11', 1, b'1', '1', '2019-07-14 09:10:45.000', '1', '2019-07-14 09:10:57.000', 0, NULL, '1');
INSERT INTO `sys_dept` VALUES ('6', '5', NULL, '潍院农信', NULL, b'0', '', '2018-01-22 19:01:06.000', NULL, '2019-01-09 10:58:18.000', 0, '', '0');
INSERT INTO `sys_dept` VALUES ('7', '2', NULL, '山东沙县', NULL, b'0', '', '2018-01-22 19:01:57.000', NULL, '2019-06-15 10:56:41.000', 0, '', '0');
INSERT INTO `sys_dept` VALUES ('8', '7', NULL, '潍坊沙县', NULL, b'0', '', '2018-01-22 19:02:03.000', NULL, '2019-06-15 10:56:41.000', 0, '', '0');
INSERT INTO `sys_dept` VALUES ('9', '8', NULL, '高新沙县', NULL, b'0', '', '2018-01-22 19:02:14.000', NULL, '2018-09-13 01:46:44.000', 0, '', '0');

-- ----------------------------
-- Table structure for sys_dept_relation
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept_relation`;
CREATE TABLE `sys_dept_relation`  (
  `ancestor` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL COMMENT '祖先节点',
  `descendant` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL COMMENT '后代节点',
  PRIMARY KEY (`ancestor`, `descendant`) USING BTREE,
  INDEX `idx1`(`ancestor`) USING BTREE,
  INDEX `idx2`(`descendant`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci COMMENT = '部门关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept_relation
-- ----------------------------
INSERT INTO `sys_dept_relation` VALUES ('1', '1');
INSERT INTO `sys_dept_relation` VALUES ('1', '3');
INSERT INTO `sys_dept_relation` VALUES ('1', '4');
INSERT INTO `sys_dept_relation` VALUES ('1', '5');
INSERT INTO `sys_dept_relation` VALUES ('10', '10');
INSERT INTO `sys_dept_relation` VALUES ('11', '11');
INSERT INTO `sys_dept_relation` VALUES ('2', '11');
INSERT INTO `sys_dept_relation` VALUES ('2', '2');
INSERT INTO `sys_dept_relation` VALUES ('2', '7');
INSERT INTO `sys_dept_relation` VALUES ('2', '8');
INSERT INTO `sys_dept_relation` VALUES ('3', '3');
INSERT INTO `sys_dept_relation` VALUES ('3', '4');
INSERT INTO `sys_dept_relation` VALUES ('3', '5');
INSERT INTO `sys_dept_relation` VALUES ('4', '4');
INSERT INTO `sys_dept_relation` VALUES ('4', '5');
INSERT INTO `sys_dept_relation` VALUES ('5', '5');
INSERT INTO `sys_dept_relation` VALUES ('7', '11');
INSERT INTO `sys_dept_relation` VALUES ('7', '7');
INSERT INTO `sys_dept_relation` VALUES ('7', '8');
INSERT INTO `sys_dept_relation` VALUES ('8', '11');
INSERT INTO `sys_dept_relation` VALUES ('8', '8');

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编号',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标签名',
  `val` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据值',
  `code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类型',
  `parent_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父菜单ID',
  `parent_ids` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父菜单IDs',
  `sort` int(10) NOT NULL COMMENT '排序（升序）',
  `show` bit(1) NULL DEFAULT NULL COMMENT '是否显示1 是0否',
  `leaf` bit(1) NULL DEFAULT b'0' COMMENT '1 叶子节点 0 非叶子节点',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注信息',
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `last_modified_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '更新时间',
  `version` int(11) NOT NULL DEFAULT 0,
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sys_dict_value`(`val`) USING BTREE,
  INDEX `sys_dict_label`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES ('0da02abef85f0c0b4350eaeefb4ca78d', '仅本人数据', '4', 'sys_data_scope_4', 'aa294a48211a2deb5c7d76c5e90dc28e', '1,cfd5f62f601817a3b0f38f5ccb1f5128,aa294a48211a2deb5c7d76c5e90dc28e,', 40, b'1', b'1', NULL, '1', '2019-07-14 06:00:03.000', '1', '2019-07-14 06:01:55.000', 1, NULL, '0');
INSERT INTO `sys_dict` VALUES ('0fdd548394368b4969136f32c435fd98', '按钮', '1', 'sys_menu_type_1', 'e26ee931e276a099fb876541ca18756f', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e26ee931e276a099fb876541ca18756f,', 20, b'1', b'1', NULL, '1', '2019-07-14 06:04:44.000', '1', '2019-07-14 06:04:44.000', 0, NULL, '0');
INSERT INTO `sys_dict` VALUES ('1', '数据字典', '', 'base', '-1', NULL, 1, b'1', b'0', '', '1', '2018-07-09 06:16:14.000', '1', '2019-07-14 05:06:23.000', 7, '', '0');
INSERT INTO `sys_dict` VALUES ('2', '是否标识', 'sys_flag', 'sys_flag', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 10, b'1', b'0', NULL, '1', '2019-06-02 17:17:44.000', '1', '2019-07-14 06:01:55.000', 13, NULL, '0');
INSERT INTO `sys_dict` VALUES ('269ebbfff898cf1db0d243e3f7774d2c', '业务数据', 'biz', 'biz', '1', '1,', 30, b'1', b'1', NULL, '1', '2019-07-14 04:01:51.000', '1', '2019-07-14 05:06:23.000', 1, NULL, '0');
INSERT INTO `sys_dict` VALUES ('3', '是', '1', 'sys_flag_yes', '2', '1,cfd5f62f601817a3b0f38f5ccb1f5128,2,', 10, b'1', b'1', '', '1', '2018-07-09 06:15:40.000', '1', '2019-07-14 06:01:55.000', 2, '', '0');
INSERT INTO `sys_dict` VALUES ('4', '否', '0', 'sys_flag_no', '2', '1,cfd5f62f601817a3b0f38f5ccb1f5128,2,', 30, b'1', b'1', NULL, '1', '2019-06-02 17:26:40.000', '1', '2019-07-14 06:01:55.000', 3, NULL, '0');
INSERT INTO `sys_dict` VALUES ('4198b5e10fe052546ebb689b4103590e', '所在机构数据', '3', 'sys_data_scope_3', 'aa294a48211a2deb5c7d76c5e90dc28e', '1,cfd5f62f601817a3b0f38f5ccb1f5128,aa294a48211a2deb5c7d76c5e90dc28e,', 30, b'1', b'1', NULL, '1', '2019-07-14 05:59:13.000', '1', '2019-07-14 06:01:55.000', 3, NULL, '0');
INSERT INTO `sys_dict` VALUES ('5933a853cd0199b00424d66f4b92dda3', '所在机构及以下数据', '2', 'sys_data_scope_2', 'aa294a48211a2deb5c7d76c5e90dc28e', '1,cfd5f62f601817a3b0f38f5ccb1f5128,aa294a48211a2deb5c7d76c5e90dc28e,', 20, b'1', b'1', NULL, '1', '2019-07-14 05:53:55.000', '1', '2019-07-14 06:01:55.000', 3, NULL, '0');
INSERT INTO `sys_dict` VALUES ('6e4bba74f32df9149d69f8e9bb19cd9d', '菜单', '0', 'sys_menu_type_0', 'e26ee931e276a099fb876541ca18756f', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e26ee931e276a099fb876541ca18756f,', 10, b'1', b'1', NULL, '1', '2019-07-14 06:04:10.000', '1', '2019-07-14 06:04:10.000', 0, NULL, '0');
INSERT INTO `sys_dict` VALUES ('8c4589d0a32c9b84b6254507354a195b', 'test', 'test', 'test', '-1', NULL, 30, b'1', b'1', NULL, '1', '2019-07-14 03:59:38.000', '1', '2019-07-14 04:00:28.000', 0, NULL, '1');
INSERT INTO `sys_dict` VALUES ('a5dfce34bdb7aa99560e8c0d393a632f', '全部', '1', 'sys_data_scope_1', 'aa294a48211a2deb5c7d76c5e90dc28e', '1,cfd5f62f601817a3b0f38f5ccb1f5128,aa294a48211a2deb5c7d76c5e90dc28e,', 10, b'1', b'1', NULL, '1', '2019-07-14 05:52:44.000', '1', '2019-07-14 06:01:55.000', 3, NULL, '0');
INSERT INTO `sys_dict` VALUES ('aa294a48211a2deb5c7d76c5e90dc28e', '数据范围', 'sys_data_scope', 'sys_data_scope', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', NULL, '1', '2019-07-14 05:50:08.000', '1', '2019-07-14 06:01:55.000', 12, NULL, '0');
INSERT INTO `sys_dict` VALUES ('c46ec99af2c1f967bf10cf2c0d96a6c5', '按明细设置', '5', 'sys_data_scope_5', 'aa294a48211a2deb5c7d76c5e90dc28e', '1,cfd5f62f601817a3b0f38f5ccb1f5128,aa294a48211a2deb5c7d76c5e90dc28e,', 50, b'1', b'1', NULL, '1', '2019-07-14 06:01:11.000', '1', '2019-07-14 06:01:55.000', 1, NULL, '0');
INSERT INTO `sys_dict` VALUES ('cfd5f62f601817a3b0f38f5ccb1f5128', '系统数据', 'sys', 'sys', '1', '1,', 30, b'1', b'0', NULL, '1', '2019-07-14 01:13:12.000', '1', '2019-07-14 06:01:55.000', 7, NULL, '0');
INSERT INTO `sys_dict` VALUES ('e26ee931e276a099fb876541ca18756f', '菜单类型', 'sys_menu_type', 'sys_menu_type', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', NULL, '1', '2019-07-14 06:01:48.000', '1', '2019-07-14 06:04:44.000', 3, NULL, '0');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `id` bigint(64) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '日志类型',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '日志标题',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `service_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '服务ID',
  `remote_addr` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作IP地址',
  `user_agent` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户代理',
  `request_uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求URI',
  `method` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作方式',
  `params` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '操作提交的数据',
  `time` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '执行时间',
  `exception` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '异常信息',
  `created_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '更新时间',
  `version` int(11) NOT NULL,
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sys_log_create_by`(`created_by`) USING BTREE,
  INDEX `sys_log_request_uri`(`request_uri`) USING BTREE,
  INDEX `sys_log_type`(`type`) USING BTREE,
  INDEX `sys_log_create_date`(`created_date`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES (51, '0', '添加角色', 'admin', 'test', '0:0:0:0:0:0:0:1', 'PostmanRuntime/7.6.0', '/role', 'POST', 'Authorization=%5B%5D', '65', NULL, '1', '2019-01-24 20:56:43.000', NULL, '2019-07-26 10:54:23.249', 0, '', '0');
INSERT INTO `sys_log` VALUES (52, '0', '更新菜单', 'admin', 'pig', '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36', '/menu', 'PUT', '', '40', NULL, '1', '2019-04-27 14:55:07.000', NULL, '2019-07-26 10:54:23.256', 0, '', '0');
INSERT INTO `sys_log` VALUES (53, '0', '更新菜单', 'admin', 'pig', '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36', '/menu', 'PUT', '', '31', NULL, '1', '2019-04-27 14:55:19.000', NULL, '2019-07-26 10:54:23.258', 0, '', '0');
INSERT INTO `sys_log` VALUES (54, '0', '删除菜单', 'admin', 'pig', '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.108 Safari/537.36', '/menu/9999', 'DELETE', '', '195', NULL, '1', '2019-04-27 15:45:30.000', NULL, '2019-07-26 10:54:23.261', 0, '', '0');
INSERT INTO `sys_log` VALUES (55, '0', '锁定/解锁用户', 'admin', 'albedo', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.86 Safari/537.36', '/sys/user/90da0206c39867a1b36ac36ced80c1a9', 'PUT', '', '10', NULL, '1', '2019-07-07 22:16:43.000', 'system', '2019-07-26 10:54:23.264', 0, NULL, '0');
INSERT INTO `sys_log` VALUES (56, '0', '锁定/解锁用户', 'admin', 'albedo', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.86 Safari/537.36', '/sys/user/90da0206c39867a1b36ac36ced80c1a9', 'PUT', '', '63818', NULL, '1', '2019-07-07 22:19:27.000', 'system', '2019-07-26 10:54:23.267', 0, NULL, '0');
INSERT INTO `sys_log` VALUES (57, '1', '删除菜单', 'admin', 'albedo', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36', '/menu/663848c0f8206dba3fd2425812fd2fbf', 'DELETE', '', '28', NULL, 'system', '2019-07-26 11:15:45.309', 'system', '2019-07-26 11:15:45.309', 0, NULL, '0');
INSERT INTO `sys_log` VALUES (58, '1', '删除菜单', 'admin', 'albedo', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36', '/menu/ba842f6e126664a139c79f97a6bc01a9', 'DELETE', '', '20', NULL, 'system', '2019-07-26 11:16:02.388', 'system', '2019-07-26 11:16:02.388', 0, NULL, '0');
INSERT INTO `sys_log` VALUES (59, '1', '删除菜单', 'admin', 'albedo', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36', '/menu/4026ad4683346e478306cdb1559e2e7e', 'DELETE', '', '19', NULL, 'system', '2019-07-26 11:16:19.698', 'system', '2019-07-26 11:16:19.698', 0, NULL, '0');
INSERT INTO `sys_log` VALUES (60, '1', '删除菜单', 'admin', 'albedo', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36', '/menu/aa74553ef25bbd93d3a921f37177b66b', 'DELETE', '', '21', NULL, 'system', '2019-07-26 11:16:21.731', 'system', '2019-07-26 11:16:21.731', 0, NULL, '0');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单ID',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
  `permission` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单权限标识',
  `path` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '前端URL',
  `parent_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父菜单ID',
  `parent_ids` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父菜单IDs',
  `icon` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `component` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'VUE页面',
  `keep_alive` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '是否显示1 是0否',
  `show` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '是否显示1 是0否',
  `type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单类型 （0菜单 1按钮）',
  `leaf` bit(1) NULL DEFAULT b'0' COMMENT '1 叶子节点 0 非叶子节点',
  `sort` int(11) NULL DEFAULT 1 COMMENT '排序值',
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '更新时间',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `version` int(11) NOT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1000', '权限管理', NULL, '/upms', '-1', NULL, 'icon-quanxianguanli', 'Layout', '0', '1', '0', b'0', 0, '', '2018-09-28 08:29:53.000', '1', '2019-07-20 12:03:09.000', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('1100', '用户管理', NULL, 'user', '1000', '1000,', 'icon-yonghuguanli', 'views/sys/user/index', '0', '1', '0', b'0', 1, '', '2017-11-02 22:24:37.000', '1', '2019-07-26 13:36:28.190', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('1101', '用户编辑', 'sys_user_edit', NULL, '1100', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2017-11-08 09:52:09.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1102', '用户锁定', 'sys_user_lock', NULL, '1100', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2017-11-08 09:52:48.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1103', '用户删除', 'sys_user_del', NULL, '1100', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2017-11-08 09:54:01.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1200', '菜单管理', NULL, 'menu', '1000', NULL, 'icon-caidanguanli', 'views/sys/menu/index', '0', '1', '0', b'0', 2, '', '2017-11-08 09:57:27.000', NULL, '2019-07-26 13:36:31.981', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1201', '菜单编辑', 'sys_menu_edit', NULL, '1200', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2017-11-08 10:15:53.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1202', '菜单锁定', 'sys_menu_lock', NULL, '1200', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2017-11-08 10:16:23.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1203', '菜单删除', 'sys_menu_del', NULL, '1200', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2017-11-08 10:16:43.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('128a83339ca7f4b0ccb4379e4ffdf24a', '测试书籍管理编辑', 'test_testBook_edit', NULL, '50a572de4e409ea88ec94c3f8ba9fc60', NULL, NULL, NULL, '0', '1', '1', b'0', 40, 'system', '2019-07-25 16:09:45.789', 'system', '2019-07-25 16:15:29.907', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('1300', '角色管理', NULL, 'role', '1000', NULL, 'icon-jiaoseguanli', 'views/sys/role/index', '0', '1', '0', b'0', 3, '', '2017-11-08 10:13:37.000', NULL, '2019-07-26 13:36:36.703', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1301', '角色编辑', 'sys_role_edit', NULL, '1300', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2017-11-08 10:14:18.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1302', '角色锁定', 'sys_role_lock', NULL, '1300', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2017-11-08 10:14:41.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1303', '角色删除', 'sys_role_del', NULL, '1300', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2017-11-08 10:14:59.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1304', '分配权限', 'sys_role_perm', NULL, '1300', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2018-04-20 07:22:55.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1400', '部门管理', NULL, 'dept', '1000', NULL, 'icon-web-icon-', 'views/sys/dept/index', '0', '1', '0', b'0', 4, '', '2018-01-20 13:17:19.000', NULL, '2019-07-26 13:36:40.740', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1401', '部门编辑', 'sys_dept_edit', NULL, '1400', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2018-01-20 14:56:16.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1402', '部门锁定', 'sys_dept_lock', NULL, '1400', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2018-01-20 14:56:59.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1403', '部门删除', 'sys_dept_del', NULL, '1400', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2018-01-20 14:57:28.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('148821a9b6397dd3549d193c3036ddf5', '测试书籍管理编辑', 'test_testBook_edit', NULL, 'aa74553ef25bbd93d3a921f37177b66b', NULL, NULL, NULL, '0', '1', '1', b'0', 40, 'system', '2019-07-25 16:15:29.922', 'system', '2019-07-26 11:13:44.827', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('14a5edd0bd4060d28986aa8dfc44045a', '测试书籍管理查看', 'test_testBook_view', NULL, '50a572de4e409ea88ec94c3f8ba9fc60', NULL, NULL, NULL, '0', '1', '1', b'0', 20, 'system', '2019-07-25 16:09:45.785', 'system', '2019-07-25 16:15:29.907', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('163dab3b2d62dd161104f3f8649930a4', '测试书籍管理', NULL, 'TestBook', '413892fe8d52c1163d6659f51299dc96', NULL, 'icon-right-square', 'views/test/testBook/index', '0', '1', '0', b'0', 30, 'system', '2019-07-25 13:31:23.951', 'system', '2019-07-25 16:09:45.773', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('2000', '系统管理', NULL, '/sys', '-1', NULL, 'icon-xitongguanli', 'Layout', '0', '1', '0', b'0', 1, '', '2017-11-07 20:56:00.000', NULL, '2019-07-26 13:10:16.274', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('2100', '日志管理', NULL, 'log', '2000', NULL, 'icon-rizhiguanli', 'views/sys/log/index', '0', '1', '0', b'0', 5, '', '2017-11-20 14:06:22.000', NULL, '2019-07-26 13:36:45.088', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('2101', '日志删除', 'sys_log_del', NULL, '2100', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2017-11-20 20:37:37.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('2200', '字典管理', NULL, 'dict', '2000', NULL, 'icon-navicon-zdgl', 'views/sys/dict/index', '0', '1', '0', b'0', 6, '', '2017-11-29 11:30:52.000', NULL, '2019-07-26 13:36:48.667', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('2201', '字典删除', 'sys_dict_del', NULL, '2200', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2017-11-29 11:30:11.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('2202', '字典编辑', 'sys_dict_edit', NULL, '2200', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2018-05-11 22:34:55.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('2400', '终端管理', '', 'client', '2000', NULL, 'icon-shouji', 'views/sys/client/index', '0', '1', '0', b'0', 9, '', '2018-01-20 13:17:19.000', NULL, '2019-07-26 13:36:52.682', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('2401', '客户端新增', 'sys_client_add', NULL, '2400', NULL, '1', NULL, '0', '1', '1', b'0', NULL, '', '2018-05-15 21:35:18.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('2402', '客户端修改', 'sys_client_edit', NULL, '2400', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2018-05-15 21:37:06.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('2403', '客户端删除', 'sys_client_del', NULL, '2400', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2018-05-15 21:39:16.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('247071d42ff40267c8d8c44eac92da67', '生成方案', NULL, 'scheme', '413892fe8d52c1163d6659f51299dc96', '413892fe8d52c1163d6659f51299dc96,', 'icon-appstore', 'views/gen/scheme/index', '0', '1', '0', b'0', 40, '1', '2019-07-21 13:27:35.000', '1', '2019-07-25 13:32:33.326', NULL, 6, '0');
INSERT INTO `sys_menu` VALUES ('2500', '服务监控', NULL, 'http://139.224.200.249:15001', '2000', NULL, 'icon-server', NULL, '0', '1', '0', b'0', 10, '', '2018-06-26 10:50:32.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('2600', '令牌管理', NULL, 'token', '2000', NULL, 'icon-denglvlingpai', 'views/sys/token/index', '0', '1', '0', b'0', 11, '', '2018-09-04 05:58:41.000', NULL, '2019-07-26 13:39:01.085', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('2601', '令牌删除', 'sys_token_del', NULL, '2600', NULL, NULL, NULL, '0', '1', '1', b'0', 1, '', '2018-09-04 05:59:50.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('3a41196054c6af8ff5dfc5926e7406a0', '测试树书管理查看', 'test_testTreeBook_view', NULL, '4026ad4683346e478306cdb1559e2e7e', NULL, NULL, NULL, '0', '1', '1', b'0', 20, 'system', '2019-07-25 16:15:25.960', 'system', '2019-07-26 11:12:47.976', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('3fe010c12bb466aa3255dc269293e752', '测试树书管理', NULL, 'TestTreeBook', '413892fe8d52c1163d6659f51299dc96', NULL, 'icon-right-square', 'views/test/testTreeBook/index', '0', '1', '0', b'0', 30, 'system', '2019-07-25 16:09:40.703', 'system', '2019-07-25 16:15:25.946', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('4026ad4683346e478306cdb1559e2e7e', '测试树书管理', NULL, 'testTreeBook', '413892fe8d52c1163d6659f51299dc96', NULL, 'icon-right-square', 'views/test/testTreeBook/index', '0', '1', '0', b'0', 30, 'system', '2019-07-25 16:15:25.955', 'system', '2019-07-26 11:16:19.679', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('413892fe8d52c1163d6659f51299dc96', '代码生成', NULL, '/gen', '-1', NULL, 'icon-weibiaoti46', 'Layout', '0', '1', '0', b'0', 30, '1', '2019-07-20 12:00:48.000', '1', '2019-07-21 13:27:55.000', NULL, 16, '0');
INSERT INTO `sys_menu` VALUES ('50a572de4e409ea88ec94c3f8ba9fc60', '测试书籍管理', NULL, 'TestBook', '413892fe8d52c1163d6659f51299dc96', NULL, 'icon-right-square', 'views/test/testBook/index', '0', '1', '0', b'0', 30, 'system', '2019-07-25 16:09:45.780', 'system', '2019-07-25 16:15:29.907', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('52715698214e88cb09fa4dd1ea5ad348', '生成方案菜单', 'gen_scheme_menu', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-07-25 13:03:03.805', '1', '2019-07-25 13:32:03.060', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('5aa65acd001f22f29217ca5bd6b9475e', '测试书籍管理删除', 'test_testBook_del', NULL, '50a572de4e409ea88ec94c3f8ba9fc60', NULL, NULL, NULL, '0', '1', '1', b'0', 80, 'system', '2019-07-25 16:09:45.792', 'system', '2019-07-25 16:15:29.907', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('663848c0f8206dba3fd2425812fd2fbf', '测试书籍管理删除', 'test_testBook_del', NULL, 'aa74553ef25bbd93d3a921f37177b66b', NULL, NULL, NULL, '0', '1', '1', b'0', 80, 'system', '2019-07-25 16:15:29.926', 'system', '2019-07-26 11:15:41.104', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('7b5f88a6a783d4ed88db6dc5f4dd236d', '测试树书管理删除', 'test_testTreeBook_del', NULL, '4026ad4683346e478306cdb1559e2e7e', NULL, NULL, NULL, '0', '1', '1', b'0', 80, 'system', '2019-07-25 16:15:25.968', 'system', '2019-07-26 11:12:49.812', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('7bd63eec13b959fe5326fdc8ce1ad8fb', '测试树书管理', NULL, 'TestTreeBook', '413892fe8d52c1163d6659f51299dc96', NULL, 'icon-right-square', 'views/test/testTreeBook/index', '0', '1', '0', b'0', 30, 'system', '2019-07-25 13:34:23.331', 'system', '2019-07-25 16:09:40.695', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('8057987be8a92f2c78b1c21799aec6d9', '测试树书管理编辑', 'test_testTreeBook_edit', NULL, '4026ad4683346e478306cdb1559e2e7e', NULL, NULL, NULL, '0', '1', '1', b'0', 40, 'system', '2019-07-25 16:15:25.964', 'system', '2019-07-26 11:12:51.603', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('97722c6d56c8b9990cc3c1a6eea3d6bb', '业务表编辑', 'gen_table_edit', NULL, 'a18b33e15bde209a3c9115517c56d9ec', '413892fe8d52c1163d6659f51299dc96,a18b33e15bde209a3c9115517c56d9ec,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-07-21 13:24:02.000', '1', '2019-07-25 13:32:12.770', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('a18b33e15bde209a3c9115517c56d9ec', '业务表', '', 'table', '413892fe8d52c1163d6659f51299dc96', '413892fe8d52c1163d6659f51299dc96,', 'icon-table', 'views/gen/table/index', '0', '1', '0', b'0', 30, '1', '2019-07-20 12:02:02.000', '1', '2019-07-25 13:32:18.867', NULL, 12, '0');
INSERT INTO `sys_menu` VALUES ('a296e97e320c607f7a0789d0988de4d5', '测试树书管理删除', 'test_testTreeBook_delete', NULL, '7bd63eec13b959fe5326fdc8ce1ad8fb', NULL, NULL, NULL, '0', '1', '1', b'0', 80, 'system', '2019-07-25 13:34:23.339', 'system', '2019-07-25 16:09:40.695', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('aa74553ef25bbd93d3a921f37177b66b', '测试书籍管理', NULL, 'testBook', '413892fe8d52c1163d6659f51299dc96', NULL, 'icon-right-square', 'views/test/testBook/index', '0', '1', '0', b'0', 30, 'system', '2019-07-25 16:15:29.911', 'system', '2019-07-26 11:16:21.704', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('b961670cbf3454f5927c4bd2a327e915', '生成方案删除', 'gen_scheme_del', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-07-21 13:30:18.000', '1', '2019-07-25 13:32:07.110', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('ba842f6e126664a139c79f97a6bc01a9', '测试书籍管理查看', 'test_testBook_view', NULL, 'aa74553ef25bbd93d3a921f37177b66b', NULL, NULL, NULL, '0', '1', '1', b'0', 20, 'system', '2019-07-25 16:15:29.919', 'system', '2019-07-26 11:16:02.366', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('bbb1aae54ec2ec16c5e2908fbddba717', '测试书籍管理编辑', 'test_testBook_edit', NULL, '163dab3b2d62dd161104f3f8649930a4', NULL, NULL, NULL, '0', '1', '1', b'0', 40, 'system', '2019-07-25 13:31:23.956', 'system', '2019-07-25 16:09:45.773', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('c259e3182c7d20ead4f6a31b4fefa5ea', '测试树书管理编辑', 'test_testTreeBook_edit', NULL, '3fe010c12bb466aa3255dc269293e752', NULL, NULL, NULL, '0', '1', '1', b'0', 40, 'system', '2019-07-25 16:09:40.713', 'system', '2019-07-25 16:15:25.946', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('c9b4d84c2c823961b8bce1c8635caaff', '测试树书管理查看', 'test_testTreeBook_view', NULL, '3fe010c12bb466aa3255dc269293e752', NULL, NULL, NULL, '0', '1', '1', b'0', 20, 'system', '2019-07-25 16:09:40.708', 'system', '2019-07-25 16:15:25.946', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('d1d7bbe9e5406f21a0378853892318af', '测试书籍管理删除', 'test_testBook_delete', NULL, '163dab3b2d62dd161104f3f8649930a4', NULL, NULL, NULL, '0', '1', '1', b'0', 80, 'system', '2019-07-25 13:31:23.960', 'system', '2019-07-25 16:09:45.773', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('d4871aa7a5a829c1529b836ea06ede75', '测试树书管理删除', 'test_testTreeBook_del', NULL, '3fe010c12bb466aa3255dc269293e752', NULL, NULL, NULL, '0', '1', '1', b'0', 80, 'system', '2019-07-25 16:09:40.716', 'system', '2019-07-25 16:15:25.946', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('e5ea38c1f97dee0043e78f3fb27b25d6', '生成方案编辑', 'gen_scheme_edit', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-07-21 13:29:14.000', '1', '2019-07-25 13:32:09.178', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('e710a66583fe0e324492462adb16014e', '业务表删除', 'gen_table_del', NULL, 'a18b33e15bde209a3c9115517c56d9ec', '413892fe8d52c1163d6659f51299dc96,a18b33e15bde209a3c9115517c56d9ec,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-07-21 13:24:45.000', '1', '2019-07-25 13:32:11.051', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('fc921e422e9adef5c7c39a102e3d8667', '测试树书管理编辑', 'test_testTreeBook_edit', NULL, '7bd63eec13b959fe5326fdc8ce1ad8fb', NULL, NULL, NULL, '0', '1', '1', b'0', 40, 'system', '2019-07-25 13:34:23.336', 'system', '2019-07-25 16:09:40.695', NULL, 0, '1');

-- ----------------------------
-- Table structure for sys_oauth_client_detail
-- ----------------------------
DROP TABLE IF EXISTS `sys_oauth_client_detail`;
CREATE TABLE `sys_oauth_client_detail`  (
  `client_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '客户端ID',
  `resource_ids` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '资源ID',
  `client_secret` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '客户端密钥',
  `scope` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '作用域',
  `authorized_grant_types` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '授权方式',
  `web_server_redirect_uri` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '重定向地址',
  `authorities` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '权限',
  `access_token_validity` int(11) NULL DEFAULT NULL COMMENT '请求令牌有效时间',
  `refresh_token_validity` int(11) NULL DEFAULT NULL COMMENT '刷新令牌有效时间',
  `additional_information` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '扩展信息',
  `autoapprove` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '是否自动放行',
  PRIMARY KEY (`client_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '终端信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oauth_client_detail
-- ----------------------------
INSERT INTO `sys_oauth_client_detail` VALUES ('albedo', NULL, 'albedo', 'server', 'password,refresh_token,authorization_code,client_credentials', 'http://localhost:4040/sso1/login,http://localhost:4041/sso1/login', NULL, NULL, NULL, NULL, 'true');
INSERT INTO `sys_oauth_client_detail` VALUES ('app', NULL, 'app', 'server', 'password,refresh_token', NULL, NULL, NULL, NULL, NULL, 'true');
INSERT INTO `sys_oauth_client_detail` VALUES ('daemon', NULL, 'daemon', 'server', 'password,refresh_token', NULL, NULL, NULL, NULL, NULL, 'true');
INSERT INTO `sys_oauth_client_detail` VALUES ('gen', NULL, 'gen', 'server', 'password,refresh_token', NULL, NULL, NULL, NULL, NULL, 'true');
INSERT INTO `sys_oauth_client_detail` VALUES ('swagger', NULL, 'swagger', 'all', 'password,refresh_token', NULL, NULL, NULL, NULL, NULL, 'true');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '数据权限 1全部 2所在机构及以下数据  3 所在机构数据  4仅本人数据 5 按明细设置',
  `lock_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '1' COMMENT '1-正常，0-锁定',
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3),
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `version` int(11) NOT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `role_idx1_role_code`(`code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '系统角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '管理员', 'ROLE_ADMIN', '管理员', '1', '0', '', '2017-10-29 15:45:51.000', '1', '2019-07-25 16:15:55.962', NULL, 25, '0');
INSERT INTO `sys_role` VALUES ('2', 'ROLE_CQQ', 'ROLE_CQQ', 'ROLE_CQQ', '5', '0', '', '2018-11-11 19:42:26.000', '1', '2019-07-25 15:52:30.056', NULL, 6, '0');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `role_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色ID',
  `dept_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色与部门对应关系' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES ('036de6f87e24bc01bf84d9e3aff0a73d', '2', '4');
INSERT INTO `sys_role_dept` VALUES ('4ae2cd0869e3fcb570d8acae77877b33', '1', '8');
INSERT INTO `sys_role_dept` VALUES ('4ce4e910dfaaee5d1698105a952527c7', '2', '3');
INSERT INTO `sys_role_dept` VALUES ('c08f26e8957cbf2888c1e59f957d5971', '2', '5');
INSERT INTO `sys_role_dept` VALUES ('c1847469ace6d2b84d05597245e49cda', '2', '1');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色ID',
  `menu_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色菜单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('1', '1000');
INSERT INTO `sys_role_menu` VALUES ('1', '1100');
INSERT INTO `sys_role_menu` VALUES ('1', '1101');
INSERT INTO `sys_role_menu` VALUES ('1', '1102');
INSERT INTO `sys_role_menu` VALUES ('1', '1103');
INSERT INTO `sys_role_menu` VALUES ('1', '1200');
INSERT INTO `sys_role_menu` VALUES ('1', '1201');
INSERT INTO `sys_role_menu` VALUES ('1', '1202');
INSERT INTO `sys_role_menu` VALUES ('1', '1203');
INSERT INTO `sys_role_menu` VALUES ('1', '1300');
INSERT INTO `sys_role_menu` VALUES ('1', '1301');
INSERT INTO `sys_role_menu` VALUES ('1', '1302');
INSERT INTO `sys_role_menu` VALUES ('1', '1303');
INSERT INTO `sys_role_menu` VALUES ('1', '1304');
INSERT INTO `sys_role_menu` VALUES ('1', '1400');
INSERT INTO `sys_role_menu` VALUES ('1', '1401');
INSERT INTO `sys_role_menu` VALUES ('1', '1402');
INSERT INTO `sys_role_menu` VALUES ('1', '1403');
INSERT INTO `sys_role_menu` VALUES ('1', '2000');
INSERT INTO `sys_role_menu` VALUES ('1', '2100');
INSERT INTO `sys_role_menu` VALUES ('1', '2101');
INSERT INTO `sys_role_menu` VALUES ('1', '2200');
INSERT INTO `sys_role_menu` VALUES ('1', '2201');
INSERT INTO `sys_role_menu` VALUES ('1', '2202');
INSERT INTO `sys_role_menu` VALUES ('1', '2400');
INSERT INTO `sys_role_menu` VALUES ('1', '2401');
INSERT INTO `sys_role_menu` VALUES ('1', '2402');
INSERT INTO `sys_role_menu` VALUES ('1', '2403');
INSERT INTO `sys_role_menu` VALUES ('1', '247071d42ff40267c8d8c44eac92da67');
INSERT INTO `sys_role_menu` VALUES ('1', '2500');
INSERT INTO `sys_role_menu` VALUES ('1', '2600');
INSERT INTO `sys_role_menu` VALUES ('1', '2601');
INSERT INTO `sys_role_menu` VALUES ('1', '413892fe8d52c1163d6659f51299dc96');
INSERT INTO `sys_role_menu` VALUES ('1', '52715698214e88cb09fa4dd1ea5ad348');
INSERT INTO `sys_role_menu` VALUES ('1', '97722c6d56c8b9990cc3c1a6eea3d6bb');
INSERT INTO `sys_role_menu` VALUES ('1', 'a18b33e15bde209a3c9115517c56d9ec');
INSERT INTO `sys_role_menu` VALUES ('1', 'b961670cbf3454f5927c4bd2a327e915');
INSERT INTO `sys_role_menu` VALUES ('1', 'e5ea38c1f97dee0043e78f3fb27b25d6');
INSERT INTO `sys_role_menu` VALUES ('1', 'e710a66583fe0e324492462adb16014e');
INSERT INTO `sys_role_menu` VALUES ('2', '1000');
INSERT INTO `sys_role_menu` VALUES ('2', '1100');
INSERT INTO `sys_role_menu` VALUES ('2', '1101');
INSERT INTO `sys_role_menu` VALUES ('2', '1102');
INSERT INTO `sys_role_menu` VALUES ('2', '1103');
INSERT INTO `sys_role_menu` VALUES ('2', '1200');
INSERT INTO `sys_role_menu` VALUES ('2', '1201');
INSERT INTO `sys_role_menu` VALUES ('2', '1202');
INSERT INTO `sys_role_menu` VALUES ('2', '1203');
INSERT INTO `sys_role_menu` VALUES ('2', '1300');
INSERT INTO `sys_role_menu` VALUES ('2', '1301');
INSERT INTO `sys_role_menu` VALUES ('2', '1302');
INSERT INTO `sys_role_menu` VALUES ('2', '1303');
INSERT INTO `sys_role_menu` VALUES ('2', '1304');
INSERT INTO `sys_role_menu` VALUES ('2', '1400');
INSERT INTO `sys_role_menu` VALUES ('2', '1401');
INSERT INTO `sys_role_menu` VALUES ('2', '1402');
INSERT INTO `sys_role_menu` VALUES ('2', '1403');
INSERT INTO `sys_role_menu` VALUES ('2', 'e5ea38c1f97dee0043e78f3fb27b25d6');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '1' COMMENT '主键ID',
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `salt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '随机盐',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '简介',
  `email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '邮箱',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '头像',
  `dept_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '部门ID',
  `qq_open_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'QQ openid',
  `wx_open_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '微信openid',
  `lock_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '1' COMMENT '1-正常，0-锁定',
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `version` int(11) NOT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_wx_openid`(`wx_open_id`) USING BTREE,
  INDEX `user_qq_openid`(`qq_open_id`) USING BTREE,
  INDEX `user_idx1_username`(`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', '$2a$10$81JhU58/uM.JmWKiCAcxoOiSS///NT6rXbSRATa.UgGG8stlA1ABy', NULL, '17034642999', NULL, '', '1', NULL, 'o_0FT0uyg_H1vVy2H0JpSwlVGhWQ', '0', '', '2018-04-20 07:15:18.000', '1', '2019-07-13 01:13:20.000', NULL, 7, '0');
INSERT INTO `sys_user` VALUES ('53fb3761bdd95ed3d03f4a07f78ea0eb', 'dsafdf', '$2a$10$81JhU58/uM.JmWKiCAcxoOiSS///NT6rXbSRATa.UgGG8stlA1ABy', NULL, '12343543432', '837158@qq.com', NULL, '3', NULL, NULL, '1', '1', '2019-07-07 14:32:17.000', '1', '2019-07-13 01:38:33.000', NULL, 19, '1');
INSERT INTO `sys_user` VALUES ('90da0206c39867a1b36ac36ced80c1a9', 'adsfsd', '$2a$10$81JhU58/uM.JmWKiCAcxoOiSS///NT6rXbSRATa.UgGG8stlA1ABy', NULL, NULL, NULL, NULL, '3', NULL, NULL, '0', '1', '2019-07-07 14:35:13.000', '1', '2019-07-26 10:52:17.716', NULL, 32, '0');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户ID',
  `role_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('1', '1');
INSERT INTO `sys_user_role` VALUES ('90da0206c39867a1b36ac36ced80c1a9', '1');

-- ----------------------------
-- Table structure for test_book
-- ----------------------------
DROP TABLE IF EXISTS `test_book`;
CREATE TABLE `test_book`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `title_` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `author_` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '作者',
  `name_` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `email_` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone_` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机',
  `activated_` bit(1) NOT NULL,
  `number_` int(11) NULL DEFAULT NULL COMMENT 'key',
  `money_` decimal(20, 2) NULL DEFAULT NULL,
  `amount_` double(11, 2) NULL DEFAULT NULL,
  `reset_date` timestamp(3) NULL DEFAULT NULL,
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `version` int(11) NULL DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '测试书籍' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of test_book
-- ----------------------------
INSERT INTO `test_book` VALUES ('a3a7afa3364b4556ae3433d1122cc65b', 'test', 'test', 'test', '', 'dsfasd', b'1', 32, 12.30, 12.00, '2019-07-26 21:00:16.000', '1', '2019-07-25 16:27:40.000', '1', '2019-07-25 17:52:08.141', '', 8, '0');
INSERT INTO `test_book` VALUES ('e26358487d5dfa123b079aa5f1c947a1', 'test', 'test', '', '', '', b'1', 123, 123.20, 123.20, NULL, '1', '2019-07-25 16:42:37.991', '1', '2019-07-25 16:39:04.741', '', 1, '1');

-- ----------------------------
-- Table structure for test_tree_book
-- ----------------------------
DROP TABLE IF EXISTS `test_tree_book`;
CREATE TABLE `test_tree_book`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `parent_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `parent_ids` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父菜单IDs',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门名称',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `leaf` bit(1) NULL DEFAULT b'0' COMMENT '1 叶子节点 0 非叶子节点',
  `author_` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '作者',
  `email_` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone_` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机',
  `activated_` bit(1) NOT NULL,
  `number_` int(11) NULL DEFAULT NULL COMMENT 'key',
  `money_` decimal(20, 2) NULL DEFAULT NULL,
  `amount_` double(11, 2) NULL DEFAULT NULL,
  `reset_date` timestamp(3) NULL DEFAULT NULL,
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
  `version` int(11) NOT NULL,
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '  测试树书' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of test_tree_book
-- ----------------------------
INSERT INTO `test_tree_book` VALUES ('1', '-1', NULL, '山东农信', 30, b'0', 'ads', NULL, NULL, b'1', NULL, NULL, NULL, NULL, '', '2019-07-25 14:54:58.000', '1', '0', '2019-07-25 17:53:26.646', 4, '');
INSERT INTO `test_tree_book` VALUES ('10', '8', NULL, '院校沙县', NULL, b'0', '', NULL, NULL, b'0', NULL, NULL, NULL, NULL, '', '2019-07-25 14:54:58.055', NULL, '0', NULL, 0, '');
INSERT INTO `test_tree_book` VALUES ('2', '-1', NULL, '沙县国际', 30, b'0', '', NULL, NULL, b'0', NULL, NULL, NULL, NULL, '', '2019-07-25 14:54:58.055', '1', '0', '2019-07-25 16:54:17.980', 2, '');
INSERT INTO `test_tree_book` VALUES ('3', '1', NULL, '潍坊农信', NULL, b'0', '', NULL, NULL, b'0', NULL, NULL, NULL, NULL, '', '2019-07-25 14:54:58.055', NULL, '0', NULL, 0, '');
INSERT INTO `test_tree_book` VALUES ('4', '3', NULL, '高新农信', 30, b'0', '', NULL, NULL, b'0', NULL, NULL, NULL, NULL, '', '2019-07-25 14:54:58.055', '1', '0', '2019-07-25 17:09:07.360', 1, '');
INSERT INTO `test_tree_book` VALUES ('5', '4', '4,', '院校农信', 30, b'0', 'sdfads', NULL, NULL, b'0', NULL, NULL, NULL, NULL, '', '2019-07-25 14:54:58.000', '1', '0', '2019-07-25 17:09:07.375', 1, '');
INSERT INTO `test_tree_book` VALUES ('5f86e2a82b040b1f618aefc62f403024', '5', '5,', '11', 1, b'1', '', NULL, NULL, b'0', NULL, NULL, NULL, NULL, '', '2019-07-25 14:54:58.055', NULL, '0', NULL, 0, NULL);
INSERT INTO `test_tree_book` VALUES ('6', '5', NULL, '潍院农信', NULL, b'0', '', NULL, NULL, b'0', NULL, NULL, NULL, NULL, '', '2019-07-25 14:54:58.055', NULL, '0', NULL, 0, '');
INSERT INTO `test_tree_book` VALUES ('6690afb33a508d084a9207dab88c02e2', '2', '2,', 'dsdfadfasd', 30, b'1', '11', '', '', b'1', NULL, NULL, NULL, NULL, '1', '2019-07-25 16:54:17.985', '1', '1', '2019-07-25 16:54:26.678', 0, '');
INSERT INTO `test_tree_book` VALUES ('7', '2', '2,', '山东沙县', 30, b'0', 'test', NULL, NULL, b'0', NULL, NULL, NULL, NULL, '', '2019-07-25 14:54:58.000', '1', '1', '2019-07-25 16:54:28.847', 1, '');
INSERT INTO `test_tree_book` VALUES ('8', '7', NULL, '潍坊沙县', 30, b'0', '', NULL, NULL, b'0', NULL, NULL, NULL, NULL, '', '2019-07-25 14:54:58.055', '1', '0', '2019-07-25 16:53:49.316', 1, '');
INSERT INTO `test_tree_book` VALUES ('9', '8', NULL, '高新沙县', NULL, b'0', '', NULL, NULL, b'0', NULL, NULL, NULL, NULL, '', '2019-07-25 14:54:58.055', NULL, '0', NULL, 0, '');
INSERT INTO `test_tree_book` VALUES ('abfb1162817129ac5d8cca2425663a9b', '8', '8,', 'test', 30, b'1', 'test', '', '', b'1', NULL, NULL, NULL, NULL, '1', '2019-07-25 16:53:49.322', '1', '0', '2019-07-25 16:53:49.322', 0, '');

-- ----------------------------
-- Table structure for zipkin_annotations
-- ----------------------------
DROP TABLE IF EXISTS `zipkin_annotations`;
CREATE TABLE `zipkin_annotations`  (
  `trace_id_high` bigint(20) NOT NULL DEFAULT 0 COMMENT 'If non zero, this means the trace uses 128 bit traceIds instead of 64 bit',
  `trace_id` bigint(20) NOT NULL COMMENT 'coincides with zipkin_spans.trace_id',
  `span_id` bigint(20) NOT NULL COMMENT 'coincides with zipkin_spans.id',
  `a_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'BinaryAnnotation.key or Annotation.value if type == -1',
  `a_value` blob NULL COMMENT 'BinaryAnnotation.value(), which must be smaller than 64KB',
  `a_type` int(11) NOT NULL COMMENT 'BinaryAnnotation.type() or -1 if Annotation',
  `a_timestamp` bigint(20) NULL DEFAULT NULL COMMENT 'Used to implement TTL; Annotation.timestamp or zipkin_spans.timestamp',
  `endpoint_ipv4` int(11) NULL DEFAULT NULL COMMENT 'Null when Binary/Annotation.endpoint is null',
  `endpoint_ipv6` binary(16) NULL DEFAULT NULL COMMENT 'Null when Binary/Annotation.endpoint is null, or no IPv6 address',
  `endpoint_port` smallint(6) NULL DEFAULT NULL COMMENT 'Null when Binary/Annotation.endpoint is null',
  `endpoint_service_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Null when Binary/Annotation.endpoint is null',
  UNIQUE INDEX `trace_id_high`(`trace_id_high`, `trace_id`, `span_id`, `a_key`, `a_timestamp`) USING BTREE COMMENT 'Ignore insert on duplicate',
  UNIQUE INDEX `trace_id_high_4`(`trace_id_high`, `trace_id`, `span_id`, `a_key`, `a_timestamp`) USING BTREE COMMENT 'Ignore insert on duplicate',
  INDEX `trace_id_high_2`(`trace_id_high`, `trace_id`, `span_id`) USING BTREE COMMENT 'for joining with zipkin_spans',
  INDEX `trace_id_high_3`(`trace_id_high`, `trace_id`) USING BTREE COMMENT 'for getTraces/ByIds',
  INDEX `endpoint_service_name`(`endpoint_service_name`) USING BTREE COMMENT 'for getTraces and getServiceNames',
  INDEX `a_type`(`a_type`) USING BTREE COMMENT 'for getTraces and autocomplete values',
  INDEX `a_key`(`a_key`) USING BTREE COMMENT 'for getTraces and autocomplete values',
  INDEX `trace_id`(`trace_id`, `span_id`, `a_key`) USING BTREE COMMENT 'for dependencies job',
  INDEX `trace_id_high_5`(`trace_id_high`, `trace_id`, `span_id`) USING BTREE COMMENT 'for joining with zipkin_spans',
  INDEX `trace_id_high_6`(`trace_id_high`, `trace_id`) USING BTREE COMMENT 'for getTraces/ByIds',
  INDEX `endpoint_service_name_2`(`endpoint_service_name`) USING BTREE COMMENT 'for getTraces and getServiceNames',
  INDEX `a_type_2`(`a_type`) USING BTREE COMMENT 'for getTraces and autocomplete values',
  INDEX `a_key_2`(`a_key`) USING BTREE COMMENT 'for getTraces and autocomplete values',
  INDEX `trace_id_2`(`trace_id`, `span_id`, `a_key`) USING BTREE COMMENT 'for dependencies job'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compressed;

-- ----------------------------
-- Table structure for zipkin_dependencies
-- ----------------------------
DROP TABLE IF EXISTS `zipkin_dependencies`;
CREATE TABLE `zipkin_dependencies`  (
  `day` date NOT NULL,
  `parent` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `child` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `call_count` bigint(20) NULL DEFAULT NULL,
  `error_count` bigint(20) NULL DEFAULT NULL,
  UNIQUE INDEX `day`(`day`, `parent`, `child`) USING BTREE,
  UNIQUE INDEX `day_2`(`day`, `parent`, `child`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compressed;

-- ----------------------------
-- Table structure for zipkin_spans
-- ----------------------------
DROP TABLE IF EXISTS `zipkin_spans`;
CREATE TABLE `zipkin_spans`  (
  `trace_id_high` bigint(20) NOT NULL DEFAULT 0 COMMENT 'If non zero, this means the trace uses 128 bit traceIds instead of 64 bit',
  `trace_id` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `parent_id` bigint(20) NULL DEFAULT NULL,
  `debug` bit(1) NULL DEFAULT NULL,
  `start_ts` bigint(20) NULL DEFAULT NULL COMMENT 'Span.timestamp(): epoch micros used for endTs query and to implement TTL',
  `duration` bigint(20) NULL DEFAULT NULL COMMENT 'Span.duration(): micros used for minDuration and maxDuration query',
  UNIQUE INDEX `trace_id_high`(`trace_id_high`, `trace_id`, `id`) USING BTREE COMMENT 'ignore insert on duplicate',
  UNIQUE INDEX `trace_id_high_4`(`trace_id_high`, `trace_id`, `id`) USING BTREE COMMENT 'ignore insert on duplicate',
  INDEX `trace_id_high_2`(`trace_id_high`, `trace_id`, `id`) USING BTREE COMMENT 'for joining with zipkin_annotations',
  INDEX `trace_id_high_3`(`trace_id_high`, `trace_id`) USING BTREE COMMENT 'for getTracesByIds',
  INDEX `name`(`name`) USING BTREE COMMENT 'for getTraces and getSpanNames',
  INDEX `start_ts`(`start_ts`) USING BTREE COMMENT 'for getTraces ordering and range',
  INDEX `trace_id_high_5`(`trace_id_high`, `trace_id`, `id`) USING BTREE COMMENT 'for joining with zipkin_annotations',
  INDEX `trace_id_high_6`(`trace_id_high`, `trace_id`) USING BTREE COMMENT 'for getTracesByIds',
  INDEX `name_2`(`name`) USING BTREE COMMENT 'for getTraces and getSpanNames',
  INDEX `start_ts_2`(`start_ts`) USING BTREE COMMENT 'for getTraces ordering and range'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compressed;

SET FOREIGN_KEY_CHECKS = 1;
