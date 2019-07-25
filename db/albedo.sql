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

 Date: 25/07/2019 13:25:42
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
INSERT INTO `gen_scheme` VALUES ('36096a9886fe251a9b755fcfaf766b42', '测试树书管理', 'curd', NULL, 'com.albedo.java.modules', 'test', NULL, '测试树书', '测试树书', 'admin', 'db46c9935ed8caae04bcefd5c6ea7f28', 0, NULL, '1', '2019-07-25 12:58:19.866', '1', '2019-07-25 12:58:19.866', '0');
INSERT INTO `gen_scheme` VALUES ('362bf45dff219f95d092d767dac4f5fb', '测试书籍管理', 'curd', NULL, 'com.albedo.java.modules', 'test', NULL, '测试书籍管理', '测试书籍管理', 'admin', '6aed6fe18521d641a443171fa9e92893', 10, NULL, '1', '2019-07-22 20:55:18.000', '1', '2019-07-25 12:56:54.795', '0');

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
INSERT INTO `gen_table` VALUES ('6aed6fe18521d641a443171fa9e92893', 'test_book', '测试书籍', 'TestBook', '', NULL, 8, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:37.999', '0');
INSERT INTO `gen_table` VALUES ('db46c9935ed8caae04bcefd5c6ea7f28', 'test_tree_book', '测试树书', 'TestTreeBook', NULL, NULL, 0, NULL, '1', '2019-07-25 10:28:01.402', '1', '2019-07-25 10:28:01.402', '0');

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
INSERT INTO `gen_table_column` VALUES ('0877c9b6356cb28709c518b774145f5e', '6aed6fe18521d641a443171fa9e92893', 'number_', 'key', NULL, 'int(11)', 'Integer', 'number', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 80, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.066', '0');
INSERT INTO `gen_table_column` VALUES ('0b9410298327f9ab090208e959d3dabb', 'db46c9935ed8caae04bcefd5c6ea7f28', 'created_by', 'created_by', NULL, 'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 70, 0, NULL, '1', '2019-07-25 10:28:01.429', '1', '2019-07-25 10:28:01.429', '0');
INSERT INTO `gen_table_column` VALUES ('13ade9ca23ead1d93e6b34b35e790605', '6aed6fe18521d641a443171fa9e92893', 'version_', 'version_', NULL, 'int(11)', 'Long', 'version', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 180, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.113', '0');
INSERT INTO `gen_table_column` VALUES ('23e957ff7b9c732514bf0ee5332817f0', 'db46c9935ed8caae04bcefd5c6ea7f28', 'last_modified_by', 'last_modified_by', NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 90, 0, NULL, '1', '2019-07-25 10:28:01.431', '1', '2019-07-25 10:28:01.431', '0');
INSERT INTO `gen_table_column` VALUES ('3caf8556b0edd037e47d3fcf9b1cb06c', '6aed6fe18521d641a443171fa9e92893', 'created_date', 'created_date', NULL, 'timestamp', 'java.util.Date', 'createdDate', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 130, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.089', '0');
INSERT INTO `gen_table_column` VALUES ('3e75a10aa0cb5eee1c45cdad10d1bd3a', '6aed6fe18521d641a443171fa9e92893', 'id_', 'id_', NULL, 'varchar(32)', 'String', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.028', '0');
INSERT INTO `gen_table_column` VALUES ('42f20b67074e0cf8595793c4a199ac60', 'db46c9935ed8caae04bcefd5c6ea7f28', 'leaf', '1 叶子节点 0 非叶子节点', NULL, 'bit(1)', 'Integer', 'leaf', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 60, 0, NULL, '1', '2019-07-25 10:28:01.428', '1', '2019-07-25 10:28:01.428', '0');
INSERT INTO `gen_table_column` VALUES ('677b52a641d567bc68fd5e9964cfcbd1', '6aed6fe18521d641a443171fa9e92893', 'last_modified_date', 'last_modified_date', NULL, 'timestamp', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 150, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.099', '0');
INSERT INTO `gen_table_column` VALUES ('6c6faf1de9039435e863732118ba6237', 'db46c9935ed8caae04bcefd5c6ea7f28', 'name', '部门名称', NULL, 'varchar(50)', 'String', 'name', b'0', b'1', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 40, 0, NULL, '1', '2019-07-25 10:28:01.425', '1', '2019-07-25 10:28:01.425', '0');
INSERT INTO `gen_table_column` VALUES ('7644a064412105de9eec01bdc2ac3de2', '6aed6fe18521d641a443171fa9e92893', 'phone_', '手机', NULL, 'varchar(32)', 'String', 'phone', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 60, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.056', '0');
INSERT INTO `gen_table_column` VALUES ('7899be0c46d895b71a0db0b0975fe181', 'db46c9935ed8caae04bcefd5c6ea7f28', 'created_date', '创建时间', NULL, 'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 80, 0, NULL, '1', '2019-07-25 10:28:01.430', '1', '2019-07-25 10:28:01.430', '0');
INSERT INTO `gen_table_column` VALUES ('7a818e013b9dddc9d59d3e03549f496c', '6aed6fe18521d641a443171fa9e92893', 'description_', '备注', NULL, 'varchar(255)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'textarea', '', NULL, 170, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.108', '0');
INSERT INTO `gen_table_column` VALUES ('7c781fe7b465cf0138963a0da4a21256', 'db46c9935ed8caae04bcefd5c6ea7f28', 'last_modified_date', '修改时间', NULL, 'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 100, 0, NULL, '1', '2019-07-25 10:28:01.432', '1', '2019-07-25 10:28:01.432', '0');
INSERT INTO `gen_table_column` VALUES ('81671246990e2d74946097449c13d8cc', 'db46c9935ed8caae04bcefd5c6ea7f28', 'id', 'id', NULL, 'varchar(32)', 'String', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 0, NULL, '1', '2019-07-25 10:28:01.418', '1', '2019-07-25 10:28:01.418', '0');
INSERT INTO `gen_table_column` VALUES ('99994d3d43b891b812b9db40e53a771b', '6aed6fe18521d641a443171fa9e92893', 'status_', 'status_', NULL, 'int(11)', 'Long', 'status', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 160, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.103', '0');
INSERT INTO `gen_table_column` VALUES ('9b803522d4c92864080d9341a87ac895', 'db46c9935ed8caae04bcefd5c6ea7f28', 'description', '备注', NULL, 'varchar(100)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'textarea', '', NULL, 120, 0, NULL, '1', '2019-07-25 10:28:01.433', '1', '2019-07-25 10:28:01.433', '0');
INSERT INTO `gen_table_column` VALUES ('9bfd8282cd36b26c5e53715a1a40293b', '6aed6fe18521d641a443171fa9e92893', 'money_', 'money_', NULL, 'decimal(20,2)', 'Double', 'money', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 90, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.071', '0');
INSERT INTO `gen_table_column` VALUES ('9f620d41a276ede01cf4be9301f37a2d', '6aed6fe18521d641a443171fa9e92893', 'name_', '名称', NULL, 'varchar(50)', 'String', 'name', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 40, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.046', '0');
INSERT INTO `gen_table_column` VALUES ('a172d22697aa8f970ddb6dbebdf1b84b', 'db46c9935ed8caae04bcefd5c6ea7f28', 'parent_id', 'parent_id', NULL, 'varchar(32)', 'String', 'parentId', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 20, 0, NULL, '1', '2019-07-25 10:28:01.422', '1', '2019-07-25 10:28:01.422', '0');
INSERT INTO `gen_table_column` VALUES ('a76d66fe331b2e564a830fcf457a7377', '6aed6fe18521d641a443171fa9e92893', 'activated_', 'activated_', NULL, 'bit(1)', 'Integer', 'activated', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 70, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.061', '0');
INSERT INTO `gen_table_column` VALUES ('b261660f4374ab99c042700277ab66af', 'db46c9935ed8caae04bcefd5c6ea7f28', 'del_flag', '0-正常，1-删除', NULL, 'char(1)', 'String', 'delFlag', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 130, 0, NULL, '1', '2019-07-25 10:28:01.434', '1', '2019-07-25 10:28:01.434', '0');
INSERT INTO `gen_table_column` VALUES ('b8a151c7c7aac1309493648b8666e7c5', '6aed6fe18521d641a443171fa9e92893', 'created_by', 'created_by', NULL, 'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 120, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.085', '0');
INSERT INTO `gen_table_column` VALUES ('c9782de5e492e62b8872e6c9fe63f83f', '6aed6fe18521d641a443171fa9e92893', 'amount_', 'amount_', NULL, 'double(11,2)', 'Double', 'amount', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 100, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.076', '0');
INSERT INTO `gen_table_column` VALUES ('d39e2a5d74ca674d1a59666b1005d258', '6aed6fe18521d641a443171fa9e92893', 'title_', '标题', NULL, 'varchar(32)', 'String', 'title', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 20, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.036', '0');
INSERT INTO `gen_table_column` VALUES ('e04faad4cee1eec6ee3cdc7636276c1b', '6aed6fe18521d641a443171fa9e92893', 'reset_date', 'reset_date', NULL, 'timestamp', 'java.util.Date', 'resetDate', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'dateselect', '', NULL, 110, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.080', '0');
INSERT INTO `gen_table_column` VALUES ('e0f3898711892f794bfb15ba30c407e5', 'db46c9935ed8caae04bcefd5c6ea7f28', 'sort', '排序', NULL, 'int(11)', 'Long', 'sort', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 50, 0, NULL, '1', '2019-07-25 10:28:01.426', '1', '2019-07-25 10:28:01.426', '0');
INSERT INTO `gen_table_column` VALUES ('e572dd69b916c5db2ad3b0ab5a593572', '6aed6fe18521d641a443171fa9e92893', 'author_', '作者', NULL, 'varchar(50)', 'String', 'author', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 30, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.041', '0');
INSERT INTO `gen_table_column` VALUES ('e706aed2cd00c7b2df701c707a2c3650', '6aed6fe18521d641a443171fa9e92893', 'email_', '邮箱', NULL, 'varchar(100)', 'String', 'email', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 50, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.051', '0');
INSERT INTO `gen_table_column` VALUES ('ea3302c65612ea668ace61cb3049741a', 'db46c9935ed8caae04bcefd5c6ea7f28', 'version', 'version', NULL, 'int(11)', 'Long', 'version', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 110, 0, NULL, '1', '2019-07-25 10:28:01.433', '1', '2019-07-25 10:28:01.433', '0');
INSERT INTO `gen_table_column` VALUES ('ee7ec3af0723d0011f252e02caaf5cb6', 'db46c9935ed8caae04bcefd5c6ea7f28', 'parent_ids', '父菜单IDs', NULL, 'varchar(2000)', 'String', 'parentIds', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 30, 0, NULL, '1', '2019-07-25 10:28:01.423', '1', '2019-07-25 10:28:01.423', '0');
INSERT INTO `gen_table_column` VALUES ('fb5e5e7f6f8f63073ec7db1c83db54e1', '6aed6fe18521d641a443171fa9e92893', 'last_modified_by', 'last_modified_by', NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 140, 5, NULL, '1', '2019-07-21 16:41:33.000', '1', '2019-07-25 10:21:38.094', '0');

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
) ENGINE = InnoDB AUTO_INCREMENT = 57 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES (51, '0', '添加角色', 'test', '0:0:0:0:0:0:0:1', 'PostmanRuntime/7.6.0', '/role', 'POST', 'Authorization=%5B%5D', '65', NULL, 'admin', '2019-01-24 20:56:43.000', NULL, '2019-06-15 10:56:41.000', 0, '', '0');
INSERT INTO `sys_log` VALUES (52, '0', '更新菜单', 'pig', '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36', '/menu', 'PUT', '', '40', NULL, 'admin', '2019-04-27 14:55:07.000', NULL, '2019-06-15 10:56:41.000', 0, '', '0');
INSERT INTO `sys_log` VALUES (53, '0', '更新菜单', 'pig', '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36', '/menu', 'PUT', '', '31', NULL, 'admin', '2019-04-27 14:55:19.000', NULL, '2019-06-15 10:56:41.000', 0, '', '0');
INSERT INTO `sys_log` VALUES (54, '0', '删除菜单', 'pig', '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.108 Safari/537.36', '/menu/9999', 'DELETE', '', '195', NULL, 'admin', '2019-04-27 15:45:30.000', NULL, '2019-06-15 10:56:41.000', 0, '', '0');
INSERT INTO `sys_log` VALUES (55, '0', '锁定/解锁用户', 'albedo', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.86 Safari/537.36', '/sys/user/90da0206c39867a1b36ac36ced80c1a9', 'PUT', '', '10', NULL, 'system', '2019-07-07 22:16:43.000', 'system', '2019-07-07 22:16:43.000', 0, NULL, '0');
INSERT INTO `sys_log` VALUES (56, '0', '锁定/解锁用户', 'albedo', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.86 Safari/537.36', '/sys/user/90da0206c39867a1b36ac36ced80c1a9', 'PUT', '', '63818', NULL, 'system', '2019-07-07 22:19:27.000', 'system', '2019-07-07 22:19:27.000', 0, NULL, '0');

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
INSERT INTO `sys_menu` VALUES ('02e8e5eb3c94dfdf922be6200d63a851', '测试树书管理', NULL, 'TestTreeBook', '413892fe8d52c1163d6659f51299dc96', NULL, 'icon-right-square', 'views/test/testTreeBook/index', '0', '1', '0', b'0', 30, 'system', '2019-07-25 12:58:36.425', 'system', '2019-07-25 12:58:36.425', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('09777a9c9d633bdd0ecf4c72e94ce02f', '测试书籍管理', NULL, 'TestBook', '413892fe8d52c1163d6659f51299dc96', NULL, 'icon-right-square', 'views/test/testBook/index', '0', '1', '0', b'0', 30, 'system', '2019-07-25 12:56:50.517', 'system', '2019-07-25 12:56:50.517', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1000', '权限管理', NULL, '/upms', '-1', NULL, 'icon-quanxianguanli', 'Layout', '0', '1', '0', b'0', 0, '', '2018-09-28 08:29:53.000', '1', '2019-07-20 12:03:09.000', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('1100', '用户管理', NULL, 'user', '1000', '1000,', 'icon-yonghuguanli', 'views/admin/user/index', '0', '1', '0', b'0', 1, '', '2017-11-02 22:24:37.000', '1', '2019-07-20 12:02:29.000', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('1101', '用户编辑', 'sys_user_edit', NULL, '1100', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2017-11-08 09:52:09.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1102', '用户锁定', 'sys_user_lock', NULL, '1100', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2017-11-08 09:52:48.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1103', '用户删除', 'sys_user_del', NULL, '1100', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2017-11-08 09:54:01.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1200', '菜单管理', NULL, 'menu', '1000', NULL, 'icon-caidanguanli', 'views/admin/menu/index', '0', '1', '0', b'0', 2, '', '2017-11-08 09:57:27.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1201', '菜单编辑', 'sys_menu_edit', NULL, '1200', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2017-11-08 10:15:53.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1202', '菜单锁定', 'sys_menu_lock', NULL, '1200', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2017-11-08 10:16:23.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1203', '菜单删除', 'sys_menu_del', NULL, '1200', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2017-11-08 10:16:43.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1300', '角色管理', NULL, 'role', '1000', NULL, 'icon-jiaoseguanli', 'views/admin/role/index', '0', '1', '0', b'0', 3, '', '2017-11-08 10:13:37.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1301', '角色编辑', 'sys_role_edit', NULL, '1300', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2017-11-08 10:14:18.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1302', '角色锁定', 'sys_role_lock', NULL, '1300', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2017-11-08 10:14:41.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1303', '角色删除', 'sys_role_del', NULL, '1300', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2017-11-08 10:14:59.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1304', '分配权限', 'sys_role_perm', NULL, '1300', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2018-04-20 07:22:55.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1400', '部门管理', NULL, 'dept', '1000', NULL, 'icon-web-icon-', 'views/admin/dept/index', '0', '1', '0', b'0', 4, '', '2018-01-20 13:17:19.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1401', '部门编辑', 'sys_dept_edit', NULL, '1400', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2018-01-20 14:56:16.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1402', '部门锁定', 'sys_dept_lock', NULL, '1400', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2018-01-20 14:56:59.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1403', '部门删除', 'sys_dept_del', NULL, '1400', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2018-01-20 14:57:28.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('2000', '系统管理', NULL, '/admin', '-1', NULL, 'icon-xitongguanli', 'Layout', '0', '1', '0', b'0', 1, '', '2017-11-07 20:56:00.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('2100', '日志管理', NULL, 'log', '2000', NULL, 'icon-rizhiguanli', 'views/admin/log/index', '0', '1', '0', b'0', 5, '', '2017-11-20 14:06:22.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('2101', '日志删除', 'sys_log_del', NULL, '2100', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2017-11-20 20:37:37.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('2200', '字典管理', NULL, 'dict', '2000', NULL, 'icon-navicon-zdgl', 'views/admin/dict/index', '0', '1', '0', b'0', 6, '', '2017-11-29 11:30:52.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('2201', '字典删除', 'sys_dict_del', NULL, '2200', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2017-11-29 11:30:11.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('2202', '字典编辑', 'sys_dict_edit', NULL, '2200', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2018-05-11 22:34:55.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('2400', '终端管理', '', 'client', '2000', NULL, 'icon-shouji', 'views/admin/client/index', '0', '1', '0', b'0', 9, '', '2018-01-20 13:17:19.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('2401', '客户端新增', 'sys_client_add', NULL, '2400', NULL, '1', NULL, '0', '1', '1', b'0', NULL, '', '2018-05-15 21:35:18.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('2402', '客户端修改', 'sys_client_edit', NULL, '2400', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2018-05-15 21:37:06.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('2403', '客户端删除', 'sys_client_del', NULL, '2400', NULL, NULL, NULL, '0', '1', '1', b'0', NULL, '', '2018-05-15 21:39:16.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('247071d42ff40267c8d8c44eac92da67', '生成方案配置', NULL, 'scheme', '413892fe8d52c1163d6659f51299dc96', '413892fe8d52c1163d6659f51299dc96,', 'icon-appstore', 'views/gen/scheme/index', '0', '1', '0', b'0', 40, '1', '2019-07-21 13:27:35.000', '1', '2019-07-25 13:03:03.800', NULL, 6, '0');
INSERT INTO `sys_menu` VALUES ('2500', '服务监控', NULL, 'http://139.224.200.249:15001', '2000', NULL, 'icon-server', NULL, '0', '1', '0', b'0', 10, '', '2018-06-26 10:50:32.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('2600', '令牌管理', NULL, 'token', '2000', NULL, 'icon-denglvlingpai', 'views/admin/token/index', '0', '1', '0', b'0', 11, '', '2018-09-04 05:58:41.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('2601', '令牌删除', 'sys_token_del', NULL, '2600', NULL, NULL, NULL, '0', '1', '1', b'0', 1, '', '2018-09-04 05:59:50.000', NULL, '2019-07-20 12:03:09.000', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('413892fe8d52c1163d6659f51299dc96', '代码生成', NULL, '/gen', '-1', NULL, 'icon-weibiaoti46', 'Layout', '0', '1', '0', b'0', 30, '1', '2019-07-20 12:00:48.000', '1', '2019-07-21 13:27:55.000', NULL, 16, '0');
INSERT INTO `sys_menu` VALUES ('52715698214e88cb09fa4dd1ea5ad348', '生成方案配置生成菜单', 'gen_scheme_menu', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-07-25 13:03:03.805', '1', '2019-07-25 13:03:03.805', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('54b180c59423abdd7f34859c4ad9d360', '测试树书管理删除', 'test_testTreeBook_delete', NULL, '02e8e5eb3c94dfdf922be6200d63a851', NULL, NULL, NULL, '0', '1', '1', b'0', 80, 'system', '2019-07-25 12:58:36.439', 'system', '2019-07-25 12:58:36.439', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('83ea141a90dfd2ba660bc17fa19b1c82', '测试书籍管理编辑', 'test_testBook_edit', NULL, '09777a9c9d633bdd0ecf4c72e94ce02f', NULL, NULL, NULL, '0', '1', '1', b'0', 40, 'system', '2019-07-25 12:56:50.527', 'system', '2019-07-25 12:56:50.527', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('8b6ef4c189a2177acd0a9705294e68ab', '测试树书管理删除', 'test_testTreeBook_delete', NULL, 'd75f8db0fdf603230276fc0b51c9ca6e', NULL, NULL, NULL, '0', '1', '1', b'0', 80, 'system', '2019-07-25 13:23:12.313', 'system', '2019-07-25 13:23:12.313', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('97722c6d56c8b9990cc3c1a6eea3d6bb', '业务表配置编辑', 'gen_table_edit', NULL, 'a18b33e15bde209a3c9115517c56d9ec', '413892fe8d52c1163d6659f51299dc96,a18b33e15bde209a3c9115517c56d9ec,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-07-21 13:24:02.000', '1', '2019-07-21 13:27:43.000', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('a0bd61f6d182ea82cf91a5e875d47124', '测试树书管理编辑', 'test_testTreeBook_edit', NULL, 'd75f8db0fdf603230276fc0b51c9ca6e', NULL, NULL, NULL, '0', '1', '1', b'0', 40, 'system', '2019-07-25 13:23:12.309', 'system', '2019-07-25 13:23:12.309', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('a18b33e15bde209a3c9115517c56d9ec', '业务表配置', '', 'table', '413892fe8d52c1163d6659f51299dc96', '413892fe8d52c1163d6659f51299dc96,', 'icon-table', 'views/gen/table/index', '0', '1', '0', b'0', 30, '1', '2019-07-20 12:02:02.000', '1', '2019-07-21 13:27:43.000', NULL, 12, '0');
INSERT INTO `sys_menu` VALUES ('aa45ef1bf188ef99b0a98efa5cce3ada', '测试树书管理编辑', 'test_testTreeBook_edit', NULL, '02e8e5eb3c94dfdf922be6200d63a851', NULL, NULL, NULL, '0', '1', '1', b'0', 40, 'system', '2019-07-25 12:58:36.434', 'system', '2019-07-25 12:58:36.434', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('b961670cbf3454f5927c4bd2a327e915', '生成方案配置删除', 'gen_scheme_del', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-07-21 13:30:18.000', '1', '2019-07-21 16:53:54.000', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('d75f8db0fdf603230276fc0b51c9ca6e', '测试树书管理', NULL, 'TestTreeBook', '413892fe8d52c1163d6659f51299dc96', NULL, 'icon-right-square', 'views/test/testTreeBook/index', '0', '1', '0', b'0', 30, 'system', '2019-07-25 13:23:12.300', 'system', '2019-07-25 13:23:12.300', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('e5ea38c1f97dee0043e78f3fb27b25d6', '生成方案配置编辑', 'gen_scheme_edit', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-07-21 13:29:14.000', '1', '2019-07-21 13:29:53.000', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('e710a66583fe0e324492462adb16014e', '业务表配置删除', 'gen_table_del', NULL, 'a18b33e15bde209a3c9115517c56d9ec', '413892fe8d52c1163d6659f51299dc96,a18b33e15bde209a3c9115517c56d9ec,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-07-21 13:24:45.000', '1', '2019-07-21 13:27:43.000', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('f24a210b8b955bdb6ccbd94b449726af', '测试书籍管理删除', 'test_testBook_delete', NULL, '09777a9c9d633bdd0ecf4c72e94ce02f', NULL, NULL, NULL, '0', '1', '1', b'0', 80, 'system', '2019-07-25 12:56:50.531', 'system', '2019-07-25 12:56:50.531', NULL, 0, '0');

-- ----------------------------
-- Table structure for sys_oauth_client_details
-- ----------------------------
DROP TABLE IF EXISTS `sys_oauth_client_details`;
CREATE TABLE `sys_oauth_client_details`  (
  `client_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `resource_ids` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `client_secret` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `scope` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `authorized_grant_types` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `web_server_redirect_uri` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `authorities` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `access_token_validity` int(11) NULL DEFAULT NULL,
  `refresh_token_validity` int(11) NULL DEFAULT NULL,
  `additional_information` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `autoapprove` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`client_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '终端信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oauth_client_details
-- ----------------------------
INSERT INTO `sys_oauth_client_details` VALUES ('albedo', NULL, 'albedo', 'server', 'password,refresh_token,authorization_code,client_credentials', 'http://localhost:4040/sso1/login,http://localhost:4041/sso1/login', NULL, NULL, NULL, NULL, 'true');
INSERT INTO `sys_oauth_client_details` VALUES ('app', NULL, 'app', 'server', 'password,refresh_token', NULL, NULL, NULL, NULL, NULL, 'true');
INSERT INTO `sys_oauth_client_details` VALUES ('daemon', NULL, 'daemon', 'server', 'password,refresh_token', NULL, NULL, NULL, NULL, NULL, 'true');
INSERT INTO `sys_oauth_client_details` VALUES ('gen', NULL, 'gen', 'server', 'password,refresh_token', NULL, NULL, NULL, NULL, NULL, 'true');
INSERT INTO `sys_oauth_client_details` VALUES ('swagger', NULL, 'swagger', 'all', 'password,refresh_token', NULL, NULL, NULL, NULL, NULL, 'true');

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
INSERT INTO `sys_role` VALUES ('1', '管理员', 'ROLE_ADMIN', '管理员', '1', '0', '', '2017-10-29 15:45:51.000', '1', '2019-07-25 13:18:08.959', NULL, 18, '0');
INSERT INTO `sys_role` VALUES ('2', 'ROLE_CQQ', 'ROLE_CQQ', 'ROLE_CQQ', '5', '0', '', '2018-11-11 19:42:26.000', '1', '2019-07-25 13:18:10.502', NULL, 5, '0');

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
INSERT INTO `sys_role_dept` VALUES ('04cfdd20fc4302f79502b3f2f4fa72f0', '2', '4');
INSERT INTO `sys_role_dept` VALUES ('13fcc762a01361c49a33ffc54bf27fa3', '1', '8');
INSERT INTO `sys_role_dept` VALUES ('8a1c5d650fba53c881ee60ca585ad0ba', '2', '1');
INSERT INTO `sys_role_dept` VALUES ('a21ea0ec75308dee93356aa45fca85ff', '2', '3');
INSERT INTO `sys_role_dept` VALUES ('e4bd2e2abdb0587fd20423ee122b797c', '2', '5');

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
INSERT INTO `sys_role_menu` VALUES ('1', '02e8e5eb3c94dfdf922be6200d63a851');
INSERT INTO `sys_role_menu` VALUES ('1', '09777a9c9d633bdd0ecf4c72e94ce02f');
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
INSERT INTO `sys_role_menu` VALUES ('1', '54b180c59423abdd7f34859c4ad9d360');
INSERT INTO `sys_role_menu` VALUES ('1', '83ea141a90dfd2ba660bc17fa19b1c82');
INSERT INTO `sys_role_menu` VALUES ('1', '97722c6d56c8b9990cc3c1a6eea3d6bb');
INSERT INTO `sys_role_menu` VALUES ('1', 'a18b33e15bde209a3c9115517c56d9ec');
INSERT INTO `sys_role_menu` VALUES ('1', 'aa45ef1bf188ef99b0a98efa5cce3ada');
INSERT INTO `sys_role_menu` VALUES ('1', 'b961670cbf3454f5927c4bd2a327e915');
INSERT INTO `sys_role_menu` VALUES ('1', 'e5ea38c1f97dee0043e78f3fb27b25d6');
INSERT INTO `sys_role_menu` VALUES ('1', 'e710a66583fe0e324492462adb16014e');
INSERT INTO `sys_role_menu` VALUES ('1', 'f24a210b8b955bdb6ccbd94b449726af');
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
INSERT INTO `sys_user` VALUES ('90da0206c39867a1b36ac36ced80c1a9', 'adsfsd', '$2a$10$81JhU58/uM.JmWKiCAcxoOiSS///NT6rXbSRATa.UgGG8stlA1ABy', NULL, NULL, NULL, NULL, '3', NULL, NULL, '0', '1', '2019-07-07 14:35:13.000', '1', '2019-07-25 12:57:19.710', NULL, 30, '0');

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
  `status_` int(11) NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `version` int(11) NULL DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `email`(`email_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '测试书籍' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of test_book
-- ----------------------------
INSERT INTO `test_book` VALUES ('a3a7afa3364b4556ae3433d1122cc65b', 'test', 'test', 'test', '', '', b'1', 32, 12.30, 12.00, '2019-07-24 21:00:16.111', '1', '2019-07-24 21:09:55.000', '1', '2018-11-08 19:18:09.000', -1, '', 0, '0');

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
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
  `version` int(11) NOT NULL,
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '  测试树书' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of test_tree_book
-- ----------------------------
INSERT INTO `test_tree_book` VALUES ('1', '-1', NULL, '山东农信', NULL, b'0', '', '2018-01-22 19:00:23.000', NULL, '2019-07-04 16:57:18.000', 0, '', '0');
INSERT INTO `test_tree_book` VALUES ('10', '8', NULL, '院校沙县', NULL, b'0', '', '2018-12-10 21:19:26.000', NULL, '2019-06-15 10:56:41.000', 0, '', '0');
INSERT INTO `test_tree_book` VALUES ('2', '-1', NULL, '沙县国际', NULL, b'0', '', '2018-01-22 19:00:38.000', NULL, '2019-07-04 16:57:22.000', 0, '', '0');
INSERT INTO `test_tree_book` VALUES ('3', '1', NULL, '潍坊农信', NULL, b'0', '', '2018-01-22 19:00:44.000', NULL, '2019-06-15 10:56:41.000', 0, '', '0');
INSERT INTO `test_tree_book` VALUES ('4', '3', NULL, '高新农信', 30, b'0', '', '2018-01-22 19:00:52.000', '1', '2019-07-14 09:02:57.000', 6, '', '0');
INSERT INTO `test_tree_book` VALUES ('5', '4', NULL, '院校农信', 30, b'0', '', '2018-01-22 19:00:57.000', '1', '2019-07-14 09:10:44.000', 1, '', '0');
INSERT INTO `test_tree_book` VALUES ('5f86e2a82b040b1f618aefc62f403024', '5', '5,', '11', 1, b'1', '1', '2019-07-14 09:10:45.000', '1', '2019-07-14 09:10:57.000', 0, NULL, '1');
INSERT INTO `test_tree_book` VALUES ('6', '5', NULL, '潍院农信', NULL, b'0', '', '2018-01-22 19:01:06.000', NULL, '2019-01-09 10:58:18.000', 0, '', '0');
INSERT INTO `test_tree_book` VALUES ('7', '2', NULL, '山东沙县', NULL, b'0', '', '2018-01-22 19:01:57.000', NULL, '2019-06-15 10:56:41.000', 0, '', '0');
INSERT INTO `test_tree_book` VALUES ('8', '7', NULL, '潍坊沙县', NULL, b'0', '', '2018-01-22 19:02:03.000', NULL, '2019-06-15 10:56:41.000', 0, '', '0');
INSERT INTO `test_tree_book` VALUES ('9', '8', NULL, '高新沙县', NULL, b'0', '', '2018-01-22 19:02:14.000', NULL, '2018-09-13 01:46:44.000', 0, '', '0');

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
