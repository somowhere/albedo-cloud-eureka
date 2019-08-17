/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : albedo-cloud

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 17/08/2019 14:15:42
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
INSERT INTO `gen_scheme` VALUES ('d68a01a9c90b9b8eae1b4a724d2aa893', '测试书籍管理', 'curd', NULL, 'com.albedo.java.modules', 'test', NULL, '测试书籍', '测试书籍', 'admin', '2647d69fd0bfb867592feb4169c9de08', 0, NULL, '1', '2019-07-26 21:29:52.533', '1', '2019-07-26 21:27:35.283', '1');

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
INSERT INTO `gen_table` VALUES ('2647d69fd0bfb867592feb4169c9de08', 'test_book', '测试书籍', 'TestBook', NULL, NULL, 0, NULL, '1', '2019-07-26 21:26:53.263', '1', '2019-07-26 21:26:53.263', '0');
INSERT INTO `gen_table` VALUES ('9bd488c16685633e6b216110f77aef1a', 'test_tree_book', '  测试树书', 'TestTreeBook', NULL, NULL, 0, NULL, '1', '2019-07-26 21:27:03.360', '1', '2019-07-26 21:27:03.360', '0');

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
INSERT INTO `gen_table_column` VALUES ('077dd09c5df3ffdc3b11a57680e381d3', '2647d69fd0bfb867592feb4169c9de08', 'del_flag', '0-正常，1-删除', NULL, 'char(1)', 'String', 'delFlag', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 180, 0, NULL, '1', '2019-07-26 21:26:53.398', '1', '2019-07-26 21:26:53.398', '0');
INSERT INTO `gen_table_column` VALUES ('094e9427b885cd6945c21980dd3ce146', '2647d69fd0bfb867592feb4169c9de08', 'description', '备注', NULL, 'varchar(255)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'textarea', '', NULL, 160, 0, NULL, '1', '2019-07-26 21:26:53.395', '1', '2019-07-26 21:26:53.395', '0');
INSERT INTO `gen_table_column` VALUES ('0df756068dcab61a53fa007ade7dbd27', '9bd488c16685633e6b216110f77aef1a', 'description', '备注', NULL, 'varchar(100)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'textarea', '', NULL, 210, 0, NULL, '1', '2019-07-26 21:27:03.379', '1', '2019-07-26 21:27:03.379', '0');
INSERT INTO `gen_table_column` VALUES ('1cc0aa8acea435f84f2ed5fd6c18301b', '2647d69fd0bfb867592feb4169c9de08', 'created_by', 'created_by', NULL, 'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 120, 0, NULL, '1', '2019-07-26 21:26:53.387', '1', '2019-07-26 21:26:53.387', '0');
INSERT INTO `gen_table_column` VALUES ('1ee6e11fe3af2c802e0a329cf7b9c517', '9bd488c16685633e6b216110f77aef1a', 'amount_', 'amount_', NULL, 'double(11,2)', 'Double', 'amount', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 130, 0, NULL, '1', '2019-07-26 21:27:03.375', '1', '2019-07-26 21:27:03.375', '0');
INSERT INTO `gen_table_column` VALUES ('20127b6f30f00f755d10aff5d2f04415', '2647d69fd0bfb867592feb4169c9de08', 'phone_', '手机', NULL, 'varchar(32)', 'String', 'phone', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 60, 0, NULL, '1', '2019-07-26 21:26:53.373', '1', '2019-07-26 21:26:53.373', '0');
INSERT INTO `gen_table_column` VALUES ('251013ce4e1cec605ebd3d57d1afbd7a', '9bd488c16685633e6b216110f77aef1a', 'last_modified_by', 'last_modified_by', NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 170, 0, NULL, '1', '2019-07-26 21:27:03.377', '1', '2019-07-26 21:27:03.377', '0');
INSERT INTO `gen_table_column` VALUES ('3117f15ba75beb480f9281b2aaa625d6', '9bd488c16685633e6b216110f77aef1a', 'parent_ids', '父菜单IDs', NULL, 'varchar(2000)', 'String', 'parentIds', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 30, 0, NULL, '1', '2019-07-26 21:27:03.368', '1', '2019-07-26 21:27:03.368', '0');
INSERT INTO `gen_table_column` VALUES ('3807a28c7172ea0e229580a015d8e5ab', '9bd488c16685633e6b216110f77aef1a', 'last_modified_date', '修改时间', NULL, 'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 190, 0, NULL, '1', '2019-07-26 21:27:03.378', '1', '2019-07-26 21:27:03.378', '0');
INSERT INTO `gen_table_column` VALUES ('46a63a50dbbdc7060ac50f92e468d741', '2647d69fd0bfb867592feb4169c9de08', 'created_date', 'created_date', NULL, 'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 130, 0, NULL, '1', '2019-07-26 21:26:53.389', '1', '2019-07-26 21:26:53.389', '0');
INSERT INTO `gen_table_column` VALUES ('4bfe1ef2d449b831935e00f66be17eff', '2647d69fd0bfb867592feb4169c9de08', 'reset_date', 'reset_date', NULL, 'timestamp(3)', 'java.util.Date', 'resetDate', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'dateselect', '', NULL, 110, 0, NULL, '1', '2019-07-26 21:26:53.385', '1', '2019-07-26 21:26:53.385', '0');
INSERT INTO `gen_table_column` VALUES ('54564e1b6ba1bb88c47829e206ee620a', '9bd488c16685633e6b216110f77aef1a', 'id', 'id', NULL, 'varchar(32)', 'String', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 0, NULL, '1', '2019-07-26 21:27:03.365', '1', '2019-07-26 21:27:03.365', '0');
INSERT INTO `gen_table_column` VALUES ('54f4adfa4f4370dee3fce7331fc8cd48', '9bd488c16685633e6b216110f77aef1a', 'created_date', '创建时间', NULL, 'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 160, 0, NULL, '1', '2019-07-26 21:27:03.376', '1', '2019-07-26 21:27:03.376', '0');
INSERT INTO `gen_table_column` VALUES ('5684789f5c2450565d62276a80974a9e', '2647d69fd0bfb867592feb4169c9de08', 'last_modified_by', 'last_modified_by', NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 140, 0, NULL, '1', '2019-07-26 21:26:53.390', '1', '2019-07-26 21:26:53.390', '0');
INSERT INTO `gen_table_column` VALUES ('5aaee98a76296dc65c48c1eedf95fe84', '9bd488c16685633e6b216110f77aef1a', 'money_', 'money_', NULL, 'decimal(20,2)', 'Double', 'money', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 120, 0, NULL, '1', '2019-07-26 21:27:03.374', '1', '2019-07-26 21:27:03.374', '0');
INSERT INTO `gen_table_column` VALUES ('692f23ec24808cc55615362b1c13e1b4', '9bd488c16685633e6b216110f77aef1a', 'author_', '作者', NULL, 'varchar(50)', 'String', 'author', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 70, 0, NULL, '1', '2019-07-26 21:27:03.371', '1', '2019-07-26 21:27:03.371', '0');
INSERT INTO `gen_table_column` VALUES ('7d108d6f1440902387e36fa62fceee61', '2647d69fd0bfb867592feb4169c9de08', 'last_modified_date', 'last_modified_date', NULL, 'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 150, 0, NULL, '1', '2019-07-26 21:26:53.393', '1', '2019-07-26 21:26:53.393', '0');
INSERT INTO `gen_table_column` VALUES ('8496b65b885fe84fe56d1addf995b4e0', '9bd488c16685633e6b216110f77aef1a', 'version', 'version', NULL, 'int(11)', 'Long', 'version', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 200, 0, NULL, '1', '2019-07-26 21:27:03.379', '1', '2019-07-26 21:27:03.379', '0');
INSERT INTO `gen_table_column` VALUES ('851f019889373f130ef5971150622095', '9bd488c16685633e6b216110f77aef1a', 'name', '部门名称', NULL, 'varchar(50)', 'String', 'name', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 40, 0, NULL, '1', '2019-07-26 21:27:03.369', '1', '2019-07-26 21:27:03.369', '0');
INSERT INTO `gen_table_column` VALUES ('8ec3836f1e2dd1b35dfa59facae00c2d', '9bd488c16685633e6b216110f77aef1a', 'leaf', '1 叶子节点 0 非叶子节点', NULL, 'bit(1)', 'Integer', 'leaf', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 60, 0, NULL, '1', '2019-07-26 21:27:03.370', '1', '2019-07-26 21:27:03.370', '0');
INSERT INTO `gen_table_column` VALUES ('9734dc0c7227b0495f6c878366c59afa', '2647d69fd0bfb867592feb4169c9de08', 'id', 'id', NULL, 'varchar(32)', 'String', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 0, NULL, '1', '2019-07-26 21:26:53.344', '1', '2019-07-26 21:26:53.344', '0');
INSERT INTO `gen_table_column` VALUES ('9a0e586d2f2c8137b94b026c96022abd', '2647d69fd0bfb867592feb4169c9de08', 'version', 'version', NULL, 'int(11)', 'Long', 'version', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 170, 0, NULL, '1', '2019-07-26 21:26:53.396', '1', '2019-07-26 21:26:53.396', '0');
INSERT INTO `gen_table_column` VALUES ('a5491739d209f5c88fd5408fe4303bba', '9bd488c16685633e6b216110f77aef1a', 'reset_date', 'reset_date', NULL, 'timestamp(3)', 'java.util.Date', 'resetDate', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'dateselect', '', NULL, 140, 0, NULL, '1', '2019-07-26 21:27:03.375', '1', '2019-07-26 21:27:03.375', '0');
INSERT INTO `gen_table_column` VALUES ('a67ae742fdd65f3b06103a5fcb0ef692', '9bd488c16685633e6b216110f77aef1a', 'email_', '邮箱', NULL, 'varchar(100)', 'String', 'email', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 80, 0, NULL, '1', '2019-07-26 21:27:03.371', '1', '2019-07-26 21:27:03.371', '0');
INSERT INTO `gen_table_column` VALUES ('a90eb887e6e2b6841a51f50641f6b83e', '9bd488c16685633e6b216110f77aef1a', 'del_flag', '0-正常，1-删除', NULL, 'char(1)', 'String', 'delFlag', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 180, 0, NULL, '1', '2019-07-26 21:27:03.378', '1', '2019-07-26 21:27:03.378', '0');
INSERT INTO `gen_table_column` VALUES ('b203fe2c598115ca8c74f30041dd503b', '2647d69fd0bfb867592feb4169c9de08', 'name_', '名称', NULL, 'varchar(50)', 'String', 'name', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 40, 0, NULL, '1', '2019-07-26 21:26:53.366', '1', '2019-07-26 21:26:53.366', '0');
INSERT INTO `gen_table_column` VALUES ('b2ecffc816cfc4025c7491dc5c739948', '2647d69fd0bfb867592feb4169c9de08', 'money_', 'money_', NULL, 'decimal(20,2)', 'Double', 'money', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 90, 0, NULL, '1', '2019-07-26 21:26:53.382', '1', '2019-07-26 21:26:53.382', '0');
INSERT INTO `gen_table_column` VALUES ('c4c4b785de75a96eb34e87fdf85213d9', '2647d69fd0bfb867592feb4169c9de08', 'author_', '作者', NULL, 'varchar(50)', 'String', 'author', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 30, 0, NULL, '1', '2019-07-26 21:26:53.362', '1', '2019-07-26 21:26:53.362', '0');
INSERT INTO `gen_table_column` VALUES ('d834b8e226ebd275da56273ef3a28a8e', '2647d69fd0bfb867592feb4169c9de08', 'title_', '标题', NULL, 'varchar(32)', 'String', 'title', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 20, 0, NULL, '1', '2019-07-26 21:26:53.357', '1', '2019-07-26 21:26:53.357', '0');
INSERT INTO `gen_table_column` VALUES ('dbde2eb053e81838e08d3ea684f61770', '9bd488c16685633e6b216110f77aef1a', 'phone_', '手机', NULL, 'varchar(32)', 'String', 'phone', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 90, 0, NULL, '1', '2019-07-26 21:27:03.372', '1', '2019-07-26 21:27:03.372', '0');
INSERT INTO `gen_table_column` VALUES ('e091fb6b3b34c5a82347380625e188a2', '2647d69fd0bfb867592feb4169c9de08', 'amount_', 'amount_', NULL, 'double(11,2)', 'Double', 'amount', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 100, 0, NULL, '1', '2019-07-26 21:26:53.384', '1', '2019-07-26 21:26:53.384', '0');
INSERT INTO `gen_table_column` VALUES ('e1159f0d7daa241b64a0af48dfd89eeb', '2647d69fd0bfb867592feb4169c9de08', 'email_', '邮箱', NULL, 'varchar(100)', 'String', 'email', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 50, 0, NULL, '1', '2019-07-26 21:26:53.368', '1', '2019-07-26 21:26:53.368', '0');
INSERT INTO `gen_table_column` VALUES ('e44bff5f3c62d7160466d04f7e49d2bf', '9bd488c16685633e6b216110f77aef1a', 'number_', 'key', NULL, 'int(11)', 'Long', 'number', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 110, 0, NULL, '1', '2019-07-26 21:27:03.373', '1', '2019-07-26 21:27:03.373', '0');
INSERT INTO `gen_table_column` VALUES ('e5cda3de80e161808df0afc505e77199', '9bd488c16685633e6b216110f77aef1a', 'created_by', 'created_by', NULL, 'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 150, 0, NULL, '1', '2019-07-26 21:27:03.376', '1', '2019-07-26 21:27:03.376', '0');
INSERT INTO `gen_table_column` VALUES ('e777e8ed324c73893601a8ce027c355e', '2647d69fd0bfb867592feb4169c9de08', 'activated_', 'activated_', NULL, 'bit(1)', 'Integer', 'activated', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 70, 0, NULL, '1', '2019-07-26 21:26:53.375', '1', '2019-07-26 21:26:53.375', '0');
INSERT INTO `gen_table_column` VALUES ('f8bfd9269af36d5abfb378dd6d9ab4a0', '9bd488c16685633e6b216110f77aef1a', 'activated_', 'activated_', NULL, 'bit(1)', 'Integer', 'activated', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 100, 0, NULL, '1', '2019-07-26 21:27:03.373', '1', '2019-07-26 21:27:03.373', '0');
INSERT INTO `gen_table_column` VALUES ('fad52d820db3e7e4225565af4643cada', '9bd488c16685633e6b216110f77aef1a', 'parent_id', 'parent_id', NULL, 'varchar(32)', 'String', 'parentId', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 20, 0, NULL, '1', '2019-07-26 21:27:03.367', '1', '2019-07-26 21:27:03.367', '0');
INSERT INTO `gen_table_column` VALUES ('fd2da703fba14837719f978638b136f1', '2647d69fd0bfb867592feb4169c9de08', 'number_', 'key', NULL, 'int(11)', 'Long', 'number', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 80, 0, NULL, '1', '2019-07-26 21:26:53.378', '1', '2019-07-26 21:26:53.378', '0');
INSERT INTO `gen_table_column` VALUES ('fd38a6f79a36c4fc20f4ee97d1dda9d4', '9bd488c16685633e6b216110f77aef1a', 'sort', '排序', NULL, 'int(11)', 'Long', 'sort', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 50, 0, NULL, '1', '2019-07-26 21:27:03.369', '1', '2019-07-26 21:27:03.369', '0');

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
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `blob_data` blob NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `calendar` blob NOT NULL,
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `cron_expression` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `time_zone_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
INSERT INTO `qrtz_cron_triggers` VALUES ('AlbedoScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', '0/10 * * * * ?', 'Asia/Singapore');
INSERT INTO `qrtz_cron_triggers` VALUES ('AlbedoScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', '0/15 * * * * ?', 'Asia/Singapore');
INSERT INTO `qrtz_cron_triggers` VALUES ('AlbedoScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', '0/20 * * * * ?', 'Asia/Singapore');

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `entry_id` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `fired_time` bigint(13) NOT NULL,
  `sched_time` bigint(13) NOT NULL,
  `priority` int(11) NOT NULL,
  `state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `job_class_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_durable` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_update_data` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `job_data` blob NULL,
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
INSERT INTO `qrtz_job_details` VALUES ('AlbedoScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', NULL, 'com.albedo.java.modules.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720029636F6D2E616C6265646F2E6A6176612E6D6F64756C65732E71756172747A2E646F6D61696E2E4A6F6200000000000000010200074C0009617661696C61626C657400124C6A6176612F6C616E672F537472696E673B4C000A636F6E63757272656E7471007E00094C000E63726F6E45787072657373696F6E71007E00094C000567726F757071007E00094C000C696E766F6B6554617267657471007E00094C000D6D697366697265506F6C69637971007E00094C00046E616D6571007E000978720032636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E4964456E7469747900000000000000010200014C0002696471007E000978720034636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E44617461456E7469747900000000000000010200064C000963726561746564427971007E00094C000B63726561746564446174657400194C6A6176612F74696D652F4C6F63616C4461746554696D653B4C000B6465736372697074696F6E71007E00094C000E6C6173744D6F646966696564427971007E00094C00106C6173744D6F6469666965644461746571007E000C4C000776657273696F6E7400134C6A6176612F6C616E672F496E74656765723B78720034636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E42617365456E7469747900000000000000010200014C000764656C466C616771007E000978720037636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E47656E6572616C456E74697479000000000000000102000078720035636F6D2E62616F6D69646F752E6D796261746973706C75732E657874656E73696F6E2E6163746976657265636F72642E4D6F64656C00000000000000010200007870740001307400007372000D6A6176612E74696D652E536572955D84BA1B2248B20C00007870770A05000007E3080E0A15DB7870740001317371007E0014770E05000007E3080F102B1831A6924078737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000574000131740001307400013174000E302F3130202A202A202A202A203F74000744454641554C5474001573696D706C655461736B2E646F4E6F506172616D7374000133740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E697A0E58F82EFBC897800);
INSERT INTO `qrtz_job_details` VALUES ('AlbedoScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', NULL, 'com.albedo.java.modules.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720029636F6D2E616C6265646F2E6A6176612E6D6F64756C65732E71756172747A2E646F6D61696E2E4A6F6200000000000000010200074C0009617661696C61626C657400124C6A6176612F6C616E672F537472696E673B4C000A636F6E63757272656E7471007E00094C000E63726F6E45787072657373696F6E71007E00094C000567726F757071007E00094C000C696E766F6B6554617267657471007E00094C000D6D697366697265506F6C69637971007E00094C00046E616D6571007E000978720032636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E4964456E7469747900000000000000010200014C0002696471007E000978720034636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E44617461456E7469747900000000000000010200064C000963726561746564427971007E00094C000B63726561746564446174657400194C6A6176612F74696D652F4C6F63616C4461746554696D653B4C000B6465736372697074696F6E71007E00094C000E6C6173744D6F646966696564427971007E00094C00106C6173744D6F6469666965644461746571007E000C4C000776657273696F6E7400134C6A6176612F6C616E672F496E74656765723B78720034636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E42617365456E7469747900000000000000010200014C000764656C466C616771007E000978720037636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E47656E6572616C456E74697479000000000000000102000078720035636F6D2E62616F6D69646F752E6D796261746973706C75732E657874656E73696F6E2E6163746976657265636F72642E4D6F64656C00000000000000010200007870740001307400007372000D6A6176612E74696D652E536572955D84BA1B2248B20C00007870770E05000007E3080E0A1524389FD9807870740001317371007E0014770E05000007E3080F110A382E8D1D4078737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000B74000132740001317400013174000E302F3135202A202A202A202A203F74000744454641554C5474001D73696D706C655461736B2E646F506172616D732827616C6265646F272974000133740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E69C89E58F82EFBC897800);
INSERT INTO `qrtz_job_details` VALUES ('AlbedoScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', NULL, 'com.albedo.java.modules.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720029636F6D2E616C6265646F2E6A6176612E6D6F64756C65732E71756172747A2E646F6D61696E2E4A6F6200000000000000010200074C0009617661696C61626C657400124C6A6176612F6C616E672F537472696E673B4C000A636F6E63757272656E7471007E00094C000E63726F6E45787072657373696F6E71007E00094C000567726F757071007E00094C000C696E766F6B6554617267657471007E00094C000D6D697366697265506F6C69637971007E00094C00046E616D6571007E000978720032636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E4964456E7469747900000000000000010200014C0002696471007E000978720034636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E44617461456E7469747900000000000000010200064C000963726561746564427971007E00094C000B63726561746564446174657400194C6A6176612F74696D652F4C6F63616C4461746554696D653B4C000B6465736372697074696F6E71007E00094C000E6C6173744D6F646966696564427971007E00094C00106C6173744D6F6469666965644461746571007E000C4C000776657273696F6E7400134C6A6176612F6C616E672F496E74656765723B78720034636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E42617365456E7469747900000000000000010200014C000764656C466C616771007E000978720037636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E47656E6572616C456E74697479000000000000000102000078720035636F6D2E62616F6D69646F752E6D796261746973706C75732E657874656E73696F6E2E6163746976657265636F72642E4D6F64656C00000000000000010200007870740001307400007372000D6A6176612E74696D652E536572955D84BA1B2248B20C00007870770A05000007E3080E0A15DB7870740001317371007E0014770E05000007E3080F102B161DDCA74078737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000374000133740001307400013174000E302F3230202A202A202A202A203F74000744454641554C5474004073696D706C655461736B2E646F4D756C7469706C65506172616D732827616C6265646F272C20747275652C20323030304C2C203331362E3530442C203130302974000133740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E5A49AE58F82EFBC897800);

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `lock_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO `qrtz_locks` VALUES ('AlbedoScheduler', 'STATE_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('AlbedoScheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_checkin_time` bigint(13) NOT NULL,
  `checkin_interval` bigint(13) NOT NULL,
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
INSERT INTO `qrtz_scheduler_state` VALUES ('AlbedoScheduler', 'somewhere1566020091230', 1566022500583, 15000);
INSERT INTO `qrtz_scheduler_state` VALUES ('RuoyiScheduler', 'DESKTOP-CHC8CQ91565759389736', 1565759603030, 15000);

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `repeat_count` bigint(7) NOT NULL,
  `repeat_interval` bigint(12) NOT NULL,
  `times_triggered` bigint(10) NOT NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `str_prop_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `str_prop_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `str_prop_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `int_prop_1` int(11) NULL DEFAULT NULL,
  `int_prop_2` int(11) NULL DEFAULT NULL,
  `long_prop_1` bigint(20) NULL DEFAULT NULL,
  `long_prop_2` bigint(20) NULL DEFAULT NULL,
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL,
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL,
  `bool_prop_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `bool_prop_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `next_fire_time` bigint(13) NULL DEFAULT NULL,
  `prev_fire_time` bigint(13) NULL DEFAULT NULL,
  `priority` int(11) NULL DEFAULT NULL,
  `trigger_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `start_time` bigint(13) NOT NULL,
  `end_time` bigint(13) NULL DEFAULT NULL,
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `misfire_instr` smallint(2) NULL DEFAULT NULL,
  `job_data` blob NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name`, `job_name`, `job_group`) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
INSERT INTO `qrtz_triggers` VALUES ('AlbedoScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', 'TASK_CLASS_NAME1', 'DEFAULT', NULL, 1566020100000, -1, 5, 'PAUSED', 'CRON', 1566020091000, 0, NULL, 2, '');
INSERT INTO `qrtz_triggers` VALUES ('AlbedoScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', 'TASK_CLASS_NAME2', 'DEFAULT', NULL, 1566022515000, 1566022500000, 5, 'WAITING', 'CRON', 1566020091000, 0, NULL, 2, '');
INSERT INTO `qrtz_triggers` VALUES ('AlbedoScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', 'TASK_CLASS_NAME3', 'DEFAULT', NULL, 1566020100000, -1, 5, 'PAUSED', 'CRON', 1566020091000, 0, NULL, 2, '');

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
INSERT INTO `sys_dict` VALUES ('0b2420638683f1eec41242beb9912069', '在线', 'on_line', 'sys_online_status_on_line', 'f3592a047c466e348279983336ebaf28', '1,cfd5f62f601817a3b0f38f5ccb1f5128,f3592a047c466e348279983336ebaf28,', 30, b'1', b'1', NULL, '1', '2019-08-11 11:17:28.210', '1', '2019-08-11 11:17:28.210', 0, NULL, '0');
INSERT INTO `sys_dict` VALUES ('0da02abef85f0c0b4350eaeefb4ca78d', '仅本人数据', '4', 'sys_data_scope_4', 'aa294a48211a2deb5c7d76c5e90dc28e', '1,cfd5f62f601817a3b0f38f5ccb1f5128,aa294a48211a2deb5c7d76c5e90dc28e,', 40, b'1', b'1', NULL, '1', '2019-07-14 06:00:03.000', '1', '2019-08-09 11:26:04.724', 5, NULL, '0');
INSERT INTO `sys_dict` VALUES ('0ef7242f2bb88fdbdcbc56e7a879efb0', '其他', '0', 'sys_business_type_0', 'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 10, b'1', b'1', NULL, '1', '2019-08-07 16:49:39.000', '1', '2019-08-09 11:26:04.726', 3, NULL, '0');
INSERT INTO `sys_dict` VALUES ('0fdd548394368b4969136f32c435fd98', '按钮', '1', 'sys_menu_type_1', 'e26ee931e276a099fb876541ca18756f', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e26ee931e276a099fb876541ca18756f,', 20, b'1', b'1', NULL, '1', '2019-07-14 06:04:44.000', '1', '2019-08-09 11:26:04.726', 4, NULL, '0');
INSERT INTO `sys_dict` VALUES ('1', '数据字典', '', 'base', '-1', NULL, 1, b'1', b'0', '', '1', '2018-07-09 06:16:14.000', '1', '2019-08-09 11:26:04.707', 11, '', '0');
INSERT INTO `sys_dict` VALUES ('2', '是否标识', '', 'sys_flag', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 10, b'1', b'0', NULL, '1', '2019-06-02 17:17:44.000', '1', '2019-08-09 11:26:04.727', 17, NULL, '0');
INSERT INTO `sys_dict` VALUES ('269ebbfff898cf1db0d243e3f7774d2c', '业务数据', 'biz', 'biz', '1', '1,', 30, b'1', b'1', NULL, '1', '2019-07-14 04:01:51.000', '1', '2019-08-09 11:24:15.473', 4, NULL, '0');
INSERT INTO `sys_dict` VALUES ('2ec9dffe7cb0dea12c8e4e2a90279711', '强退', '6', 'sys_business_type_6', 'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 70, b'1', b'1', NULL, '1', '2019-08-07 16:52:15.681', '1', '2019-08-09 11:26:04.727', 2, NULL, '0');
INSERT INTO `sys_dict` VALUES ('3', '是', '1', 'sys_flag_yes', '2', '1,cfd5f62f601817a3b0f38f5ccb1f5128,2,', 10, b'1', b'1', '', '1', '2018-07-09 06:15:40.000', '1', '2019-08-09 11:26:04.728', 5, '', '0');
INSERT INTO `sys_dict` VALUES ('31d677b181cebb9bde79b78f32e1e8a3', '其他', '0', 'sys_operate_type_0', '6b8211aef2fec451b0398b19857443a7', '1,cfd5f62f601817a3b0f38f5ccb1f5128,6b8211aef2fec451b0398b19857443a7,', 10, b'1', b'1', NULL, '1', '2019-08-07 16:48:21.644', '1', '2019-08-09 11:26:04.730', 2, NULL, '0');
INSERT INTO `sys_dict` VALUES ('4', '否', '0', 'sys_flag_no', '2', '1,cfd5f62f601817a3b0f38f5ccb1f5128,2,', 30, b'1', b'1', NULL, '1', '2019-06-02 17:26:40.000', '1', '2019-08-09 11:26:04.732', 6, NULL, '0');
INSERT INTO `sys_dict` VALUES ('4198b5e10fe052546ebb689b4103590e', '所在机构数据', '3', 'sys_data_scope_3', 'aa294a48211a2deb5c7d76c5e90dc28e', '1,cfd5f62f601817a3b0f38f5ccb1f5128,aa294a48211a2deb5c7d76c5e90dc28e,', 30, b'1', b'1', NULL, '1', '2019-07-14 05:59:13.000', '1', '2019-08-09 11:26:04.733', 7, NULL, '0');
INSERT INTO `sys_dict` VALUES ('51828811168cd9f0ee1d118068a7d0b9', '编辑', '1', 'sys_business_type_1', 'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 20, b'1', b'1', NULL, '1', '2019-08-07 16:50:20.634', '1', '2019-08-09 11:26:04.733', 2, NULL, '0');
INSERT INTO `sys_dict` VALUES ('5933a853cd0199b00424d66f4b92dda3', '所在机构及以下数据', '2', 'sys_data_scope_2', 'aa294a48211a2deb5c7d76c5e90dc28e', '1,cfd5f62f601817a3b0f38f5ccb1f5128,aa294a48211a2deb5c7d76c5e90dc28e,', 20, b'1', b'1', NULL, '1', '2019-07-14 05:53:55.000', '1', '2019-08-09 11:26:04.734', 7, NULL, '0');
INSERT INTO `sys_dict` VALUES ('5f2414b2670c9a66c1d5364613caa654', '后台用户', '1', 'sys_operate_type_1', '6b8211aef2fec451b0398b19857443a7', '1,cfd5f62f601817a3b0f38f5ccb1f5128,6b8211aef2fec451b0398b19857443a7,', 20, b'1', b'1', NULL, '1', '2019-08-07 16:48:40.344', '1', '2019-08-09 11:26:04.734', 2, NULL, '0');
INSERT INTO `sys_dict` VALUES ('6b8211aef2fec451b0398b19857443a7', '操作人类别', NULL, 'sys_operator_type', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', NULL, '1', '2019-08-07 15:37:09.613', '1', '2019-08-09 11:26:04.734', 6, NULL, '0');
INSERT INTO `sys_dict` VALUES ('6e4bba74f32df9149d69f8e9bb19cd9d', '菜单', '0', 'sys_menu_type_0', 'e26ee931e276a099fb876541ca18756f', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e26ee931e276a099fb876541ca18756f,', 10, b'1', b'1', NULL, '1', '2019-07-14 06:04:10.000', '1', '2019-08-09 11:26:04.736', 4, NULL, '0');
INSERT INTO `sys_dict` VALUES ('764d1eaf8a39698fc85a7204c96e7089', '生成代码', '7', 'sys_business_type_7', 'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 80, b'1', b'1', NULL, '1', '2019-08-07 16:52:36.997', '1', '2019-08-09 11:26:04.739', 2, NULL, '0');
INSERT INTO `sys_dict` VALUES ('80b084e162b0a30b348a45ff29e5b326', '导出', '4', 'sys_business_type_4', 'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 50, b'1', b'1', NULL, '1', '2019-08-07 16:51:33.286', '1', '2019-08-09 11:26:04.739', 2, NULL, '0');
INSERT INTO `sys_dict` VALUES ('8153bd2af73b6d59eed9f34d2bc05bb9', '删除', '3', 'sys_business_type_3', 'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 40, b'1', b'1', NULL, '1', '2019-08-07 16:50:45.270', '1', '2019-08-09 11:26:04.740', 2, NULL, '0');
INSERT INTO `sys_dict` VALUES ('8883abe4dcf9390df69a5740050abf74', '离线', 'off_line', 'sys_online_status_off_line', 'f3592a047c466e348279983336ebaf28', '1,cfd5f62f601817a3b0f38f5ccb1f5128,f3592a047c466e348279983336ebaf28,', 30, b'1', b'1', NULL, '1', '2019-08-11 11:17:50.132', '1', '2019-08-11 11:17:50.132', 0, NULL, '0');
INSERT INTO `sys_dict` VALUES ('8c4589d0a32c9b84b6254507354a195b', 'test', 'test', 'test', '-1', NULL, 30, b'1', b'1', NULL, '1', '2019-07-14 03:59:38.000', '1', '2019-07-14 04:00:28.000', 0, NULL, '1');
INSERT INTO `sys_dict` VALUES ('a5dfce34bdb7aa99560e8c0d393a632f', '全部', '1', 'sys_data_scope_1', 'aa294a48211a2deb5c7d76c5e90dc28e', '1,cfd5f62f601817a3b0f38f5ccb1f5128,aa294a48211a2deb5c7d76c5e90dc28e,', 10, b'1', b'1', NULL, '1', '2019-07-14 05:52:44.000', '1', '2019-08-09 11:26:04.740', 7, NULL, '0');
INSERT INTO `sys_dict` VALUES ('aa294a48211a2deb5c7d76c5e90dc28e', '数据范围', '', 'sys_data_scope', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', NULL, '1', '2019-07-14 05:50:08.000', '1', '2019-08-09 11:26:04.741', 16, NULL, '0');
INSERT INTO `sys_dict` VALUES ('b672448a74c1d1a47eb1378e3d8c6dc9', '导入', '5', 'sys_business_type_5', 'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 60, b'1', b'1', NULL, '1', '2019-08-07 16:51:45.855', '1', '2019-08-09 11:26:04.741', 2, NULL, '0');
INSERT INTO `sys_dict` VALUES ('c46ec99af2c1f967bf10cf2c0d96a6c5', '按明细设置', '5', 'sys_data_scope_5', 'aa294a48211a2deb5c7d76c5e90dc28e', '1,cfd5f62f601817a3b0f38f5ccb1f5128,aa294a48211a2deb5c7d76c5e90dc28e,', 50, b'1', b'1', NULL, '1', '2019-07-14 06:01:11.000', '1', '2019-08-09 11:26:04.741', 5, NULL, '0');
INSERT INTO `sys_dict` VALUES ('cfd5f62f601817a3b0f38f5ccb1f5128', '系统数据', 'sys', 'sys', '1', '1,', 30, b'1', b'0', NULL, '1', '2019-07-14 01:13:12.000', '1', '2019-08-11 11:16:52.087', 19, NULL, '0');
INSERT INTO `sys_dict` VALUES ('e0696db908c87ad57a85c6b326348dbd', '业务操作类型', NULL, 'sys_business_type', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', NULL, '1', '2019-08-07 15:33:35.000', '1', '2019-08-09 11:26:04.742', 17, NULL, '0');
INSERT INTO `sys_dict` VALUES ('e26ee931e276a099fb876541ca18756f', '菜单类型', '', 'sys_menu_type', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', NULL, '1', '2019-07-14 06:01:48.000', '1', '2019-08-09 11:26:04.744', 8, NULL, '0');
INSERT INTO `sys_dict` VALUES ('e7891a6351a2e143899849b2955851b2', '锁定', '2', 'sys_business_type_2', 'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 30, b'1', b'1', NULL, '1', '2019-08-07 16:50:32.457', '1', '2019-08-09 11:26:04.746', 2, NULL, '0');
INSERT INTO `sys_dict` VALUES ('ef0368c6fd52ee8f1f4270869da00f18', 'tab按钮', '2', 'sys_menu_type_2', 'e26ee931e276a099fb876541ca18756f', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e26ee931e276a099fb876541ca18756f,', 30, b'1', b'1', NULL, '1', '2019-08-07 13:55:24.531', '1', '2019-08-09 11:26:04.746', 4, NULL, '0');
INSERT INTO `sys_dict` VALUES ('f3592a047c466e348279983336ebaf28', '在线状态', NULL, 'sys_online_status', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', NULL, '1', '2019-08-11 11:16:52.095', '1', '2019-08-11 11:17:50.128', 2, NULL, '0');
INSERT INTO `sys_dict` VALUES ('f83a718756762758707c67db3d271c9d', '手机端用户', '2', 'sys_operate_type_2', '6b8211aef2fec451b0398b19857443a7', '1,cfd5f62f601817a3b0f38f5ccb1f5128,6b8211aef2fec451b0398b19857443a7,', 30, b'1', b'1', NULL, '1', '2019-08-07 16:49:00.766', '1', '2019-08-09 11:26:04.746', 2, NULL, '0');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务ID',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（1允许 0禁止）',
  `available` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态(1-正常，0-锁定)',
  `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_date` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `last_modified_date` datetime(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3),
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `version` int(11) NOT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES ('1', '系统默认（无参）', 'DEFAULT', 'simpleTask.doNoParams', '0/10 * * * * ?', '3', '1', '0', '', '2019-08-14 10:21:36.000', '1', '2019-08-15 16:43:24.833', NULL, 5, '0');
INSERT INTO `sys_job` VALUES ('2', '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '0/15 * * * * ?', '3', '1', '1', '', '2019-08-14 10:21:36.950', '1', '2019-08-15 17:10:56.781', NULL, 11, '0');
INSERT INTO `sys_job` VALUES ('3', '系统默认（多参）', 'DEFAULT', 'simpleTask.doMultipleParams(\'albedo\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '0', '', '2019-08-14 10:21:36.000', '1', '2019-08-15 16:43:22.501', NULL, 3, '0');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `start_time` datetime(3) NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime(3) NULL DEFAULT NULL COMMENT '结束时间',
  `create_time` datetime(3) NULL DEFAULT NULL COMMENT '创建时间',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 504 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------
INSERT INTO `sys_job_log` VALUES (1, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-16 13:57:45.014', '2019-08-16 13:57:45.014', '2019-08-16 13:57:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (2, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-16 13:58:00.015', '2019-08-16 13:58:00.015', '2019-08-16 13:58:00.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (3, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-16 13:58:15.008', '2019-08-16 13:58:15.008', '2019-08-16 13:58:15.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (4, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-16 13:58:30.012', '2019-08-16 13:58:30.013', '2019-08-16 13:58:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (5, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-16 13:58:45.014', '2019-08-16 13:58:45.014', '2019-08-16 13:58:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (6, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-16 13:59:00.021', '2019-08-16 13:59:00.021', '2019-08-16 13:59:00.021', '', NULL);
INSERT INTO `sys_job_log` VALUES (7, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-16 13:59:15.009', '2019-08-16 13:59:15.009', '2019-08-16 13:59:15.009', '', NULL);
INSERT INTO `sys_job_log` VALUES (8, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-16 13:59:30.009', '2019-08-16 13:59:30.009', '2019-08-16 13:59:30.009', '', NULL);
INSERT INTO `sys_job_log` VALUES (9, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：5毫秒', '1', '2019-08-17 10:11:45.020', '2019-08-17 10:11:45.025', '2019-08-17 10:11:45.025', '', NULL);
INSERT INTO `sys_job_log` VALUES (10, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:12:00.022', '2019-08-17 10:12:00.022', '2019-08-17 10:12:00.022', '', NULL);
INSERT INTO `sys_job_log` VALUES (11, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:12:15.011', '2019-08-17 10:12:15.011', '2019-08-17 10:12:15.011', '', NULL);
INSERT INTO `sys_job_log` VALUES (12, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:12:30.010', '2019-08-17 10:12:30.010', '2019-08-17 10:12:30.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (13, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:12:45.008', '2019-08-17 10:12:45.008', '2019-08-17 10:12:45.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (14, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:13:00.203', '2019-08-17 10:13:00.203', '2019-08-17 10:13:00.203', '', NULL);
INSERT INTO `sys_job_log` VALUES (15, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 10:13:15.013', '2019-08-17 10:13:15.014', '2019-08-17 10:13:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (16, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:13:30.013', '2019-08-17 10:13:30.013', '2019-08-17 10:13:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (17, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:13:45.009', '2019-08-17 10:13:45.009', '2019-08-17 10:13:45.009', '', NULL);
INSERT INTO `sys_job_log` VALUES (18, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:14:00.016', '2019-08-17 10:14:00.016', '2019-08-17 10:14:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (19, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:14:15.014', '2019-08-17 10:14:15.014', '2019-08-17 10:14:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (20, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:14:30.006', '2019-08-17 10:14:30.006', '2019-08-17 10:14:30.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (21, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:14:45.015', '2019-08-17 10:14:45.015', '2019-08-17 10:14:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (22, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 10:15:00.015', '2019-08-17 10:15:00.016', '2019-08-17 10:15:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (23, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:15:15.015', '2019-08-17 10:15:15.015', '2019-08-17 10:15:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (24, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:15:30.025', '2019-08-17 10:15:30.025', '2019-08-17 10:15:30.025', '', NULL);
INSERT INTO `sys_job_log` VALUES (25, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:15:45.014', '2019-08-17 10:15:45.014', '2019-08-17 10:15:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (26, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 10:16:00.012', '2019-08-17 10:16:00.013', '2019-08-17 10:16:00.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (27, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:16:15.015', '2019-08-17 10:16:15.015', '2019-08-17 10:16:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (28, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:16:30.006', '2019-08-17 10:16:30.006', '2019-08-17 10:16:30.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (29, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:16:45.016', '2019-08-17 10:16:45.016', '2019-08-17 10:16:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (30, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:17:00.007', '2019-08-17 10:17:00.007', '2019-08-17 10:17:00.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (31, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:17:15.013', '2019-08-17 10:17:15.013', '2019-08-17 10:17:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (32, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:17:30.013', '2019-08-17 10:17:30.013', '2019-08-17 10:17:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (33, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:17:45.015', '2019-08-17 10:17:45.015', '2019-08-17 10:17:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (34, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:18:00.014', '2019-08-17 10:18:00.014', '2019-08-17 10:18:00.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (35, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 10:18:15.009', '2019-08-17 10:18:15.010', '2019-08-17 10:18:15.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (36, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:18:30.013', '2019-08-17 10:18:30.013', '2019-08-17 10:18:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (37, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:18:45.106', '2019-08-17 10:18:45.106', '2019-08-17 10:18:45.106', '', NULL);
INSERT INTO `sys_job_log` VALUES (38, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:19:00.011', '2019-08-17 10:19:00.011', '2019-08-17 10:19:00.011', '', NULL);
INSERT INTO `sys_job_log` VALUES (39, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:19:15.005', '2019-08-17 10:19:15.005', '2019-08-17 10:19:15.005', '', NULL);
INSERT INTO `sys_job_log` VALUES (40, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:19:30.010', '2019-08-17 10:19:30.010', '2019-08-17 10:19:30.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (41, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:19:45.006', '2019-08-17 10:19:45.006', '2019-08-17 10:19:45.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (42, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:20:00.020', '2019-08-17 10:20:00.020', '2019-08-17 10:20:00.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (43, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:20:15.005', '2019-08-17 10:20:15.005', '2019-08-17 10:20:15.005', '', NULL);
INSERT INTO `sys_job_log` VALUES (44, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:20:30.007', '2019-08-17 10:20:30.007', '2019-08-17 10:20:30.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (45, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:20:45.013', '2019-08-17 10:20:45.013', '2019-08-17 10:20:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (46, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:21:00.008', '2019-08-17 10:21:00.008', '2019-08-17 10:21:00.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (47, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:21:15.015', '2019-08-17 10:21:15.015', '2019-08-17 10:21:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (48, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 10:21:30.011', '2019-08-17 10:21:30.012', '2019-08-17 10:21:30.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (49, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:21:45.014', '2019-08-17 10:21:45.014', '2019-08-17 10:21:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (50, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:22:00.013', '2019-08-17 10:22:00.013', '2019-08-17 10:22:00.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (51, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:22:15.012', '2019-08-17 10:22:15.012', '2019-08-17 10:22:15.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (52, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:22:30.013', '2019-08-17 10:22:30.013', '2019-08-17 10:22:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (53, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:22:45.014', '2019-08-17 10:22:45.014', '2019-08-17 10:22:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (54, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:23:00.014', '2019-08-17 10:23:00.014', '2019-08-17 10:23:00.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (55, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:23:15.011', '2019-08-17 10:23:15.011', '2019-08-17 10:23:15.011', '', NULL);
INSERT INTO `sys_job_log` VALUES (56, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:23:30.008', '2019-08-17 10:23:30.008', '2019-08-17 10:23:30.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (57, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:23:45.065', '2019-08-17 10:23:45.065', '2019-08-17 10:23:45.065', '', NULL);
INSERT INTO `sys_job_log` VALUES (58, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:24:00.006', '2019-08-17 10:24:00.006', '2019-08-17 10:24:00.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (59, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:24:15.009', '2019-08-17 10:24:15.009', '2019-08-17 10:24:15.009', '', NULL);
INSERT INTO `sys_job_log` VALUES (60, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:24:30.013', '2019-08-17 10:24:30.013', '2019-08-17 10:24:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (61, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:24:45.010', '2019-08-17 10:24:45.010', '2019-08-17 10:24:45.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (62, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:25:00.008', '2019-08-17 10:25:00.008', '2019-08-17 10:25:00.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (63, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:25:15.013', '2019-08-17 10:25:15.013', '2019-08-17 10:25:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (64, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:25:30.013', '2019-08-17 10:25:30.013', '2019-08-17 10:25:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (65, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:25:45.013', '2019-08-17 10:25:45.013', '2019-08-17 10:25:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (66, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:26:00.011', '2019-08-17 10:26:00.011', '2019-08-17 10:26:00.011', '', NULL);
INSERT INTO `sys_job_log` VALUES (67, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 10:26:15.010', '2019-08-17 10:26:15.011', '2019-08-17 10:26:15.011', '', NULL);
INSERT INTO `sys_job_log` VALUES (68, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 10:26:30.012', '2019-08-17 10:26:30.013', '2019-08-17 10:26:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (69, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:26:45.013', '2019-08-17 10:26:45.013', '2019-08-17 10:26:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (70, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:27:00.015', '2019-08-17 10:27:00.015', '2019-08-17 10:27:00.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (71, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:27:15.006', '2019-08-17 10:27:15.006', '2019-08-17 10:27:15.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (72, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:27:30.062', '2019-08-17 10:27:30.062', '2019-08-17 10:27:30.062', '', NULL);
INSERT INTO `sys_job_log` VALUES (73, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:27:45.008', '2019-08-17 10:27:45.008', '2019-08-17 10:27:45.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (74, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:28:00.013', '2019-08-17 10:28:00.013', '2019-08-17 10:28:00.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (75, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:28:15.113', '2019-08-17 10:28:15.113', '2019-08-17 10:28:15.113', '', NULL);
INSERT INTO `sys_job_log` VALUES (76, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:28:30.005', '2019-08-17 10:28:30.005', '2019-08-17 10:28:30.005', '', NULL);
INSERT INTO `sys_job_log` VALUES (77, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:28:45.010', '2019-08-17 10:28:45.010', '2019-08-17 10:28:45.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (78, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:29:00.012', '2019-08-17 10:29:00.012', '2019-08-17 10:29:00.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (79, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:29:15.006', '2019-08-17 10:29:15.006', '2019-08-17 10:29:15.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (80, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:29:30.052', '2019-08-17 10:29:30.052', '2019-08-17 10:29:30.052', '', NULL);
INSERT INTO `sys_job_log` VALUES (81, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:29:45.012', '2019-08-17 10:29:45.012', '2019-08-17 10:29:45.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (82, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:30:00.013', '2019-08-17 10:30:00.013', '2019-08-17 10:30:00.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (83, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:30:15.013', '2019-08-17 10:30:15.013', '2019-08-17 10:30:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (84, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:30:30.005', '2019-08-17 10:30:30.005', '2019-08-17 10:30:30.005', '', NULL);
INSERT INTO `sys_job_log` VALUES (85, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:30:45.012', '2019-08-17 10:30:45.012', '2019-08-17 10:30:45.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (86, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:31:00.015', '2019-08-17 10:31:00.015', '2019-08-17 10:31:00.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (87, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:31:15.009', '2019-08-17 10:31:15.009', '2019-08-17 10:31:15.009', '', NULL);
INSERT INTO `sys_job_log` VALUES (88, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:31:30.008', '2019-08-17 10:31:30.008', '2019-08-17 10:31:30.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (89, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:31:45.012', '2019-08-17 10:31:45.012', '2019-08-17 10:31:45.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (90, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:32:00.012', '2019-08-17 10:32:00.012', '2019-08-17 10:32:00.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (91, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:32:15.010', '2019-08-17 10:32:15.010', '2019-08-17 10:32:15.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (92, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:32:30.012', '2019-08-17 10:32:30.012', '2019-08-17 10:32:30.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (93, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:32:45.012', '2019-08-17 10:32:45.012', '2019-08-17 10:32:45.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (94, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:33:00.013', '2019-08-17 10:33:00.013', '2019-08-17 10:33:00.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (95, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:33:15.010', '2019-08-17 10:33:15.010', '2019-08-17 10:33:15.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (96, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:33:30.010', '2019-08-17 10:33:30.010', '2019-08-17 10:33:30.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (97, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:33:45.007', '2019-08-17 10:33:45.007', '2019-08-17 10:33:45.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (98, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 10:34:00.013', '2019-08-17 10:34:00.014', '2019-08-17 10:34:00.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (99, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:34:15.010', '2019-08-17 10:34:15.010', '2019-08-17 10:34:15.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (100, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:34:30.005', '2019-08-17 10:34:30.005', '2019-08-17 10:34:30.005', '', NULL);
INSERT INTO `sys_job_log` VALUES (101, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:34:45.006', '2019-08-17 10:34:45.006', '2019-08-17 10:34:45.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (102, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:35:00.009', '2019-08-17 10:35:00.009', '2019-08-17 10:35:00.009', '', NULL);
INSERT INTO `sys_job_log` VALUES (103, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:35:15.005', '2019-08-17 10:35:15.005', '2019-08-17 10:35:15.005', '', NULL);
INSERT INTO `sys_job_log` VALUES (104, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:35:30.010', '2019-08-17 10:35:30.010', '2019-08-17 10:35:30.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (105, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:35:45.012', '2019-08-17 10:35:45.012', '2019-08-17 10:35:45.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (106, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:36:00.008', '2019-08-17 10:36:00.008', '2019-08-17 10:36:00.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (107, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:36:15.013', '2019-08-17 10:36:15.013', '2019-08-17 10:36:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (108, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:36:30.008', '2019-08-17 10:36:30.008', '2019-08-17 10:36:30.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (109, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:36:45.013', '2019-08-17 10:36:45.013', '2019-08-17 10:36:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (110, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:37:00.014', '2019-08-17 10:37:00.014', '2019-08-17 10:37:00.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (111, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:37:15.006', '2019-08-17 10:37:15.006', '2019-08-17 10:37:15.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (112, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:37:30.011', '2019-08-17 10:37:30.011', '2019-08-17 10:37:30.011', '', NULL);
INSERT INTO `sys_job_log` VALUES (113, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:37:45.011', '2019-08-17 10:37:45.011', '2019-08-17 10:37:45.011', '', NULL);
INSERT INTO `sys_job_log` VALUES (114, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:38:00.014', '2019-08-17 10:38:00.014', '2019-08-17 10:38:00.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (115, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:38:15.008', '2019-08-17 10:38:15.008', '2019-08-17 10:38:15.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (116, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:38:30.006', '2019-08-17 10:38:30.006', '2019-08-17 10:38:30.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (117, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:38:45.012', '2019-08-17 10:38:45.012', '2019-08-17 10:38:45.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (118, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:39:00.014', '2019-08-17 10:39:00.014', '2019-08-17 10:39:00.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (119, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:39:15.006', '2019-08-17 10:39:15.006', '2019-08-17 10:39:15.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (120, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:39:30.010', '2019-08-17 10:39:30.010', '2019-08-17 10:39:30.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (121, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:39:45.006', '2019-08-17 10:39:45.006', '2019-08-17 10:39:45.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (122, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:40:00.008', '2019-08-17 10:40:00.008', '2019-08-17 10:40:00.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (123, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 10:40:15.006', '2019-08-17 10:40:15.007', '2019-08-17 10:40:15.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (124, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:40:30.009', '2019-08-17 10:40:30.009', '2019-08-17 10:40:30.009', '', NULL);
INSERT INTO `sys_job_log` VALUES (125, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:40:45.012', '2019-08-17 10:40:45.012', '2019-08-17 10:40:45.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (126, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:41:00.009', '2019-08-17 10:41:00.009', '2019-08-17 10:41:00.009', '', NULL);
INSERT INTO `sys_job_log` VALUES (127, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:41:15.006', '2019-08-17 10:41:15.006', '2019-08-17 10:41:15.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (128, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:41:30.013', '2019-08-17 10:41:30.013', '2019-08-17 10:41:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (129, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:41:45.007', '2019-08-17 10:41:45.007', '2019-08-17 10:41:45.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (130, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:42:00.007', '2019-08-17 10:42:00.007', '2019-08-17 10:42:00.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (131, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:42:15.009', '2019-08-17 10:42:15.009', '2019-08-17 10:42:15.009', '', NULL);
INSERT INTO `sys_job_log` VALUES (132, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:42:30.006', '2019-08-17 10:42:30.006', '2019-08-17 10:42:30.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (133, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:42:45.008', '2019-08-17 10:42:45.008', '2019-08-17 10:42:45.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (134, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:43:00.011', '2019-08-17 10:43:00.011', '2019-08-17 10:43:00.011', '', NULL);
INSERT INTO `sys_job_log` VALUES (135, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:43:15.008', '2019-08-17 10:43:15.008', '2019-08-17 10:43:15.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (136, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:43:30.006', '2019-08-17 10:43:30.006', '2019-08-17 10:43:30.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (137, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:43:45.006', '2019-08-17 10:43:45.006', '2019-08-17 10:43:45.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (138, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 10:44:00.011', '2019-08-17 10:44:00.012', '2019-08-17 10:44:00.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (139, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:44:15.010', '2019-08-17 10:44:15.010', '2019-08-17 10:44:15.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (140, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:44:30.005', '2019-08-17 10:44:30.005', '2019-08-17 10:44:30.005', '', NULL);
INSERT INTO `sys_job_log` VALUES (141, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:44:45.013', '2019-08-17 10:44:45.013', '2019-08-17 10:44:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (142, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:45:00.008', '2019-08-17 10:45:00.008', '2019-08-17 10:45:00.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (143, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:45:15.005', '2019-08-17 10:45:15.005', '2019-08-17 10:45:15.005', '', NULL);
INSERT INTO `sys_job_log` VALUES (144, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:45:30.012', '2019-08-17 10:45:30.012', '2019-08-17 10:45:30.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (145, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:45:45.010', '2019-08-17 10:45:45.010', '2019-08-17 10:45:45.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (146, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:46:00.010', '2019-08-17 10:46:00.010', '2019-08-17 10:46:00.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (147, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:46:15.006', '2019-08-17 10:46:15.006', '2019-08-17 10:46:15.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (148, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:46:30.008', '2019-08-17 10:46:30.008', '2019-08-17 10:46:30.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (149, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:46:45.013', '2019-08-17 10:46:45.013', '2019-08-17 10:46:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (150, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:47:00.013', '2019-08-17 10:47:00.013', '2019-08-17 10:47:00.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (151, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:47:15.013', '2019-08-17 10:47:15.013', '2019-08-17 10:47:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (152, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 10:47:30.012', '2019-08-17 10:47:30.013', '2019-08-17 10:47:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (153, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:47:45.010', '2019-08-17 10:47:45.010', '2019-08-17 10:47:45.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (154, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:48:00.008', '2019-08-17 10:48:00.008', '2019-08-17 10:48:00.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (155, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:48:15.011', '2019-08-17 10:48:15.011', '2019-08-17 10:48:15.011', '', NULL);
INSERT INTO `sys_job_log` VALUES (156, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:48:30.010', '2019-08-17 10:48:30.010', '2019-08-17 10:48:30.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (157, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:48:45.006', '2019-08-17 10:48:45.006', '2019-08-17 10:48:45.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (158, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:49:00.007', '2019-08-17 10:49:00.007', '2019-08-17 10:49:00.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (159, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:49:15.007', '2019-08-17 10:49:15.007', '2019-08-17 10:49:15.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (160, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:49:30.010', '2019-08-17 10:49:30.010', '2019-08-17 10:49:30.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (161, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:49:45.007', '2019-08-17 10:49:45.007', '2019-08-17 10:49:45.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (162, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:50:00.006', '2019-08-17 10:50:00.006', '2019-08-17 10:50:00.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (163, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:50:15.005', '2019-08-17 10:50:15.005', '2019-08-17 10:50:15.005', '', NULL);
INSERT INTO `sys_job_log` VALUES (164, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:50:30.008', '2019-08-17 10:50:30.008', '2019-08-17 10:50:30.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (165, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:50:45.008', '2019-08-17 10:50:45.008', '2019-08-17 10:50:45.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (166, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:51:00.014', '2019-08-17 10:51:00.014', '2019-08-17 10:51:00.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (167, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 10:51:15.009', '2019-08-17 10:51:15.010', '2019-08-17 10:51:15.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (168, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:51:30.007', '2019-08-17 10:51:30.007', '2019-08-17 10:51:30.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (169, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:51:45.005', '2019-08-17 10:51:45.005', '2019-08-17 10:51:45.005', '', NULL);
INSERT INTO `sys_job_log` VALUES (170, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:52:00.008', '2019-08-17 10:52:00.008', '2019-08-17 10:52:00.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (171, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:52:15.011', '2019-08-17 10:52:15.011', '2019-08-17 10:52:15.011', '', NULL);
INSERT INTO `sys_job_log` VALUES (172, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:52:30.006', '2019-08-17 10:52:30.006', '2019-08-17 10:52:30.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (173, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:52:45.008', '2019-08-17 10:52:45.008', '2019-08-17 10:52:45.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (174, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:53:00.011', '2019-08-17 10:53:00.011', '2019-08-17 10:53:00.011', '', NULL);
INSERT INTO `sys_job_log` VALUES (175, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 10:53:15.014', '2019-08-17 10:53:15.015', '2019-08-17 10:53:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (176, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:53:30.006', '2019-08-17 10:53:30.006', '2019-08-17 10:53:30.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (177, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:53:45.007', '2019-08-17 10:53:45.007', '2019-08-17 10:53:45.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (178, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:54:00.007', '2019-08-17 10:54:00.007', '2019-08-17 10:54:00.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (179, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:54:15.008', '2019-08-17 10:54:15.008', '2019-08-17 10:54:15.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (180, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:54:30.038', '2019-08-17 10:54:30.038', '2019-08-17 10:54:30.038', '', NULL);
INSERT INTO `sys_job_log` VALUES (181, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:54:45.060', '2019-08-17 10:54:45.060', '2019-08-17 10:54:45.060', '', NULL);
INSERT INTO `sys_job_log` VALUES (182, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 10:55:00.053', '2019-08-17 10:55:00.054', '2019-08-17 10:55:00.054', '', NULL);
INSERT INTO `sys_job_log` VALUES (183, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 10:55:15.083', '2019-08-17 10:55:15.084', '2019-08-17 10:55:15.084', '', NULL);
INSERT INTO `sys_job_log` VALUES (184, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:55:30.007', '2019-08-17 10:55:30.007', '2019-08-17 10:55:30.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (185, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:55:45.025', '2019-08-17 10:55:45.025', '2019-08-17 10:55:45.025', '', NULL);
INSERT INTO `sys_job_log` VALUES (186, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:56:00.016', '2019-08-17 10:56:00.016', '2019-08-17 10:56:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (187, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:56:15.166', '2019-08-17 10:56:15.166', '2019-08-17 10:56:15.166', '', NULL);
INSERT INTO `sys_job_log` VALUES (188, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:56:30.017', '2019-08-17 10:56:30.017', '2019-08-17 10:56:30.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (189, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:56:45.011', '2019-08-17 10:56:45.011', '2019-08-17 10:56:45.011', '', NULL);
INSERT INTO `sys_job_log` VALUES (190, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:57:00.011', '2019-08-17 10:57:00.011', '2019-08-17 10:57:00.011', '', NULL);
INSERT INTO `sys_job_log` VALUES (191, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:57:15.005', '2019-08-17 10:57:15.005', '2019-08-17 10:57:15.005', '', NULL);
INSERT INTO `sys_job_log` VALUES (192, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 10:57:30.007', '2019-08-17 10:57:30.008', '2019-08-17 10:57:30.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (193, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:57:45.004', '2019-08-17 10:57:45.004', '2019-08-17 10:57:45.004', '', NULL);
INSERT INTO `sys_job_log` VALUES (194, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:58:00.011', '2019-08-17 10:58:00.011', '2019-08-17 10:58:00.011', '', NULL);
INSERT INTO `sys_job_log` VALUES (195, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:58:15.005', '2019-08-17 10:58:15.005', '2019-08-17 10:58:15.005', '', NULL);
INSERT INTO `sys_job_log` VALUES (196, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:58:30.007', '2019-08-17 10:58:30.007', '2019-08-17 10:58:30.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (197, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:58:45.007', '2019-08-17 10:58:45.007', '2019-08-17 10:58:45.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (198, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 10:59:00.007', '2019-08-17 10:59:00.008', '2019-08-17 10:59:00.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (199, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:59:15.031', '2019-08-17 10:59:15.031', '2019-08-17 10:59:15.031', '', NULL);
INSERT INTO `sys_job_log` VALUES (200, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:59:30.011', '2019-08-17 10:59:30.011', '2019-08-17 10:59:30.011', '', NULL);
INSERT INTO `sys_job_log` VALUES (201, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 10:59:45.008', '2019-08-17 10:59:45.008', '2019-08-17 10:59:45.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (202, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:00:00.008', '2019-08-17 11:00:00.008', '2019-08-17 11:00:00.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (203, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:00:15.008', '2019-08-17 11:00:15.008', '2019-08-17 11:00:15.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (204, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:00:30.009', '2019-08-17 11:00:30.009', '2019-08-17 11:00:30.009', '', NULL);
INSERT INTO `sys_job_log` VALUES (205, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:00:45.009', '2019-08-17 11:00:45.009', '2019-08-17 11:00:45.009', '', NULL);
INSERT INTO `sys_job_log` VALUES (206, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:01:00.007', '2019-08-17 11:01:00.007', '2019-08-17 11:01:00.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (207, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:01:15.005', '2019-08-17 11:01:15.005', '2019-08-17 11:01:15.005', '', NULL);
INSERT INTO `sys_job_log` VALUES (208, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:01:30.008', '2019-08-17 11:01:30.008', '2019-08-17 11:01:30.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (209, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:01:45.092', '2019-08-17 11:01:45.092', '2019-08-17 11:01:45.092', '', NULL);
INSERT INTO `sys_job_log` VALUES (210, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:02:00.013', '2019-08-17 11:02:00.013', '2019-08-17 11:02:00.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (211, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:02:15.017', '2019-08-17 11:02:15.017', '2019-08-17 11:02:15.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (212, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:02:30.011', '2019-08-17 11:02:30.011', '2019-08-17 11:02:30.011', '', NULL);
INSERT INTO `sys_job_log` VALUES (213, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:02:45.089', '2019-08-17 11:02:45.089', '2019-08-17 11:02:45.089', '', NULL);
INSERT INTO `sys_job_log` VALUES (214, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:03:00.015', '2019-08-17 11:03:00.015', '2019-08-17 11:03:00.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (215, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:03:15.197', '2019-08-17 11:03:15.197', '2019-08-17 11:03:15.197', '', NULL);
INSERT INTO `sys_job_log` VALUES (216, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:03:30.006', '2019-08-17 11:03:30.006', '2019-08-17 11:03:30.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (217, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:03:45.009', '2019-08-17 11:03:45.009', '2019-08-17 11:03:45.009', '', NULL);
INSERT INTO `sys_job_log` VALUES (218, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 11:04:00.014', '2019-08-17 11:04:00.015', '2019-08-17 11:04:00.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (219, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 11:04:15.009', '2019-08-17 11:04:15.010', '2019-08-17 11:04:15.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (220, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:04:30.009', '2019-08-17 11:04:30.009', '2019-08-17 11:04:30.009', '', NULL);
INSERT INTO `sys_job_log` VALUES (221, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:04:45.005', '2019-08-17 11:04:45.005', '2019-08-17 11:04:45.005', '', NULL);
INSERT INTO `sys_job_log` VALUES (222, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:05:00.018', '2019-08-17 11:05:00.018', '2019-08-17 11:05:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (223, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:05:15.010', '2019-08-17 11:05:15.010', '2019-08-17 11:05:15.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (224, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:05:30.007', '2019-08-17 11:05:30.007', '2019-08-17 11:05:30.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (225, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:05:45.005', '2019-08-17 11:05:45.005', '2019-08-17 11:05:45.005', '', NULL);
INSERT INTO `sys_job_log` VALUES (226, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 11:06:00.010', '2019-08-17 11:06:00.011', '2019-08-17 11:06:00.011', '', NULL);
INSERT INTO `sys_job_log` VALUES (227, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:06:15.035', '2019-08-17 11:06:15.035', '2019-08-17 11:06:15.036', '', NULL);
INSERT INTO `sys_job_log` VALUES (228, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:06:30.008', '2019-08-17 11:06:30.008', '2019-08-17 11:06:30.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (229, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:06:45.007', '2019-08-17 11:06:45.007', '2019-08-17 11:06:45.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (230, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:07:00.015', '2019-08-17 11:07:00.015', '2019-08-17 11:07:00.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (231, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 11:07:15.012', '2019-08-17 11:07:15.013', '2019-08-17 11:07:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (232, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:07:30.014', '2019-08-17 11:07:30.014', '2019-08-17 11:07:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (233, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 11:07:45.015', '2019-08-17 11:07:45.016', '2019-08-17 11:07:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (234, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 11:08:00.012', '2019-08-17 11:08:00.013', '2019-08-17 11:08:00.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (235, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:08:15.005', '2019-08-17 11:08:15.005', '2019-08-17 11:08:15.005', '', NULL);
INSERT INTO `sys_job_log` VALUES (236, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:08:30.013', '2019-08-17 11:08:30.013', '2019-08-17 11:08:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (237, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:08:45.013', '2019-08-17 11:08:45.013', '2019-08-17 11:08:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (238, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:09:00.037', '2019-08-17 11:09:00.037', '2019-08-17 11:09:00.037', '', NULL);
INSERT INTO `sys_job_log` VALUES (239, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:09:15.017', '2019-08-17 11:09:15.017', '2019-08-17 11:09:15.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (240, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:09:30.042', '2019-08-17 11:09:30.042', '2019-08-17 11:09:30.042', '', NULL);
INSERT INTO `sys_job_log` VALUES (241, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:09:45.091', '2019-08-17 11:09:45.091', '2019-08-17 11:09:45.091', '', NULL);
INSERT INTO `sys_job_log` VALUES (242, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 11:10:00.123', '2019-08-17 11:10:00.124', '2019-08-17 11:10:00.124', '', NULL);
INSERT INTO `sys_job_log` VALUES (243, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:10:15.013', '2019-08-17 11:10:15.013', '2019-08-17 11:10:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (244, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:10:30.075', '2019-08-17 11:10:30.075', '2019-08-17 11:10:30.075', '', NULL);
INSERT INTO `sys_job_log` VALUES (245, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:10:45.034', '2019-08-17 11:10:45.034', '2019-08-17 11:10:45.034', '', NULL);
INSERT INTO `sys_job_log` VALUES (246, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:11:00.018', '2019-08-17 11:11:00.018', '2019-08-17 11:11:00.018', '', NULL);
INSERT INTO `sys_job_log` VALUES (247, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:11:15.014', '2019-08-17 11:11:15.014', '2019-08-17 11:11:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (248, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:11:30.010', '2019-08-17 11:11:30.010', '2019-08-17 11:11:30.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (249, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:11:45.007', '2019-08-17 11:11:45.007', '2019-08-17 11:11:45.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (250, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:12:00.009', '2019-08-17 11:12:00.009', '2019-08-17 11:12:00.009', '', NULL);
INSERT INTO `sys_job_log` VALUES (251, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:12:15.011', '2019-08-17 11:12:15.011', '2019-08-17 11:12:15.011', '', NULL);
INSERT INTO `sys_job_log` VALUES (252, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:12:30.007', '2019-08-17 11:12:30.007', '2019-08-17 11:12:30.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (253, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:12:45.010', '2019-08-17 11:12:45.010', '2019-08-17 11:12:45.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (254, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:13:00.006', '2019-08-17 11:13:00.006', '2019-08-17 11:13:00.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (255, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:13:15.005', '2019-08-17 11:13:15.005', '2019-08-17 11:13:15.005', '', NULL);
INSERT INTO `sys_job_log` VALUES (256, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：4毫秒', '1', '2019-08-17 11:45:06.408', '2019-08-17 11:45:06.412', '2019-08-17 11:45:06.412', '', NULL);
INSERT INTO `sys_job_log` VALUES (257, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:45:15.019', '2019-08-17 11:45:15.019', '2019-08-17 11:45:15.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (258, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:45:30.008', '2019-08-17 11:45:30.008', '2019-08-17 11:45:30.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (259, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 11:45:45.008', '2019-08-17 11:45:45.009', '2019-08-17 11:45:45.009', '', NULL);
INSERT INTO `sys_job_log` VALUES (260, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:46:00.010', '2019-08-17 11:46:00.010', '2019-08-17 11:46:00.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (261, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:46:15.007', '2019-08-17 11:46:15.007', '2019-08-17 11:46:15.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (262, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:46:30.008', '2019-08-17 11:46:30.008', '2019-08-17 11:46:30.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (263, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:46:45.008', '2019-08-17 11:46:45.008', '2019-08-17 11:46:45.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (264, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:47:00.009', '2019-08-17 11:47:00.009', '2019-08-17 11:47:00.009', '', NULL);
INSERT INTO `sys_job_log` VALUES (265, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:47:15.006', '2019-08-17 11:47:15.006', '2019-08-17 11:47:15.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (266, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:47:30.009', '2019-08-17 11:47:30.009', '2019-08-17 11:47:30.009', '', NULL);
INSERT INTO `sys_job_log` VALUES (267, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:47:45.005', '2019-08-17 11:47:45.005', '2019-08-17 11:47:45.005', '', NULL);
INSERT INTO `sys_job_log` VALUES (268, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:48:00.009', '2019-08-17 11:48:00.009', '2019-08-17 11:48:00.009', '', NULL);
INSERT INTO `sys_job_log` VALUES (269, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:48:15.007', '2019-08-17 11:48:15.007', '2019-08-17 11:48:15.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (270, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:48:30.005', '2019-08-17 11:48:30.005', '2019-08-17 11:48:30.005', '', NULL);
INSERT INTO `sys_job_log` VALUES (271, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:48:45.010', '2019-08-17 11:48:45.010', '2019-08-17 11:48:45.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (272, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 11:49:00.006', '2019-08-17 11:49:00.007', '2019-08-17 11:49:00.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (273, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:49:15.007', '2019-08-17 11:49:15.007', '2019-08-17 11:49:15.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (274, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:49:30.006', '2019-08-17 11:49:30.006', '2019-08-17 11:49:30.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (275, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:49:45.006', '2019-08-17 11:49:45.006', '2019-08-17 11:49:45.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (276, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:50:00.007', '2019-08-17 11:50:00.007', '2019-08-17 11:50:00.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (277, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:50:15.008', '2019-08-17 11:50:15.008', '2019-08-17 11:50:15.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (278, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:50:30.006', '2019-08-17 11:50:30.006', '2019-08-17 11:50:30.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (279, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:50:45.007', '2019-08-17 11:50:45.007', '2019-08-17 11:50:45.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (280, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:51:00.008', '2019-08-17 11:51:00.008', '2019-08-17 11:51:00.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (281, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:51:15.006', '2019-08-17 11:51:15.006', '2019-08-17 11:51:15.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (282, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:51:30.007', '2019-08-17 11:51:30.007', '2019-08-17 11:51:30.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (283, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 11:51:45.006', '2019-08-17 11:51:45.007', '2019-08-17 11:51:45.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (284, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:52:00.008', '2019-08-17 11:52:00.008', '2019-08-17 11:52:00.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (285, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:52:15.005', '2019-08-17 11:52:15.005', '2019-08-17 11:52:15.005', '', NULL);
INSERT INTO `sys_job_log` VALUES (286, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 11:52:30.006', '2019-08-17 11:52:30.007', '2019-08-17 11:52:30.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (287, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:52:45.011', '2019-08-17 11:52:45.011', '2019-08-17 11:52:45.011', '', NULL);
INSERT INTO `sys_job_log` VALUES (288, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:53:00.006', '2019-08-17 11:53:00.006', '2019-08-17 11:53:00.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (289, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:53:15.006', '2019-08-17 11:53:15.006', '2019-08-17 11:53:15.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (290, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:53:30.007', '2019-08-17 11:53:30.007', '2019-08-17 11:53:30.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (291, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:53:45.007', '2019-08-17 11:53:45.007', '2019-08-17 11:53:45.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (292, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:54:00.006', '2019-08-17 11:54:00.006', '2019-08-17 11:54:00.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (293, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:54:15.070', '2019-08-17 11:54:15.070', '2019-08-17 11:54:15.070', '', NULL);
INSERT INTO `sys_job_log` VALUES (294, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:54:30.007', '2019-08-17 11:54:30.007', '2019-08-17 11:54:30.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (295, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:54:45.006', '2019-08-17 11:54:45.006', '2019-08-17 11:54:45.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (296, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 11:55:00.007', '2019-08-17 11:55:00.008', '2019-08-17 11:55:00.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (297, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:55:15.008', '2019-08-17 11:55:15.008', '2019-08-17 11:55:15.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (298, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:55:30.006', '2019-08-17 11:55:30.006', '2019-08-17 11:55:30.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (299, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:55:45.006', '2019-08-17 11:55:45.006', '2019-08-17 11:55:45.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (300, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:56:00.006', '2019-08-17 11:56:00.006', '2019-08-17 11:56:00.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (301, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:56:15.007', '2019-08-17 11:56:15.007', '2019-08-17 11:56:15.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (302, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:56:30.007', '2019-08-17 11:56:30.007', '2019-08-17 11:56:30.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (303, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:56:45.006', '2019-08-17 11:56:45.006', '2019-08-17 11:56:45.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (304, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:57:00.005', '2019-08-17 11:57:00.005', '2019-08-17 11:57:00.005', '', NULL);
INSERT INTO `sys_job_log` VALUES (305, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:57:15.007', '2019-08-17 11:57:15.007', '2019-08-17 11:57:15.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (306, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:57:30.006', '2019-08-17 11:57:30.006', '2019-08-17 11:57:30.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (307, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:57:45.007', '2019-08-17 11:57:45.007', '2019-08-17 11:57:45.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (308, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:58:00.006', '2019-08-17 11:58:00.006', '2019-08-17 11:58:00.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (309, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:58:15.006', '2019-08-17 11:58:15.006', '2019-08-17 11:58:15.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (310, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:58:30.043', '2019-08-17 11:58:30.043', '2019-08-17 11:58:30.043', '', NULL);
INSERT INTO `sys_job_log` VALUES (311, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:58:45.069', '2019-08-17 11:58:45.069', '2019-08-17 11:58:45.069', '', NULL);
INSERT INTO `sys_job_log` VALUES (312, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:59:00.006', '2019-08-17 11:59:00.006', '2019-08-17 11:59:00.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (313, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:59:15.007', '2019-08-17 11:59:15.007', '2019-08-17 11:59:15.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (314, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:59:30.007', '2019-08-17 11:59:30.007', '2019-08-17 11:59:30.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (315, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 11:59:45.006', '2019-08-17 11:59:45.006', '2019-08-17 11:59:45.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (316, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 12:00:00.005', '2019-08-17 12:00:00.006', '2019-08-17 12:00:00.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (317, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 12:00:15.007', '2019-08-17 12:00:15.007', '2019-08-17 12:00:15.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (318, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 12:00:30.008', '2019-08-17 12:00:30.008', '2019-08-17 12:00:30.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (319, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 12:00:45.008', '2019-08-17 12:00:45.008', '2019-08-17 12:00:45.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (320, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 12:01:00.006', '2019-08-17 12:01:00.006', '2019-08-17 12:01:00.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (321, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 12:01:15.007', '2019-08-17 12:01:15.007', '2019-08-17 12:01:15.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (322, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 12:01:30.008', '2019-08-17 12:01:30.008', '2019-08-17 12:01:30.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (323, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 12:01:45.007', '2019-08-17 12:01:45.007', '2019-08-17 12:01:45.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (324, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 12:02:00.005', '2019-08-17 12:02:00.005', '2019-08-17 12:02:00.005', '', NULL);
INSERT INTO `sys_job_log` VALUES (325, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 12:02:15.005', '2019-08-17 12:02:15.005', '2019-08-17 12:02:15.005', '', NULL);
INSERT INTO `sys_job_log` VALUES (326, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 12:02:30.020', '2019-08-17 12:02:30.021', '2019-08-17 12:02:30.021', '', NULL);
INSERT INTO `sys_job_log` VALUES (327, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 12:02:45.010', '2019-08-17 12:02:45.010', '2019-08-17 12:02:45.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (328, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 12:03:00.047', '2019-08-17 12:03:00.047', '2019-08-17 12:03:00.047', '', NULL);
INSERT INTO `sys_job_log` VALUES (329, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 12:03:15.020', '2019-08-17 12:03:15.020', '2019-08-17 12:03:15.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (330, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 12:03:30.009', '2019-08-17 12:03:30.009', '2019-08-17 12:03:30.009', '', NULL);
INSERT INTO `sys_job_log` VALUES (331, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 12:03:45.006', '2019-08-17 12:03:45.006', '2019-08-17 12:03:45.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (332, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 12:04:00.014', '2019-08-17 12:04:00.014', '2019-08-17 12:04:00.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (333, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 12:04:15.014', '2019-08-17 12:04:15.014', '2019-08-17 12:04:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (334, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 12:04:30.006', '2019-08-17 12:04:30.006', '2019-08-17 12:04:30.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (335, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 12:04:45.006', '2019-08-17 12:04:45.006', '2019-08-17 12:04:45.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (336, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 12:05:00.015', '2019-08-17 12:05:00.015', '2019-08-17 12:05:00.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (337, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 12:05:15.006', '2019-08-17 12:05:15.006', '2019-08-17 12:05:15.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (338, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 12:05:30.081', '2019-08-17 12:05:30.081', '2019-08-17 12:05:30.081', '', NULL);
INSERT INTO `sys_job_log` VALUES (339, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 12:05:45.050', '2019-08-17 12:05:45.050', '2019-08-17 12:05:45.050', '', NULL);
INSERT INTO `sys_job_log` VALUES (340, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 12:06:00.007', '2019-08-17 12:06:00.008', '2019-08-17 12:06:00.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (341, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 12:06:15.005', '2019-08-17 12:06:15.005', '2019-08-17 12:06:15.005', '', NULL);
INSERT INTO `sys_job_log` VALUES (342, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 12:06:30.008', '2019-08-17 12:06:30.008', '2019-08-17 12:06:30.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (343, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：3毫秒', '1', '2019-08-17 13:35:00.434', '2019-08-17 13:35:00.437', '2019-08-17 13:35:00.437', '', NULL);
INSERT INTO `sys_job_log` VALUES (344, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:35:15.035', '2019-08-17 13:35:15.035', '2019-08-17 13:35:15.035', '', NULL);
INSERT INTO `sys_job_log` VALUES (345, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:35:30.019', '2019-08-17 13:35:30.019', '2019-08-17 13:35:30.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (346, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:35:45.012', '2019-08-17 13:35:45.012', '2019-08-17 13:35:45.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (347, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:36:00.012', '2019-08-17 13:36:00.012', '2019-08-17 13:36:00.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (348, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:36:15.015', '2019-08-17 13:36:15.015', '2019-08-17 13:36:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (349, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 13:36:30.009', '2019-08-17 13:36:30.010', '2019-08-17 13:36:30.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (350, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:36:45.014', '2019-08-17 13:36:45.014', '2019-08-17 13:36:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (351, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:37:00.021', '2019-08-17 13:37:00.021', '2019-08-17 13:37:00.021', '', NULL);
INSERT INTO `sys_job_log` VALUES (352, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:37:15.008', '2019-08-17 13:37:15.008', '2019-08-17 13:37:15.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (353, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:37:30.005', '2019-08-17 13:37:30.005', '2019-08-17 13:37:30.005', '', NULL);
INSERT INTO `sys_job_log` VALUES (354, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:37:45.020', '2019-08-17 13:37:45.020', '2019-08-17 13:37:45.020', '', NULL);
INSERT INTO `sys_job_log` VALUES (355, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:38:00.008', '2019-08-17 13:38:00.008', '2019-08-17 13:38:00.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (356, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 13:38:15.015', '2019-08-17 13:38:15.016', '2019-08-17 13:38:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (357, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:38:30.007', '2019-08-17 13:38:30.007', '2019-08-17 13:38:30.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (358, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 13:38:45.027', '2019-08-17 13:38:45.028', '2019-08-17 13:38:45.028', '', NULL);
INSERT INTO `sys_job_log` VALUES (359, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 13:39:00.016', '2019-08-17 13:39:00.017', '2019-08-17 13:39:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (360, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:39:15.013', '2019-08-17 13:39:15.013', '2019-08-17 13:39:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (361, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 13:39:30.014', '2019-08-17 13:39:30.015', '2019-08-17 13:39:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (362, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:39:45.010', '2019-08-17 13:39:45.010', '2019-08-17 13:39:45.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (363, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:40:00.015', '2019-08-17 13:40:00.015', '2019-08-17 13:40:00.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (364, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:40:15.012', '2019-08-17 13:40:15.012', '2019-08-17 13:40:15.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (365, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:40:30.014', '2019-08-17 13:40:30.014', '2019-08-17 13:40:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (366, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 13:40:45.014', '2019-08-17 13:40:45.015', '2019-08-17 13:40:45.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (367, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:41:00.008', '2019-08-17 13:41:00.008', '2019-08-17 13:41:00.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (368, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:41:15.006', '2019-08-17 13:41:15.006', '2019-08-17 13:41:15.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (369, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:41:30.007', '2019-08-17 13:41:30.007', '2019-08-17 13:41:30.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (370, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:41:45.008', '2019-08-17 13:41:45.008', '2019-08-17 13:41:45.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (371, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:42:00.015', '2019-08-17 13:42:00.015', '2019-08-17 13:42:00.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (372, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:42:15.007', '2019-08-17 13:42:15.007', '2019-08-17 13:42:15.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (373, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:42:30.009', '2019-08-17 13:42:30.009', '2019-08-17 13:42:30.009', '', NULL);
INSERT INTO `sys_job_log` VALUES (374, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:42:45.011', '2019-08-17 13:42:45.011', '2019-08-17 13:42:45.011', '', NULL);
INSERT INTO `sys_job_log` VALUES (375, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:43:00.007', '2019-08-17 13:43:00.007', '2019-08-17 13:43:00.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (376, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:43:15.007', '2019-08-17 13:43:15.007', '2019-08-17 13:43:15.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (377, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:43:30.012', '2019-08-17 13:43:30.012', '2019-08-17 13:43:30.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (378, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:43:45.010', '2019-08-17 13:43:45.010', '2019-08-17 13:43:45.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (379, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:44:00.010', '2019-08-17 13:44:00.010', '2019-08-17 13:44:00.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (380, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:44:15.008', '2019-08-17 13:44:15.008', '2019-08-17 13:44:15.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (381, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:44:30.007', '2019-08-17 13:44:30.007', '2019-08-17 13:44:30.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (382, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:44:45.007', '2019-08-17 13:44:45.007', '2019-08-17 13:44:45.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (383, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:45:00.009', '2019-08-17 13:45:00.009', '2019-08-17 13:45:00.009', '', NULL);
INSERT INTO `sys_job_log` VALUES (384, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 13:45:15.013', '2019-08-17 13:45:15.014', '2019-08-17 13:45:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (385, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:45:30.007', '2019-08-17 13:45:30.007', '2019-08-17 13:45:30.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (386, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:45:45.012', '2019-08-17 13:45:45.012', '2019-08-17 13:45:45.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (387, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:46:00.008', '2019-08-17 13:46:00.008', '2019-08-17 13:46:00.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (388, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:46:15.016', '2019-08-17 13:46:15.016', '2019-08-17 13:46:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (389, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:46:30.014', '2019-08-17 13:46:30.014', '2019-08-17 13:46:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (390, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 13:46:45.015', '2019-08-17 13:46:45.016', '2019-08-17 13:46:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (391, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:47:00.014', '2019-08-17 13:47:00.014', '2019-08-17 13:47:00.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (392, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:47:15.161', '2019-08-17 13:47:15.161', '2019-08-17 13:47:15.161', '', NULL);
INSERT INTO `sys_job_log` VALUES (393, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:47:30.013', '2019-08-17 13:47:30.013', '2019-08-17 13:47:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (394, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:47:45.007', '2019-08-17 13:47:45.007', '2019-08-17 13:47:45.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (395, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 13:48:00.014', '2019-08-17 13:48:00.015', '2019-08-17 13:48:00.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (396, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:48:15.014', '2019-08-17 13:48:15.014', '2019-08-17 13:48:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (397, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:48:30.019', '2019-08-17 13:48:30.019', '2019-08-17 13:48:30.019', '', NULL);
INSERT INTO `sys_job_log` VALUES (398, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:48:45.014', '2019-08-17 13:48:45.014', '2019-08-17 13:48:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (399, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:49:00.007', '2019-08-17 13:49:00.007', '2019-08-17 13:49:00.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (400, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 13:49:15.013', '2019-08-17 13:49:15.014', '2019-08-17 13:49:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (401, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:49:30.012', '2019-08-17 13:49:30.012', '2019-08-17 13:49:30.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (402, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:49:45.012', '2019-08-17 13:49:45.012', '2019-08-17 13:49:45.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (403, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:50:00.014', '2019-08-17 13:50:00.014', '2019-08-17 13:50:00.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (404, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:50:15.007', '2019-08-17 13:50:15.007', '2019-08-17 13:50:15.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (405, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:50:30.007', '2019-08-17 13:50:30.007', '2019-08-17 13:50:30.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (406, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:50:45.006', '2019-08-17 13:50:45.006', '2019-08-17 13:50:45.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (407, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:51:00.014', '2019-08-17 13:51:00.014', '2019-08-17 13:51:00.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (408, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:51:15.007', '2019-08-17 13:51:15.007', '2019-08-17 13:51:15.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (409, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:51:30.012', '2019-08-17 13:51:30.012', '2019-08-17 13:51:30.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (410, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:51:45.014', '2019-08-17 13:51:45.014', '2019-08-17 13:51:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (411, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:52:00.007', '2019-08-17 13:52:00.007', '2019-08-17 13:52:00.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (412, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:52:15.016', '2019-08-17 13:52:15.016', '2019-08-17 13:52:15.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (413, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:52:30.012', '2019-08-17 13:52:30.012', '2019-08-17 13:52:30.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (414, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:52:45.009', '2019-08-17 13:52:45.009', '2019-08-17 13:52:45.009', '', NULL);
INSERT INTO `sys_job_log` VALUES (415, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:53:00.008', '2019-08-17 13:53:00.008', '2019-08-17 13:53:00.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (416, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:53:15.012', '2019-08-17 13:53:15.012', '2019-08-17 13:53:15.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (417, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:53:30.009', '2019-08-17 13:53:30.009', '2019-08-17 13:53:30.009', '', NULL);
INSERT INTO `sys_job_log` VALUES (418, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 13:53:45.015', '2019-08-17 13:53:45.016', '2019-08-17 13:53:45.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (419, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:54:00.015', '2019-08-17 13:54:00.015', '2019-08-17 13:54:00.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (420, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:54:15.007', '2019-08-17 13:54:15.007', '2019-08-17 13:54:15.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (421, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 13:54:30.011', '2019-08-17 13:54:30.012', '2019-08-17 13:54:30.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (422, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:54:45.007', '2019-08-17 13:54:45.007', '2019-08-17 13:54:45.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (423, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:55:00.015', '2019-08-17 13:55:00.015', '2019-08-17 13:55:00.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (424, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:55:15.008', '2019-08-17 13:55:15.008', '2019-08-17 13:55:15.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (425, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:55:30.013', '2019-08-17 13:55:30.013', '2019-08-17 13:55:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (426, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:55:45.010', '2019-08-17 13:55:45.010', '2019-08-17 13:55:45.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (427, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:56:00.013', '2019-08-17 13:56:00.013', '2019-08-17 13:56:00.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (428, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:56:15.013', '2019-08-17 13:56:15.013', '2019-08-17 13:56:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (429, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:56:30.007', '2019-08-17 13:56:30.007', '2019-08-17 13:56:30.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (430, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:56:45.005', '2019-08-17 13:56:45.005', '2019-08-17 13:56:45.005', '', NULL);
INSERT INTO `sys_job_log` VALUES (431, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 13:57:00.014', '2019-08-17 13:57:00.015', '2019-08-17 13:57:00.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (432, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:57:15.012', '2019-08-17 13:57:15.012', '2019-08-17 13:57:15.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (433, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 13:57:30.012', '2019-08-17 13:57:30.013', '2019-08-17 13:57:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (434, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:57:45.080', '2019-08-17 13:57:45.080', '2019-08-17 13:57:45.080', '', NULL);
INSERT INTO `sys_job_log` VALUES (435, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:58:00.007', '2019-08-17 13:58:00.007', '2019-08-17 13:58:00.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (436, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:58:15.012', '2019-08-17 13:58:15.012', '2019-08-17 13:58:15.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (437, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:58:30.015', '2019-08-17 13:58:30.015', '2019-08-17 13:58:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (438, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:58:45.005', '2019-08-17 13:58:45.005', '2019-08-17 13:58:45.005', '', NULL);
INSERT INTO `sys_job_log` VALUES (439, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:59:00.009', '2019-08-17 13:59:00.009', '2019-08-17 13:59:00.009', '', NULL);
INSERT INTO `sys_job_log` VALUES (440, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 13:59:15.012', '2019-08-17 13:59:15.013', '2019-08-17 13:59:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (441, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:59:30.006', '2019-08-17 13:59:30.006', '2019-08-17 13:59:30.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (442, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 13:59:45.012', '2019-08-17 13:59:45.012', '2019-08-17 13:59:45.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (443, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:00:00.006', '2019-08-17 14:00:00.006', '2019-08-17 14:00:00.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (444, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:00:15.007', '2019-08-17 14:00:15.007', '2019-08-17 14:00:15.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (445, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 14:00:30.011', '2019-08-17 14:00:30.012', '2019-08-17 14:00:30.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (446, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:00:45.013', '2019-08-17 14:00:45.013', '2019-08-17 14:00:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (447, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:01:00.085', '2019-08-17 14:01:00.085', '2019-08-17 14:01:00.085', '', NULL);
INSERT INTO `sys_job_log` VALUES (448, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 14:01:15.014', '2019-08-17 14:01:15.015', '2019-08-17 14:01:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (449, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:01:30.013', '2019-08-17 14:01:30.013', '2019-08-17 14:01:30.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (450, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:01:45.009', '2019-08-17 14:01:45.009', '2019-08-17 14:01:45.009', '', NULL);
INSERT INTO `sys_job_log` VALUES (451, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 14:02:00.014', '2019-08-17 14:02:00.015', '2019-08-17 14:02:00.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (452, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 14:02:15.013', '2019-08-17 14:02:15.014', '2019-08-17 14:02:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (453, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:02:30.012', '2019-08-17 14:02:30.012', '2019-08-17 14:02:30.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (454, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:02:45.013', '2019-08-17 14:02:45.013', '2019-08-17 14:02:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (455, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 14:03:00.079', '2019-08-17 14:03:00.080', '2019-08-17 14:03:00.080', '', NULL);
INSERT INTO `sys_job_log` VALUES (456, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 14:03:15.006', '2019-08-17 14:03:15.007', '2019-08-17 14:03:15.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (457, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:03:30.007', '2019-08-17 14:03:30.007', '2019-08-17 14:03:30.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (458, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:03:45.012', '2019-08-17 14:03:45.012', '2019-08-17 14:03:45.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (459, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 14:04:00.015', '2019-08-17 14:04:00.016', '2019-08-17 14:04:00.016', '', NULL);
INSERT INTO `sys_job_log` VALUES (460, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:04:15.014', '2019-08-17 14:04:15.014', '2019-08-17 14:04:15.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (461, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:04:30.011', '2019-08-17 14:04:30.011', '2019-08-17 14:04:30.011', '', NULL);
INSERT INTO `sys_job_log` VALUES (462, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:04:45.006', '2019-08-17 14:04:45.006', '2019-08-17 14:04:45.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (463, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:05:00.148', '2019-08-17 14:05:00.148', '2019-08-17 14:05:00.148', '', NULL);
INSERT INTO `sys_job_log` VALUES (464, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 14:05:15.123', '2019-08-17 14:05:15.124', '2019-08-17 14:05:15.124', '', NULL);
INSERT INTO `sys_job_log` VALUES (465, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:05:30.006', '2019-08-17 14:05:30.006', '2019-08-17 14:05:30.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (466, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:05:45.014', '2019-08-17 14:05:45.014', '2019-08-17 14:05:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (467, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 14:06:00.014', '2019-08-17 14:06:00.015', '2019-08-17 14:06:00.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (468, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:06:15.007', '2019-08-17 14:06:15.007', '2019-08-17 14:06:15.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (469, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:06:30.005', '2019-08-17 14:06:30.005', '2019-08-17 14:06:30.005', '', NULL);
INSERT INTO `sys_job_log` VALUES (470, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:06:45.014', '2019-08-17 14:06:45.014', '2019-08-17 14:06:45.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (471, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:07:00.014', '2019-08-17 14:07:00.014', '2019-08-17 14:07:00.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (472, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:07:15.013', '2019-08-17 14:07:15.013', '2019-08-17 14:07:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (473, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 14:07:30.013', '2019-08-17 14:07:30.014', '2019-08-17 14:07:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (474, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:07:45.012', '2019-08-17 14:07:45.012', '2019-08-17 14:07:45.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (475, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:08:00.015', '2019-08-17 14:08:00.015', '2019-08-17 14:08:00.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (476, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:08:15.015', '2019-08-17 14:08:15.015', '2019-08-17 14:08:15.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (477, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:08:30.014', '2019-08-17 14:08:30.014', '2019-08-17 14:08:30.014', '', NULL);
INSERT INTO `sys_job_log` VALUES (478, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:08:45.012', '2019-08-17 14:08:45.012', '2019-08-17 14:08:45.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (479, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:09:00.081', '2019-08-17 14:09:00.081', '2019-08-17 14:09:00.081', '', NULL);
INSERT INTO `sys_job_log` VALUES (480, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:09:15.012', '2019-08-17 14:09:15.012', '2019-08-17 14:09:15.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (481, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:09:30.054', '2019-08-17 14:09:30.054', '2019-08-17 14:09:30.054', '', NULL);
INSERT INTO `sys_job_log` VALUES (482, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:09:45.027', '2019-08-17 14:09:45.027', '2019-08-17 14:09:45.027', '', NULL);
INSERT INTO `sys_job_log` VALUES (483, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:10:00.006', '2019-08-17 14:10:00.006', '2019-08-17 14:10:00.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (484, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:10:15.011', '2019-08-17 14:10:15.011', '2019-08-17 14:10:15.011', '', NULL);
INSERT INTO `sys_job_log` VALUES (485, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:10:30.015', '2019-08-17 14:10:30.015', '2019-08-17 14:10:30.015', '', NULL);
INSERT INTO `sys_job_log` VALUES (486, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:10:45.006', '2019-08-17 14:10:45.006', '2019-08-17 14:10:45.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (487, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:11:00.010', '2019-08-17 14:11:00.010', '2019-08-17 14:11:00.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (488, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：1毫秒', '1', '2019-08-17 14:11:15.004', '2019-08-17 14:11:15.005', '2019-08-17 14:11:15.005', '', NULL);
INSERT INTO `sys_job_log` VALUES (489, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:11:30.007', '2019-08-17 14:11:30.007', '2019-08-17 14:11:30.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (490, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:11:45.013', '2019-08-17 14:11:45.013', '2019-08-17 14:11:45.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (491, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:12:00.007', '2019-08-17 14:12:00.007', '2019-08-17 14:12:00.007', '', NULL);
INSERT INTO `sys_job_log` VALUES (492, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:12:15.013', '2019-08-17 14:12:15.013', '2019-08-17 14:12:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (493, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:12:30.008', '2019-08-17 14:12:30.008', '2019-08-17 14:12:30.008', '', NULL);
INSERT INTO `sys_job_log` VALUES (494, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:12:45.010', '2019-08-17 14:12:45.010', '2019-08-17 14:12:45.010', '', NULL);
INSERT INTO `sys_job_log` VALUES (495, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:13:00.017', '2019-08-17 14:13:00.017', '2019-08-17 14:13:00.017', '', NULL);
INSERT INTO `sys_job_log` VALUES (496, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:13:15.006', '2019-08-17 14:13:15.006', '2019-08-17 14:13:15.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (497, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:13:30.006', '2019-08-17 14:13:30.006', '2019-08-17 14:13:30.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (498, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:13:45.005', '2019-08-17 14:13:45.005', '2019-08-17 14:13:45.005', '', NULL);
INSERT INTO `sys_job_log` VALUES (499, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:14:00.009', '2019-08-17 14:14:00.009', '2019-08-17 14:14:00.009', '', NULL);
INSERT INTO `sys_job_log` VALUES (500, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:14:15.013', '2019-08-17 14:14:15.013', '2019-08-17 14:14:15.013', '', NULL);
INSERT INTO `sys_job_log` VALUES (501, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:14:30.012', '2019-08-17 14:14:30.012', '2019-08-17 14:14:30.012', '', NULL);
INSERT INTO `sys_job_log` VALUES (502, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:14:45.006', '2019-08-17 14:14:45.006', '2019-08-17 14:14:45.006', '', NULL);
INSERT INTO `sys_job_log` VALUES (503, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '系统默认（有参） 总共耗时：0毫秒', '1', '2019-08-17 14:15:00.009', '2019-08-17 14:15:00.009', '2019-08-17 14:15:00.009', '', NULL);

-- ----------------------------
-- Table structure for sys_log_operate
-- ----------------------------
DROP TABLE IF EXISTS `sys_log_operate`;
CREATE TABLE `sys_log_operate`  (
  `id` bigint(64) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '日志标题',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `service_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '服务ID',
  `ip_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'IP地址',
  `ip_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `user_agent` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户代理',
  `request_uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求URI',
  `method` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作方式',
  `params` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '操作提交的数据',
  `time` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '执行时间',
  `operator_type` int(1) NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `business_type` int(2) NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `exception` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '异常信息',
  `created_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sys_log_create_by`(`created_by`) USING BTREE,
  INDEX `sys_log_request_uri`(`request_uri`) USING BTREE,
  INDEX `sys_log_create_date`(`created_date`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 240 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_log_operate
-- ----------------------------
INSERT INTO `sys_log_operate` VALUES (215, '业务表', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36', '/a/gen/table/', 'POST', '{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"name\":\"test_tree_book\",\"comments\":\"  测试树书\",\"className\":\"TestTreeBook\",\"parentTable\":null,\"parentTableFk\":null,\"parent\":null,\"childList\":[],\"nameAndTitle\":\"test_tree_book  :    测试树书\",\"nameLike\":null,\"pkList\":[\"id\"],\"category\":null,\"pkColumnList\":[{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"id\",\"title\":\"id\",\"comments\":null,\"jdbcType\":\"varchar(32)\",\"javaType\":\"String\",\"javaField\":\"id\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":10,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"nameAndTitle\":\"id  :  id\",\"size\":\"32\",\"null\":false,\"unique\":false,\"list\":false,\"insert\":true,\"edit\":false,\"query\":false,\"pk\":true,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"id\",\"dataLength\":\"32\",\"simpleJavaField\":\"id\",\"constantJavaField\":\"ID\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaType\":\"String\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":true,\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"]}],\"columnList\":[{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"id\",\"title\":\"id\",\"comments\":null,\"jdbcType\":\"varchar(32)\",\"javaType\":\"String\",\"javaField\":\"id\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":10,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"nameAndTitle\":\"id  :  id\",\"size\":\"32\",\"null\":false,\"unique\":false,\"list\":false,\"insert\":true,\"edit\":false,\"query\":false,\"pk\":true,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"id\",\"dataLength\":\"32\",\"simpleJavaField\":\"id\",\"constantJavaField\":\"ID\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaType\":\"String\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":true,\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"parent_id\",\"title\":\"parent_id\",\"comments\":null,\"jdbcType\":\"varchar(32)\",\"javaType\":\"String\",\"javaField\":\"parentId\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":20,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"nameAndTitle\":\"parent_id  :  parent_id\",\"size\":\"32\",\"null\":true,\"unique\":false,\"list\":true,\"insert\":true,\"edit\":true,\"query\":false,\"pk\":false,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"parentId\",\"dataLength\":\"32\",\"simpleJavaField\":\"parentId\",\"constantJavaField\":\"PARENTID\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"parent_id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaType\":\"String\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":false,\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"parent_id长度必须介于 1 和 32 之间\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"parent_ids\",\"title\":\"父菜单IDs\",\"comments\":null,\"jdbcType\":\"varchar(2000)\",\"javaType\":\"String\",\"javaField\":\"parentIds\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":30,\"hibernateValidatorExprssion\":\"@Size(max=2000)\",\"nameAndTitle\":\"parent_ids  :  父菜单IDs\",\"size\":\"2000\",\"null\":true,\"unique\":false,\"list\":true,\"insert\":true,\"edit\":true,\"query\":false,\"pk\":false,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"parentIds\",\"dataLength\":\"2000\",\"simpleJavaField\":\"parentIds\",\"constantJavaField\":\"PARENTIDS\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"Size(min=1, max=2000, message=\\\"父菜单IDs长度必须介于 1 和 2000 之间\\\")\"],\"simpleJavaType\":\"String\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":false,\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=2000, message=\\\"父菜单IDs长度必须介于 1 和 2000 之间\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"name\",\"title\":\"部门名称\",\"comments\":null,\"jdbcType\":\"varchar(50)\",\"javaType\":\"String\",\"javaField\":\"name\",\"queryType\":\"like\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":40,\"hibernateValidatorExprssion\":\"@Size(max=50)\",\"nameAndTitle\":\"name  :  部门名称\",\"size\":\"50\",\"null\":true,\"unique\":false,\"list\":true,\"insert\":true,\"edit\":true,\"query\":true,\"pk\":false,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"name\",\"dataLength\":\"50\",\"simpleJavaField\":\"name\",\"constantJavaField\":\"NAME\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"部门名称长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaType\":\"String\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":false,\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"部门名称长度必须介于 1 和 50 之间\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"sort\",\"title\":\"排序\",\"comments\":null,\"jdbcType\":\"int(11)\",\"javaType\":\"Long\",\"javaField\":\"sort\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":50,\"hibernateValidatorExprssion\":\"\",\"nameAndTitle\":\"sort  :  排序\",\"size\":\"11\",\"null\":true,\"unique\":false,\"list\":true,\"insert\":true,\"edit\":true,\"query\":false,\"pk\":false,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"sort\",\"dataLength\":\"11\",\"simpleJavaField\":\"sort\",\"constantJavaField\":\"SORT\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"NotNull(message=\\\"排序不能为空\\\")\"],\"simpleJavaType\":\"Long\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":false,\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"排序不能为空\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"leaf\",\"title\":\"1 叶子节点 0 非叶子节点\",\"comments\":null,\"jdbcType\":\"bit(1)\",\"javaType\":\"Integer\",\"javaField\":\"leaf\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":60,\"hibernateValidatorExprssion\":\"\",\"nameAndTitle\":\"leaf  :  1 叶子节点 0 非叶子节点\",\"size\":\"1\",\"null\":true,\"unique\":false,\"list\":true,\"insert\":true,\"edit\":true,\"query\":false,\"pk\":false,\"simpleTsType\":\"number\",\"javaFieldName\":\"\",\"javaFieldId\":\"leaf\",\"dataLength\":\"1\",\"simpleJavaField\":\"leaf\",\"constantJavaField\":\"LEAF\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"NotNull(message=\\\"1 叶子节点 0 非叶子节点不能为空\\\")\"],\"simpleJavaType\":\"Integer\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":false,\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"1 叶子节点 0 非叶子节点不能为空\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"author_\",\"title\":\"作者\",\"comments\":null,\"jdbcType\":\"varchar(50)\",\"javaType\":\"String\",\"javaField\":\"author\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":70,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=50)\",\"nameAndTitle\":\"author_  :  作者\",\"size\":\"50\",\"null\":false,\"unique\":false,\"list\":true,\"insert\":true,\"edit\":true,\"query\":false,\"pk\":false,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"author\",\"dataLength\":\"50\",\"simpleJavaField\":\"author\",\"constantJavaField\":\"AUTHOR\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"作者长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaType\":\"String\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":true,\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"作者长度必须介于 1 和 50 之间\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"email_\",\"title\":\"邮箱\",\"comments\":null,\"jdbcType\":\"varchar(100)\",\"javaType\":\"String\",\"javaField\":\"email\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":80,\"hibernateValidatorExprssion\":\"@Email @Size(max=100)\",\"nameAndTitle\":\"email_  :  邮箱\",\"size\":\"100\",\"null\":true,\"unique\":false,\"list\":true,\"insert\":true,\"edit\":true,\"query\":false,\"pk\":false,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"email\",\"dataLength\":\"100\",\"simpleJavaField\":\"email\",\"constantJavaField\":\"EMAIL\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"Size(min=1, max=100, message=\\\"邮箱长度必须介于 1 和 100 之间\\\")\"],\"simpleJavaType\":\"String\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":true,\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=100, message=\\\"邮箱长度必须介于 1 和 100 之间\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"phone_\",\"title\":\"手机\",\"comments\":null,\"jdbcType\":\"varchar(32)\",\"javaType\":\"String\",\"javaField\":\"phone\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":90,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"nameAndTitle\":\"phone_  :  手机\",\"size\":\"32\",\"null\":true,\"unique\":false,\"list\":true,\"insert\":true,\"edit\":true,\"query\":false,\"pk\":false,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"phone\",\"dataLength\":\"32\",\"simpleJavaField\":\"phone\",\"constantJavaField\":\"PHONE\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"手机长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaType\":\"String\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":true,\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"手机长度必须介于 1 和 32 之间\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"activated_\",\"title\":\"activated_\",\"comments\":null,\"jdbcType\":\"bit(1)\",\"javaType\":\"Integer\",\"javaField\":\"activated\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":100,\"hibernateValidatorExprssion\":\"@NotNull \",\"nameAndTitle\":\"activated_  :  activated_\",\"size\":\"1\",\"null\":false,\"unique\":false,\"list\":true,\"insert\":true,\"edit\":true,\"query\":false,\"pk\":false,\"simpleTsType\":\"number\",\"javaFieldName\":\"\",\"javaFieldId\":\"activated\",\"dataLength\":\"1\",\"simpleJavaField\":\"activated\",\"constantJavaField\":\"ACTIVATED\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"NotNull(message=\\\"activated_不能为空\\\")\"],\"simpleJavaType\":\"Integer\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":true,\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"activated_不能为空\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"number_\",\"title\":\"key\",\"comments\":null,\"jdbcType\":\"int(11)\",\"javaType\":\"Long\",\"javaField\":\"number\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":110,\"hibernateValidatorExprssion\":\"\",\"nameAndTitle\":\"number_  :  key\",\"size\":\"11\",\"null\":true,\"unique\":false,\"list\":true,\"insert\":true,\"edit\":true,\"query\":false,\"pk\":false,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"number\",\"dataLength\":\"11\",\"simpleJavaField\":\"number\",\"constantJavaField\":\"NUMBER\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"NotNull(message=\\\"key不能为空\\\")\"],\"simpleJavaType\":\"Long\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":true,\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"key不能为空\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"money_\",\"title\":\"money_\",\"comments\":null,\"jdbcType\":\"decimal(20,2)\",\"javaType\":\"Double\",\"javaField\":\"money\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":120,\"hibernateValidatorExprssion\":\"\",\"nameAndTitle\":\"money_  :  money_\",\"size\":\"20,2\",\"null\":true,\"unique\":false,\"list\":true,\"insert\":true,\"edit\":true,\"query\":false,\"pk\":false,\"simpleTsType\":\"number\",\"javaFieldName\":\"\",\"javaFieldId\":\"money\",\"dataLength\":\"0\",\"simpleJavaField\":\"money\",\"constantJavaField\":\"MONEY\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"NotNull(message=\\\"money_不能为空\\\")\"],\"simpleJavaType\":\"Double\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":true,\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"money_不能为空\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"amount_\",\"title\":\"amount_\",\"comments\":null,\"jdbcType\":\"double(11,2)\",\"javaType\":\"Double\",\"javaField\":\"amount\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":130,\"hibernateValidatorExprssion\":\"\",\"nameAndTitle\":\"amount_  :  amount_\",\"size\":\"11,2\",\"null\":true,\"unique\":false,\"list\":true,\"insert\":true,\"edit\":true,\"query\":false,\"pk\":false,\"simpleTsType\":\"number\",\"javaFieldName\":\"\",\"javaFieldId\":\"amount\",\"dataLength\":\"0\",\"simpleJavaField\":\"amount\",\"constantJavaField\":\"AMOUNT\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"NotNull(message=\\\"amount_不能为空\\\")\"],\"simpleJavaType\":\"Double\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":true,\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"amount_不能为空\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"reset_date\",\"title\":\"reset_date\",\"comments\":null,\"jdbcType\":\"timestamp(3)\",\"javaType\":\"java.util.Date\",\"javaField\":\"resetDate\",\"queryType\":\"eq\",\"showType\":\"dateselect\",\"dictType\":\"\",\"sort\":140,\"hibernateValidatorExprssion\":\"\",\"nameAndTitle\":\"reset_date  :  reset_date\",\"size\":\"3\",\"null\":true,\"unique\":false,\"list\":true,\"insert\":true,\"edit\":true,\"query\":false,\"pk\":false,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"resetDate\",\"dataLength\":\"3\",\"simpleJavaField\":\"resetDate\",\"constantJavaField\":\"RESETDATE\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":true,\"isNotBaseField\":true,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"NotNull(message=\\\"reset_date不能为空\\\")\"],\"simpleJavaType\":\"Date\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":true,\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"reset_date不能为空\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"created_by\",\"title\":\"created_by\",\"comments\":null,\"jdbcType\":\"varchar(50)\",\"javaType\":\"String\",\"javaField\":\"createdBy\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":150,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=50)\",\"nameAndTitle\":\"created_by  :  created_by\",\"size\":\"50\",\"null\":false,\"unique\":false,\"list\":false,\"insert\":true,\"edit\":false,\"query\":false,\"pk\":false,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"createdBy\",\"dataLength\":\"50\",\"simpleJavaField\":\"createdBy\",\"constantJavaField\":\"CREATEDBY\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaType\":\"String\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":true,\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"created_date\",\"title\":\"创建时间\",\"comments\":null,\"jdbcType\":\"timestamp(3)\",\"javaType\":\"java.util.Date\",\"javaField\":\"createdDate\",\"queryType\":\"eq\",\"showType\":\"dateselect\",\"dictType\":\"\",\"sort\":160,\"hibernateValidatorExprssion\":\"\",\"nameAndTitle\":\"created_date  :  创建时间\",\"size\":\"3\",\"null\":true,\"unique\":false,\"list\":false,\"insert\":true,\"edit\":false,\"query\":false,\"pk\":false,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"createdDate\",\"dataLength\":\"3\",\"simpleJavaField\":\"createdDate\",\"constantJavaField\":\"CREATEDDATE\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"NotNull(message=\\\"创建时间不能为空\\\")\"],\"simpleJavaType\":\"Date\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":true,\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"创建时间不能为空\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"last_modified_by\",\"title\":\"last_modified_by\",\"comments\":null,\"jdbcType\":\"varchar(50)\",\"javaType\":\"String\",\"javaField\":\"lastModifiedBy\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":170,\"hibernateValidatorExprssion\":\"@Size(max=50)\",\"nameAndTitle\":\"last_modified_by  :  last_modified_by\",\"size\":\"50\",\"null\":true,\"unique\":false,\"list\":false,\"insert\":true,\"edit\":false,\"query\":false,\"pk\":false,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"lastModifiedBy\",\"dataLength\":\"50\",\"simpleJavaField\":\"lastModifiedBy\",\"constantJavaField\":\"LASTMODIFIEDBY\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaType\":\"String\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":true,\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"del_flag\",\"title\":\"0-正常，1-删除\",\"comments\":null,\"jdbcType\":\"char(1)\",\"javaType\":\"String\",\"javaField\":\"delFlag\",\"queryType\":\"eq\",\"showType\":\"radio\",\"dictType\":\"sys_flag\",\"sort\":180,\"hibernateValidatorExprssion\":\"@Size(max=1)\",\"nameAndTitle\":\"del_flag  :  0-正常，1-删除\",\"size\":\"1\",\"null\":true,\"unique\":false,\"list\":false,\"insert\":true,\"edit\":false,\"query\":false,\"pk\":false,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"delFlag\",\"dataLength\":\"1\",\"simpleJavaField\":\"delFlag\",\"constantJavaField\":\"DELFLAG\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"simpleJavaType\":\"String\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":true,\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"last_modified_date\",\"title\":\"修改时间\",\"comments\":null,\"jdbcType\":\"timestamp(3)\",\"javaType\":\"java.util.Date\",\"javaField\":\"lastModifiedDate\",\"queryType\":\"eq\",\"showType\":\"dateselect\",\"dictType\":\"\",\"sort\":190,\"hibernateValidatorExprssion\":\"\",\"nameAndTitle\":\"last_modified_date  :  修改时间\",\"size\":\"3\",\"null\":true,\"unique\":false,\"list\":false,\"insert\":true,\"edit\":false,\"query\":false,\"pk\":false,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"lastModifiedDate\",\"dataLength\":\"3\",\"simpleJavaField\":\"lastModifiedDate\",\"constantJavaField\":\"LASTMODIFIEDDATE\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"NotNull(message=\\\"修改时间不能为空\\\")\"],\"simpleJavaType\":\"Date\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":true,\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"修改时间不能为空\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"version\",\"title\":\"version\",\"comments\":null,\"jdbcType\":\"int(11)\",\"javaType\":\"Long\",\"javaField\":\"version\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":200,\"hibernateValidatorExprssion\":\"@NotNull \",\"nameAndTitle\":\"version  :  version\",\"size\":\"11\",\"null\":false,\"unique\":false,\"list\":false,\"insert\":true,\"edit\":false,\"query\":false,\"pk\":false,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"version\",\"dataLength\":\"11\",\"simpleJavaField\":\"version\",\"constantJavaField\":\"VERSION\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"NotNull(message=\\\"version不能为空\\\")\"],\"simpleJavaType\":\"Long\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":true,\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"version不能为空\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"description\",\"title\":\"备注\",\"comments\":null,\"jdbcType\":\"varchar(100)\",\"javaType\":\"String\",\"javaField\":\"description\",\"queryType\":\"eq\",\"showType\":\"textarea\",\"dictType\":\"\",\"sort\":210,\"hibernateValidatorExprssion\":\"@Size(max=100)\",\"nameAndTitle\":\"description  :  备注\",\"size\":\"100\",\"null\":true,\"unique\":false,\"list\":false,\"insert\":true,\"edit\":true,\"query\":false,\"pk\":false,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"description\",\"dataLength\":\"100\",\"simpleJavaField\":\"description\",\"constantJavaField\":\"DESCRIPTION\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"Size(min=1, max=100, message=\\\"备注长度必须介于 1 和 100 之间\\\")\"],\"simpleJavaType\":\"String\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":true,\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=100, message=\\\"备注长度必须介于 1 和 100 之间\\\")\"]}],\"columnFormList\":[{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"id\",\"title\":\"id\",\"comments\":null,\"jdbcType\":\"varchar(32)\",\"javaType\":\"String\",\"javaField\":\"id\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":10,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"nameAndTitle\":\"id  :  id\",\"size\":\"32\",\"null\":false,\"unique\":false,\"list\":false,\"insert\":true,\"edit\":false,\"query\":false,\"pk\":true,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"id\",\"dataLength\":\"32\",\"simpleJavaField\":\"id\",\"constantJavaField\":\"ID\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaType\":\"String\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":true,\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"parent_id\",\"title\":\"parent_id\",\"comments\":null,\"jdbcType\":\"varchar(32)\",\"javaType\":\"String\",\"javaField\":\"parentId\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":20,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"nameAndTitle\":\"parent_id  :  parent_id\",\"size\":\"32\",\"null\":true,\"unique\":false,\"list\":true,\"insert\":true,\"edit\":true,\"query\":false,\"pk\":false,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"parentId\",\"dataLength\":\"32\",\"simpleJavaField\":\"parentId\",\"constantJavaField\":\"PARENTID\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"parent_id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaType\":\"String\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":false,\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"parent_id长度必须介于 1 和 32 之间\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"parent_ids\",\"title\":\"父菜单IDs\",\"comments\":null,\"jdbcType\":\"varchar(2000)\",\"javaType\":\"String\",\"javaField\":\"parentIds\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":30,\"hibernateValidatorExprssion\":\"@Size(max=2000)\",\"nameAndTitle\":\"parent_ids  :  父菜单IDs\",\"size\":\"2000\",\"null\":true,\"unique\":false,\"list\":true,\"insert\":true,\"edit\":true,\"query\":false,\"pk\":false,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"parentIds\",\"dataLength\":\"2000\",\"simpleJavaField\":\"parentIds\",\"constantJavaField\":\"PARENTIDS\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"Size(min=1, max=2000, message=\\\"父菜单IDs长度必须介于 1 和 2000 之间\\\")\"],\"simpleJavaType\":\"String\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":false,\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=2000, message=\\\"父菜单IDs长度必须介于 1 和 2000 之间\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"name\",\"title\":\"部门名称\",\"comments\":null,\"jdbcType\":\"varchar(50)\",\"javaType\":\"String\",\"javaField\":\"name\",\"queryType\":\"like\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":40,\"hibernateValidatorExprssion\":\"@Size(max=50)\",\"nameAndTitle\":\"name  :  部门名称\",\"size\":\"50\",\"null\":true,\"unique\":false,\"list\":true,\"insert\":true,\"edit\":true,\"query\":true,\"pk\":false,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"name\",\"dataLength\":\"50\",\"simpleJavaField\":\"name\",\"constantJavaField\":\"NAME\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"部门名称长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaType\":\"String\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":false,\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"部门名称长度必须介于 1 和 50 之间\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"sort\",\"title\":\"排序\",\"comments\":null,\"jdbcType\":\"int(11)\",\"javaType\":\"Long\",\"javaField\":\"sort\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":50,\"hibernateValidatorExprssion\":\"\",\"nameAndTitle\":\"sort  :  排序\",\"size\":\"11\",\"null\":true,\"unique\":false,\"list\":true,\"insert\":true,\"edit\":true,\"query\":false,\"pk\":false,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"sort\",\"dataLength\":\"11\",\"simpleJavaField\":\"sort\",\"constantJavaField\":\"SORT\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"NotNull(message=\\\"排序不能为空\\\")\"],\"simpleJavaType\":\"Long\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":false,\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"排序不能为空\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"leaf\",\"title\":\"1 叶子节点 0 非叶子节点\",\"comments\":null,\"jdbcType\":\"bit(1)\",\"javaType\":\"Integer\",\"javaField\":\"leaf\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":60,\"hibernateValidatorExprssion\":\"\",\"nameAndTitle\":\"leaf  :  1 叶子节点 0 非叶子节点\",\"size\":\"1\",\"null\":true,\"unique\":false,\"list\":true,\"insert\":true,\"edit\":true,\"query\":false,\"pk\":false,\"simpleTsType\":\"number\",\"javaFieldName\":\"\",\"javaFieldId\":\"leaf\",\"dataLength\":\"1\",\"simpleJavaField\":\"leaf\",\"constantJavaField\":\"LEAF\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"NotNull(message=\\\"1 叶子节点 0 非叶子节点不能为空\\\")\"],\"simpleJavaType\":\"Integer\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":false,\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"1 叶子节点 0 非叶子节点不能为空\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"author_\",\"title\":\"作者\",\"comments\":null,\"jdbcType\":\"varchar(50)\",\"javaType\":\"String\",\"javaField\":\"author\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":70,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=50)\",\"nameAndTitle\":\"author_  :  作者\",\"size\":\"50\",\"null\":false,\"unique\":false,\"list\":true,\"insert\":true,\"edit\":true,\"query\":false,\"pk\":false,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"author\",\"dataLength\":\"50\",\"simpleJavaField\":\"author\",\"constantJavaField\":\"AUTHOR\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"作者长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaType\":\"String\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":true,\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"作者长度必须介于 1 和 50 之间\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"email_\",\"title\":\"邮箱\",\"comments\":null,\"jdbcType\":\"varchar(100)\",\"javaType\":\"String\",\"javaField\":\"email\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":80,\"hibernateValidatorExprssion\":\"@Email @Size(max=100)\",\"nameAndTitle\":\"email_  :  邮箱\",\"size\":\"100\",\"null\":true,\"unique\":false,\"list\":true,\"insert\":true,\"edit\":true,\"query\":false,\"pk\":false,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"email\",\"dataLength\":\"100\",\"simpleJavaField\":\"email\",\"constantJavaField\":\"EMAIL\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"Size(min=1, max=100, message=\\\"邮箱长度必须介于 1 和 100 之间\\\")\"],\"simpleJavaType\":\"String\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":true,\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=100, message=\\\"邮箱长度必须介于 1 和 100 之间\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"phone_\",\"title\":\"手机\",\"comments\":null,\"jdbcType\":\"varchar(32)\",\"javaType\":\"String\",\"javaField\":\"phone\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":90,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"nameAndTitle\":\"phone_  :  手机\",\"size\":\"32\",\"null\":true,\"unique\":false,\"list\":true,\"insert\":true,\"edit\":true,\"query\":false,\"pk\":false,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"phone\",\"dataLength\":\"32\",\"simpleJavaField\":\"phone\",\"constantJavaField\":\"PHONE\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"手机长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaType\":\"String\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":true,\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"手机长度必须介于 1 和 32 之间\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"activated_\",\"title\":\"activated_\",\"comments\":null,\"jdbcType\":\"bit(1)\",\"javaType\":\"Integer\",\"javaField\":\"activated\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":100,\"hibernateValidatorExprssion\":\"@NotNull \",\"nameAndTitle\":\"activated_  :  activated_\",\"size\":\"1\",\"null\":false,\"unique\":false,\"list\":true,\"insert\":true,\"edit\":true,\"query\":false,\"pk\":false,\"simpleTsType\":\"number\",\"javaFieldName\":\"\",\"javaFieldId\":\"activated\",\"dataLength\":\"1\",\"simpleJavaField\":\"activated\",\"constantJavaField\":\"ACTIVATED\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"NotNull(message=\\\"activated_不能为空\\\")\"],\"simpleJavaType\":\"Integer\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":true,\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"activated_不能为空\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"number_\",\"title\":\"key\",\"comments\":null,\"jdbcType\":\"int(11)\",\"javaType\":\"Long\",\"javaField\":\"number\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":110,\"hibernateValidatorExprssion\":\"\",\"nameAndTitle\":\"number_  :  key\",\"size\":\"11\",\"null\":true,\"unique\":false,\"list\":true,\"insert\":true,\"edit\":true,\"query\":false,\"pk\":false,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"number\",\"dataLength\":\"11\",\"simpleJavaField\":\"number\",\"constantJavaField\":\"NUMBER\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"NotNull(message=\\\"key不能为空\\\")\"],\"simpleJavaType\":\"Long\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":true,\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"key不能为空\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"money_\",\"title\":\"money_\",\"comments\":null,\"jdbcType\":\"decimal(20,2)\",\"javaType\":\"Double\",\"javaField\":\"money\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":120,\"hibernateValidatorExprssion\":\"\",\"nameAndTitle\":\"money_  :  money_\",\"size\":\"20,2\",\"null\":true,\"unique\":false,\"list\":true,\"insert\":true,\"edit\":true,\"query\":false,\"pk\":false,\"simpleTsType\":\"number\",\"javaFieldName\":\"\",\"javaFieldId\":\"money\",\"dataLength\":\"0\",\"simpleJavaField\":\"money\",\"constantJavaField\":\"MONEY\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"NotNull(message=\\\"money_不能为空\\\")\"],\"simpleJavaType\":\"Double\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":true,\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"money_不能为空\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"amount_\",\"title\":\"amount_\",\"comments\":null,\"jdbcType\":\"double(11,2)\",\"javaType\":\"Double\",\"javaField\":\"amount\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":130,\"hibernateValidatorExprssion\":\"\",\"nameAndTitle\":\"amount_  :  amount_\",\"size\":\"11,2\",\"null\":true,\"unique\":false,\"list\":true,\"insert\":true,\"edit\":true,\"query\":false,\"pk\":false,\"simpleTsType\":\"number\",\"javaFieldName\":\"\",\"javaFieldId\":\"amount\",\"dataLength\":\"0\",\"simpleJavaField\":\"amount\",\"constantJavaField\":\"AMOUNT\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"NotNull(message=\\\"amount_不能为空\\\")\"],\"simpleJavaType\":\"Double\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":true,\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"amount_不能为空\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"reset_date\",\"title\":\"reset_date\",\"comments\":null,\"jdbcType\":\"timestamp(3)\",\"javaType\":\"java.util.Date\",\"javaField\":\"resetDate\",\"queryType\":\"eq\",\"showType\":\"dateselect\",\"dictType\":\"\",\"sort\":140,\"hibernateValidatorExprssion\":\"\",\"nameAndTitle\":\"reset_date  :  reset_date\",\"size\":\"3\",\"null\":true,\"unique\":false,\"list\":true,\"insert\":true,\"edit\":true,\"query\":false,\"pk\":false,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"resetDate\",\"dataLength\":\"3\",\"simpleJavaField\":\"resetDate\",\"constantJavaField\":\"RESETDATE\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":true,\"isNotBaseField\":true,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"NotNull(message=\\\"reset_date不能为空\\\")\"],\"simpleJavaType\":\"Date\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":true,\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"reset_date不能为空\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"created_by\",\"title\":\"created_by\",\"comments\":null,\"jdbcType\":\"varchar(50)\",\"javaType\":\"String\",\"javaField\":\"createdBy\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":150,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=50)\",\"nameAndTitle\":\"created_by  :  created_by\",\"size\":\"50\",\"null\":false,\"unique\":false,\"list\":false,\"insert\":true,\"edit\":false,\"query\":false,\"pk\":false,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"createdBy\",\"dataLength\":\"50\",\"simpleJavaField\":\"createdBy\",\"constantJavaField\":\"CREATEDBY\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaType\":\"String\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":true,\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"created_date\",\"title\":\"创建时间\",\"comments\":null,\"jdbcType\":\"timestamp(3)\",\"javaType\":\"java.util.Date\",\"javaField\":\"createdDate\",\"queryType\":\"eq\",\"showType\":\"dateselect\",\"dictType\":\"\",\"sort\":160,\"hibernateValidatorExprssion\":\"\",\"nameAndTitle\":\"created_date  :  创建时间\",\"size\":\"3\",\"null\":true,\"unique\":false,\"list\":false,\"insert\":true,\"edit\":false,\"query\":false,\"pk\":false,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"createdDate\",\"dataLength\":\"3\",\"simpleJavaField\":\"createdDate\",\"constantJavaField\":\"CREATEDDATE\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"NotNull(message=\\\"创建时间不能为空\\\")\"],\"simpleJavaType\":\"Date\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":true,\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"创建时间不能为空\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"last_modified_by\",\"title\":\"last_modified_by\",\"comments\":null,\"jdbcType\":\"varchar(50)\",\"javaType\":\"String\",\"javaField\":\"lastModifiedBy\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":170,\"hibernateValidatorExprssion\":\"@Size(max=50)\",\"nameAndTitle\":\"last_modified_by  :  last_modified_by\",\"size\":\"50\",\"null\":true,\"unique\":false,\"list\":false,\"insert\":true,\"edit\":false,\"query\":false,\"pk\":false,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"lastModifiedBy\",\"dataLength\":\"50\",\"simpleJavaField\":\"lastModifiedBy\",\"constantJavaField\":\"LASTMODIFIEDBY\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaType\":\"String\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":true,\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"del_flag\",\"title\":\"0-正常，1-删除\",\"comments\":null,\"jdbcType\":\"char(1)\",\"javaType\":\"String\",\"javaField\":\"delFlag\",\"queryType\":\"eq\",\"showType\":\"radio\",\"dictType\":\"sys_flag\",\"sort\":180,\"hibernateValidatorExprssion\":\"@Size(max=1)\",\"nameAndTitle\":\"del_flag  :  0-正常，1-删除\",\"size\":\"1\",\"null\":true,\"unique\":false,\"list\":false,\"insert\":true,\"edit\":false,\"query\":false,\"pk\":false,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"delFlag\",\"dataLength\":\"1\",\"simpleJavaField\":\"delFlag\",\"constantJavaField\":\"DELFLAG\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"simpleJavaType\":\"String\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":true,\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"last_modified_date\",\"title\":\"修改时间\",\"comments\":null,\"jdbcType\":\"timestamp(3)\",\"javaType\":\"java.util.Date\",\"javaField\":\"lastModifiedDate\",\"queryType\":\"eq\",\"showType\":\"dateselect\",\"dictType\":\"\",\"sort\":190,\"hibernateValidatorExprssion\":\"\",\"nameAndTitle\":\"last_modified_date  :  修改时间\",\"size\":\"3\",\"null\":true,\"unique\":false,\"list\":false,\"insert\":true,\"edit\":false,\"query\":false,\"pk\":false,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"lastModifiedDate\",\"dataLength\":\"3\",\"simpleJavaField\":\"lastModifiedDate\",\"constantJavaField\":\"LASTMODIFIEDDATE\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"NotNull(message=\\\"修改时间不能为空\\\")\"],\"simpleJavaType\":\"Date\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":true,\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"修改时间不能为空\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"version\",\"title\":\"version\",\"comments\":null,\"jdbcType\":\"int(11)\",\"javaType\":\"Long\",\"javaField\":\"version\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":200,\"hibernateValidatorExprssion\":\"@NotNull \",\"nameAndTitle\":\"version  :  version\",\"size\":\"11\",\"null\":false,\"unique\":false,\"list\":false,\"insert\":true,\"edit\":false,\"query\":false,\"pk\":false,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"version\",\"dataLength\":\"11\",\"simpleJavaField\":\"version\",\"constantJavaField\":\"VERSION\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"NotNull(message=\\\"version不能为空\\\")\"],\"simpleJavaType\":\"Long\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":true,\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"version不能为空\\\")\"]},{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"description\",\"title\":\"备注\",\"comments\":null,\"jdbcType\":\"varchar(100)\",\"javaType\":\"String\",\"javaField\":\"description\",\"queryType\":\"eq\",\"showType\":\"textarea\",\"dictType\":\"\",\"sort\":210,\"hibernateValidatorExprssion\":\"@Size(max=100)\",\"nameAndTitle\":\"description  :  备注\",\"size\":\"100\",\"null\":true,\"unique\":false,\"list\":false,\"insert\":true,\"edit\":true,\"query\":false,\"pk\":false,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"description\",\"dataLength\":\"100\",\"simpleJavaField\":\"description\",\"constantJavaField\":\"DESCRIPTION\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"Size(min=1, max=100, message=\\\"备注长度必须介于 1 和 100 之间\\\")\"],\"simpleJavaType\":\"String\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":true,\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=100, message=\\\"备注长度必须介于 1 和 100 之间\\\")\"]}],\"compositeId\":false,\"notCompositeId\":true,\"importList\":[\"com.baomidou.mybatisplus.annotation.*\",\"com.albedo.java.common.core.annotation.SearchField\",\"com.albedo.java.common.persistence.domain.IdEntity\",\"javax.validation.constraints.Size\",\"javax.validation.constraints.NotNull\",\"javax.validation.constraints.NotBlank\",\"javax.validation.constraints.Email\",\"java.util.Date\",\"com.albedo.java.common.core.annotation.DictType\"],\"parentExists\":false,\"childeExists\":false,\"statusExists\":false,\"pkJavaType\":\"String\",\"pkColumn\":{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"tableId\":null,\"table\":null,\"name\":\"id\",\"title\":\"id\",\"comments\":null,\"jdbcType\":\"varchar(32)\",\"javaType\":\"String\",\"javaField\":\"id\",\"queryType\":\"eq\",\"showType\":\"input\",\"dictType\":\"\",\"sort\":10,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"nameAndTitle\":\"id  :  id\",\"size\":\"32\",\"null\":false,\"unique\":false,\"list\":false,\"insert\":true,\"edit\":false,\"query\":false,\"pk\":true,\"simpleTsType\":\"string\",\"javaFieldName\":\"\",\"javaFieldId\":\"id\",\"dataLength\":\"32\",\"simpleJavaField\":\"id\",\"constantJavaField\":\"ID\",\"javaFieldAttrs\":[],\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"defaultJavaFieldName\":\"name\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaType\":\"String\",\"javaFieldShowName\":\"\",\"isNotBaseTreeField\":true,\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"]},\"pkSqlName\":\"id\",\"pkSize\":\"32\",\"createTimeExists\":false,\"updateTimeExists\":false}', '313', 1, 1, NULL, '1', '2019-08-11 14:28:25.800', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (216, '生成方案', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36', '/a/gen/scheme/', 'POST', '{\"id\":null,\"delFlag\":\"0\",\"createdBy\":null,\"createdDate\":null,\"lastModifiedBy\":null,\"version\":0,\"lastModifiedDate\":null,\"description\":null,\"name\":\"测试树管理\",\"category\":\"treeTable\",\"viewType\":null,\"packageName\":\"com.albedo.java.modules\",\"moduleName\":\"test\",\"subModuleName\":null,\"functionName\":\"测试树\",\"functionNameSimple\":\"测试树\",\"functionAuthor\":\"admin\",\"tableId\":\"8f4c981d09b1c974fefb7e5a2028246e\",\"tableDataVo\":null,\"genCode\":false,\"replaceFile\":false,\"modalView\":false}', '22', 1, 1, NULL, '1', '2019-08-11 14:29:17.146', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (217, '生成方案', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36', '/a/gen/scheme/gen-menu', 'POST', '{\"id\":\"de5eaba0d276a7adf5b9bbd25cb59833\",\"parentMenuName\":\"代码生成\",\"parentMenuId\":\"413892fe8d52c1163d6659f51299dc96\"}', '43', 1, 1, NULL, '1', '2019-08-11 14:32:06.821', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (218, '生成方案', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36', '/a/gen/scheme/gen-code', 'PUT', '{\"id\":\"de5eaba0d276a7adf5b9bbd25cb59833\",\"replaceFile\":true}', '559', 1, 7, NULL, '1', '2019-08-11 14:32:10.648', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (219, '生成方案', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36', '/a/gen/scheme/gen-code', 'PUT', '{\"id\":\"de5eaba0d276a7adf5b9bbd25cb59833\",\"replaceFile\":true}', '172', 1, 7, NULL, '1', '2019-08-11 14:34:19.443', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (220, '新增/编辑角色', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36', '/a/sys/role', 'POST', '{\"id\":\"1\",\"delFlag\":\"0\",\"createdBy\":\"\",\"createdDate\":\"2017-10-29 15:45:51\",\"lastModifiedBy\":\"1\",\"version\":48,\"lastModifiedDate\":\"2019-08-11 10:58:14\",\"description\":null,\"availableText\":\"是\",\"available\":\"1\",\"dataScopeText\":\"全部\",\"dataScope\":\"1\",\"name\":\"管理员\",\"code\":\"ROLE_ADMIN\",\"remark\":\"管理员\",\"menuIdList\":[\"1000\",\"1100\",\"1a900c3f10ef5b0987e0a8ee4445316d\",\"1101\",\"1102\",\"1103\",\"bd62904371247f56594741ff8e9bded9\",\"1200\",\"1201\",\"1202\",\"1203\",\"94b57a562063d103423e2c6125cb30ad\",\"1300\",\"1301\",\"1302\",\"1303\",\"1304\",\"1400\",\"1401\",\"1402\",\"1403\",\"2000\",\"2100\",\"13093fb658c1806ad5bd0600316158f2\",\"2101\",\"d4c16faad8f883650a3a8eab829ebad9\",\"2200\",\"2201\",\"2202\",\"2600\",\"2601\",\"7b14af9e9fbff286856338a194422b07\",\"ef2382c0cc2d99ee73444e684237a88a\",\"06874adacf1f272be7928badd4fe8ed1\",\"6e3f89cda84ac2c6e715e7812c102ae8\",\"0d0be247863fcbf08b3db943e5f45992\",\"92f78825551a22fa130c03066f398448\",\"f15e2186907d22765cd149a94905842a\",\"c0ba37c10abaecd89a738c5cf2a2fd24\",\"34dae0db3f9c97482d598f964bd4c9c7\",\"2500\",\"a18b33e15bde209a3c9115517c56d9ec\",\"97722c6d56c8b9990cc3c1a6eea3d6bb\",\"bb9dd4b7a2a462193d0f01517308f812\",\"e710a66583fe0e324492462adb16014e\",\"247071d42ff40267c8d8c44eac92da67\",\"52715698214e88cb09fa4dd1ea5ad348\",\"b961670cbf3454f5927c4bd2a327e915\",\"caaec41413c5713c6f290efe08c11415\",\"e086c4aa4943a883b29cf94680608b89\",\"e5ea38c1f97dee0043e78f3fb27b25d6\"],\"deptIdList\":[\"8\"]}', '73', 1, 0, NULL, '1', '2019-08-11 14:38:23.231', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (221, '新增/编辑角色', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36', '/a/sys/role', 'POST', '{\"id\":\"1\",\"delFlag\":\"0\",\"createdBy\":\"\",\"createdDate\":\"2017-10-29 15:45:51\",\"lastModifiedBy\":\"1\",\"version\":49,\"lastModifiedDate\":\"2019-08-11 14:38:23\",\"description\":null,\"availableText\":\"是\",\"available\":\"1\",\"dataScopeText\":\"全部\",\"dataScope\":\"1\",\"name\":\"管理员\",\"code\":\"ROLE_ADMIN\",\"remark\":\"管理员\",\"menuIdList\":[\"1000\",\"1100\",\"1a900c3f10ef5b0987e0a8ee4445316d\",\"1101\",\"1102\",\"1103\",\"bd62904371247f56594741ff8e9bded9\",\"1200\",\"1201\",\"1202\",\"1203\",\"94b57a562063d103423e2c6125cb30ad\",\"1300\",\"1301\",\"1302\",\"1303\",\"1304\",\"1400\",\"1401\",\"1402\",\"1403\",\"2000\",\"2100\",\"13093fb658c1806ad5bd0600316158f2\",\"2101\",\"d4c16faad8f883650a3a8eab829ebad9\",\"2200\",\"2201\",\"2202\",\"2600\",\"2601\",\"7b14af9e9fbff286856338a194422b07\",\"ef2382c0cc2d99ee73444e684237a88a\",\"06874adacf1f272be7928badd4fe8ed1\",\"6e3f89cda84ac2c6e715e7812c102ae8\",\"0d0be247863fcbf08b3db943e5f45992\",\"92f78825551a22fa130c03066f398448\",\"f15e2186907d22765cd149a94905842a\",\"c0ba37c10abaecd89a738c5cf2a2fd24\",\"34dae0db3f9c97482d598f964bd4c9c7\",\"2500\",\"413892fe8d52c1163d6659f51299dc96\",\"8d3517427e527df11d51da528261c915\",\"e590df103d3382d3091eae818f68626b\",\"2836ced373377be75936827ecddf7fad\",\"2af0268f695b79abdf6e8b10d559d081\",\"a18b33e15bde209a3c9115517c56d9ec\",\"97722c6d56c8b9990cc3c1a6eea3d6bb\",\"bb9dd4b7a2a462193d0f01517308f812\",\"e710a66583fe0e324492462adb16014e\",\"247071d42ff40267c8d8c44eac92da67\",\"52715698214e88cb09fa4dd1ea5ad348\",\"b961670cbf3454f5927c4bd2a327e915\",\"caaec41413c5713c6f290efe08c11415\",\"e086c4aa4943a883b29cf94680608b89\",\"e5ea38c1f97dee0043e78f3fb27b25d6\"],\"deptIdList\":[\"8\"]}', '54', 1, 0, NULL, '1', '2019-08-11 14:38:28.406', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (222, '生成方案', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36', '/a/gen/scheme/gen-code', 'PUT', '{\"id\":\"de5eaba0d276a7adf5b9bbd25cb59833\",\"replaceFile\":true}', '458', 1, 7, NULL, '1', '2019-08-11 14:40:23.283', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (223, '新增/编辑测试树', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36', '/a/test/test-tree-book/', 'POST', '{\"name\":\"11\",\"sort\":\"11\",\"author\":\"11\",\"email\":\"\",\"phone\":\"\",\"activated\":\"1\",\"number\":\"\",\"money\":\"\",\"amount\":\"\",\"resetDate\":\"\",\"description\":\"\"}', '41', 1, 0, NULL, '1', '2019-08-11 14:41:21.746', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (224, '新增/编辑测试树', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36', '/a/test/test-tree-book/', 'POST', '{\"name\":\"2\",\"sort\":\"2\",\"author\":\"2\",\"email\":\"\",\"phone\":\"\",\"activated\":\"1\",\"number\":\"\",\"money\":\"\",\"amount\":\"\",\"resetDate\":\"\",\"description\":\"\",\"parentId\":\"06a31c9d796e76d348f6405d95c5f0ed\",\"parentName\":\"11\"}', '25', 1, 0, NULL, '1', '2019-08-11 14:41:36.576', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (225, '生成方案', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36', '/a/gen/scheme/gen-code', 'PUT', '{\"id\":\"de5eaba0d276a7adf5b9bbd25cb59833\",\"replaceFile\":true}', '176', 1, 7, NULL, '1', '2019-08-11 14:43:01.824', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (226, '生成方案', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36', '/a/gen/scheme/gen-code', 'PUT', '{\"id\":\"de5eaba0d276a7adf5b9bbd25cb59833\",\"replaceFile\":true}', '193', 1, 7, NULL, '1', '2019-08-11 14:43:21.633', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (227, '新增/编辑测试树', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36', '/a/test/test-tree-book/', 'POST', '{\"id\":\"3684a7c2536585d8a8628a4062a6c98e\",\"delFlag\":\"0\",\"createdBy\":\"1\",\"createdDate\":\"2019-08-11 14:41:36\",\"lastModifiedBy\":\"1\",\"version\":0,\"lastModifiedDate\":\"2019-08-11 14:41:36\",\"description\":\"\",\"name\":\"2\",\"parentId\":\"06a31c9d796e76d348f6405d95c5f0ed\",\"parentIds\":\"06a31c9d796e76d348f6405d95c5f0ed,\",\"sort\":2,\"parentName\":\"11\",\"leaf\":true,\"author\":\"2\",\"email\":\"\",\"phone\":\"\",\"activated\":1,\"number\":null,\"money\":null,\"amount\":null,\"resetDate\":null}', '28', 1, 0, NULL, '1', '2019-08-11 14:43:41.686', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (228, '删除测试树', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36', '/a/test/test-tree-book/3684a7c2536585d8a8628a4062a6c98e', 'DELETE', '', '20', 1, 0, NULL, '1', '2019-08-11 14:43:44.777', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (229, '菜单管理', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36', '/a/sys/menu/2836ced373377be75936827ecddf7fad', 'DELETE', '', '17', 1, 3, NULL, '1', '2019-08-11 14:43:59.819', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (230, '菜单管理', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36', '/a/sys/menu/2af0268f695b79abdf6e8b10d559d081', 'DELETE', '', '13', 1, 3, NULL, '1', '2019-08-11 14:44:03.792', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (231, '菜单管理', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36', '/a/sys/menu/e590df103d3382d3091eae818f68626b', 'DELETE', '', '13', 1, 3, NULL, '1', '2019-08-11 14:44:05.492', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (232, '菜单管理', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36', '/a/sys/menu/8d3517427e527df11d51da528261c915', 'DELETE', '', '10', 1, 3, NULL, '1', '2019-08-11 14:44:10.271', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (233, '新增/编辑角色', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36', '/a/sys/role', 'POST', '{\"id\":\"1\",\"delFlag\":\"0\",\"createdBy\":\"\",\"createdDate\":\"2017-10-29 15:45:51\",\"lastModifiedBy\":\"1\",\"version\":50,\"lastModifiedDate\":\"2019-08-11 14:38:28\",\"description\":null,\"availableText\":\"是\",\"available\":\"1\",\"dataScopeText\":\"全部\",\"dataScope\":\"1\",\"name\":\"管理员\",\"code\":\"ROLE_ADMIN\",\"remark\":\"管理员\",\"menuIdList\":[\"06874adacf1f272be7928badd4fe8ed1\",\"0d0be247863fcbf08b3db943e5f45992\",\"1000\",\"1100\",\"1101\",\"1102\",\"1103\",\"1200\",\"1201\",\"1202\",\"1203\",\"1300\",\"1301\",\"1302\",\"1303\",\"1304\",\"13093fb658c1806ad5bd0600316158f2\",\"1400\",\"1401\",\"1402\",\"1403\",\"1a900c3f10ef5b0987e0a8ee4445316d\",\"2000\",\"2100\",\"2101\",\"2200\",\"2201\",\"2202\",\"247071d42ff40267c8d8c44eac92da67\",\"2500\",\"2600\",\"2601\",\"34dae0db3f9c97482d598f964bd4c9c7\",\"413892fe8d52c1163d6659f51299dc96\",\"52715698214e88cb09fa4dd1ea5ad348\",\"6e3f89cda84ac2c6e715e7812c102ae8\",\"7b14af9e9fbff286856338a194422b07\",\"92f78825551a22fa130c03066f398448\",\"94b57a562063d103423e2c6125cb30ad\",\"97722c6d56c8b9990cc3c1a6eea3d6bb\",\"a18b33e15bde209a3c9115517c56d9ec\",\"b961670cbf3454f5927c4bd2a327e915\",\"bb9dd4b7a2a462193d0f01517308f812\",\"bd62904371247f56594741ff8e9bded9\",\"c0ba37c10abaecd89a738c5cf2a2fd24\",\"caaec41413c5713c6f290efe08c11415\",\"d4c16faad8f883650a3a8eab829ebad9\",\"e086c4aa4943a883b29cf94680608b89\",\"e5ea38c1f97dee0043e78f3fb27b25d6\",\"e710a66583fe0e324492462adb16014e\",\"ef2382c0cc2d99ee73444e684237a88a\",\"f15e2186907d22765cd149a94905842a\"],\"deptIdList\":[\"8\"]}', '46', 1, 0, NULL, '1', '2019-08-11 14:44:17.185', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (234, '操作日志', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36', '/a/sys/log-operate/export', 'GET', '', '561', 1, 5, NULL, '1', '2019-08-11 14:46:57.877', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (235, '操作日志', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36', '/a/sys/log-operate/export', 'GET', '', '30911', 1, 4, NULL, '1', '2019-08-11 14:54:14.207', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (236, '操作日志', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36', '/a/sys/log-operate/export', 'GET', '', '48626', 1, 4, NULL, '1', '2019-08-11 14:55:15.743', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (237, '操作日志', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36', '/a/sys/log-operate/export', 'GET', '', '42', 1, 4, NULL, '1', '2019-08-11 14:56:09.530', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (238, '操作日志', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36', '/a/sys/log-operate/export', 'GET', '', '46375', 1, 4, NULL, '1', '2019-08-11 14:56:40.163', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (239, '操作日志', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36', '/a/sys/log-operate/export', 'GET', '', '42', 1, 4, NULL, '1', '2019-08-11 14:57:35.995', NULL, '0');

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
INSERT INTO `sys_menu` VALUES ('06874adacf1f272be7928badd4fe8ed1', '配置日志', NULL, 'log', 'ef2382c0cc2d99ee73444e684237a88a', 'ef2382c0cc2d99ee73444e684237a88a,', 'icon-read', 'views/admin/log/index', '0', '1', '0', b'1', 30, '1', '2019-08-05 16:16:06.000', '1', '2019-08-17 14:13:15.046', NULL, 1, '1');
INSERT INTO `sys_menu` VALUES ('0d0be247863fcbf08b3db943e5f45992', '在线用户查看', 'sys_userOnline_view', NULL, '6e3f89cda84ac2c6e715e7812c102ae8', 'ef2382c0cc2d99ee73444e684237a88a,6e3f89cda84ac2c6e715e7812c102ae8,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-08-07 09:05:28.000', '1', '2019-08-11 16:44:23.605', NULL, 1, '1');
INSERT INTO `sys_menu` VALUES ('1000', '权限管理', NULL, '/upms', '-1', NULL, 'icon-quanxianguanli', 'Layout', '0', '1', '0', b'0', 10, '', '2018-09-28 08:29:53.000', '1', '2019-08-11 10:42:49.232', NULL, 9, '0');
INSERT INTO `sys_menu` VALUES ('1100', '用户管理', NULL, 'user', '1000', '1000,', 'icon-yonghuguanli', 'views/sys/user/index', '0', '1', '0', b'0', 1, '', '2017-11-02 22:24:37.000', '1', '2019-08-09 10:55:47.702', NULL, 7, '0');
INSERT INTO `sys_menu` VALUES ('1101', '用户编辑', 'sys_user_edit', NULL, '1100', NULL, NULL, NULL, '0', '1', '1', b'0', 30, '', '2017-11-08 09:52:09.000', NULL, '2019-08-08 13:23:14.225', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1102', '用户锁定', 'sys_user_lock', NULL, '1100', NULL, NULL, NULL, '0', '1', '1', b'0', 30, '', '2017-11-08 09:52:48.000', NULL, '2019-08-08 13:23:14.228', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1103', '用户删除', 'sys_user_del', NULL, '1100', NULL, NULL, NULL, '0', '1', '1', b'0', 30, '', '2017-11-08 09:54:01.000', NULL, '2019-08-08 13:23:14.231', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1200', '菜单管理', NULL, 'menu', '1000', '1000,', 'icon-caidanguanli', 'views/sys/menu/index', '0', '1', '0', b'0', 2, '', '2017-11-08 09:57:27.000', '1', '2019-08-09 10:57:24.053', NULL, 3, '0');
INSERT INTO `sys_menu` VALUES ('1201', '菜单编辑', 'sys_menu_edit', NULL, '1200', NULL, NULL, NULL, '0', '1', '1', b'0', 30, '', '2017-11-08 10:15:53.000', NULL, '2019-08-08 13:23:14.233', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1202', '菜单锁定', 'sys_menu_lock', NULL, '1200', NULL, NULL, NULL, '0', '1', '1', b'0', 30, '', '2017-11-08 10:16:23.000', NULL, '2019-08-08 13:23:14.235', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1203', '菜单删除', 'sys_menu_del', NULL, '1200', NULL, NULL, NULL, '0', '1', '1', b'0', 30, '', '2017-11-08 10:16:43.000', NULL, '2019-08-08 13:23:14.238', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1300', '角色管理', NULL, 'role', '1000', '1000,', 'icon-jiaoseguanli', 'views/sys/role/index', '0', '1', '0', b'0', 3, '', '2017-11-08 10:13:37.000', '1', '2019-08-07 17:28:17.000', NULL, 2, '0');
INSERT INTO `sys_menu` VALUES ('1301', '角色编辑', 'sys_role_edit', NULL, '1300', NULL, NULL, NULL, '0', '1', '1', b'0', 30, '', '2017-11-08 10:14:18.000', NULL, '2019-08-08 13:23:14.241', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1302', '角色锁定', 'sys_role_lock', NULL, '1300', NULL, NULL, NULL, '0', '1', '1', b'0', 30, '', '2017-11-08 10:14:41.000', NULL, '2019-08-08 13:23:14.243', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1303', '角色删除', 'sys_role_del', NULL, '1300', NULL, NULL, NULL, '0', '1', '1', b'0', 30, '', '2017-11-08 10:14:59.000', NULL, '2019-08-08 13:23:14.245', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1304', '角色查看', 'sys_role_view', NULL, '1300', '1300,', NULL, NULL, '0', '1', '1', b'1', 30, '', '2018-04-20 07:22:55.000', '1', '2019-08-07 17:28:17.093', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('13093fb658c1806ad5bd0600316158f2', '操作日志导出', 'sys_logOperate_export', NULL, '2100', '2000,2100,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-08-07 17:50:46.973', '1', '2019-08-08 15:06:52.841', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('1400', '部门管理', NULL, 'dept', '1000', NULL, 'icon-web-icon-', 'views/sys/dept/index', '0', '1', '0', b'0', 4, '', '2018-01-20 13:17:19.000', NULL, '2019-07-26 13:36:40.740', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1401', '部门编辑', 'sys_dept_edit', NULL, '1400', NULL, NULL, NULL, '0', '1', '1', b'0', 30, '', '2018-01-20 14:56:16.000', NULL, '2019-08-08 13:23:14.247', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1402', '部门锁定', 'sys_dept_lock', NULL, '1400', NULL, NULL, NULL, '0', '1', '1', b'0', 30, '', '2018-01-20 14:56:59.000', NULL, '2019-08-08 13:23:14.249', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1403', '部门删除', 'sys_dept_del', NULL, '1400', NULL, NULL, NULL, '0', '1', '1', b'0', 30, '', '2018-01-20 14:57:28.000', NULL, '2019-08-08 13:23:14.251', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1a900c3f10ef5b0987e0a8ee4445316d', '用户查看', 'sys_user_view', NULL, '1100', '1000,1100,', NULL, NULL, '0', '1', '1', b'1', 10, '1', '2019-08-07 17:27:34.000', '1', '2019-08-09 10:55:47.709', NULL, 3, '0');
INSERT INTO `sys_menu` VALUES ('2000', '系统管理', NULL, '/sys', '-1', NULL, 'icon-xitongguanli', 'Layout', '0', '1', '0', b'0', 20, '', '2017-11-07 20:56:00.000', '1', '2019-08-11 16:50:05.967', NULL, 10, '0');
INSERT INTO `sys_menu` VALUES ('2100', '操作日志', NULL, 'log-operate', '2000', '2000,', 'icon-rizhiguanli', 'views/sys/log-operate/index', '0', '1', '0', b'0', 5, '', '2017-11-20 14:06:22.000', '1', '2019-08-08 15:06:52.834', NULL, 5, '0');
INSERT INTO `sys_menu` VALUES ('2101', '操作日志删除', 'sys_logOperate_del', NULL, '2100', '2000,2100,', NULL, NULL, '0', '1', '1', b'1', 30, '', '2017-11-20 20:37:37.000', '1', '2019-08-08 15:06:52.843', NULL, 2, '0');
INSERT INTO `sys_menu` VALUES ('2200', '字典管理', NULL, 'dict', '2000', NULL, 'icon-navicon-zdgl', 'views/sys/dict/index', '0', '1', '0', b'0', 6, '', '2017-11-29 11:30:52.000', NULL, '2019-07-26 13:36:48.667', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('2201', '字典删除', 'sys_dict_del', NULL, '2200', NULL, NULL, NULL, '0', '1', '1', b'0', 30, '', '2017-11-29 11:30:11.000', NULL, '2019-08-08 13:23:14.253', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('2202', '字典编辑', 'sys_dict_edit', NULL, '2200', NULL, NULL, NULL, '0', '1', '1', b'0', 30, '', '2018-05-11 22:34:55.000', NULL, '2019-08-08 13:23:14.256', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('247071d42ff40267c8d8c44eac92da67', '生成方案', NULL, 'scheme', '413892fe8d52c1163d6659f51299dc96', '413892fe8d52c1163d6659f51299dc96,', 'icon-appstore', 'views/gen/scheme/index', '0', '1', '0', b'0', 40, '1', '2019-07-21 13:27:35.000', '1', '2019-08-11 09:20:09.072', NULL, 18, '0');
INSERT INTO `sys_menu` VALUES ('2500', '服务接口', NULL, 'http://albedo-gateway:9999/swagger-ui.html', 'ef2382c0cc2d99ee73444e684237a88a', 'ef2382c0cc2d99ee73444e684237a88a,', 'icon-server', NULL, '0', '1', '0', b'1', 500, '', '2018-06-26 10:50:32.000', '1', '2019-08-11 16:44:57.184', NULL, 6, '0');
INSERT INTO `sys_menu` VALUES ('2600', '令牌管理', NULL, 'token', '2000', '2000,', 'icon-denglvlingpai', 'views/sys/token/index', '0', '1', '0', b'0', 11, '', '2018-09-04 05:58:41.000', '1', '2019-08-11 17:36:03.482', NULL, 8, '0');
INSERT INTO `sys_menu` VALUES ('2601', '令牌删除', 'sys_token_del', NULL, '2600', '2000,2600,', NULL, NULL, '0', '1', '1', b'1', 1, '', '2018-09-04 05:59:50.000', '1', '2019-08-11 17:35:57.367', NULL, 5, '0');
INSERT INTO `sys_menu` VALUES ('2836ced373377be75936827ecddf7fad', '测试树管理编辑', 'test_testTreeBook_edit', NULL, '8d3517427e527df11d51da528261c915', NULL, NULL, NULL, '0', '1', '1', b'0', 40, '1', '2019-08-11 14:32:06.856', '1', '2019-08-11 14:43:59.833', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('2af0268f695b79abdf6e8b10d559d081', '测试树管理删除', 'test_testTreeBook_del', NULL, '8d3517427e527df11d51da528261c915', NULL, NULL, NULL, '0', '1', '1', b'0', 80, '1', '2019-08-11 14:32:06.859', '1', '2019-08-11 14:44:03.802', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('34dae0db3f9c97482d598f964bd4c9c7', '配置管理', NULL, 'configuration', 'ef2382c0cc2d99ee73444e684237a88a', 'ef2382c0cc2d99ee73444e684237a88a,', 'icon-slack', 'views/admin/configuration/index', '0', '1', '0', b'1', 50, '1', '2019-08-05 17:46:50.000', '1', '2019-08-17 14:13:17.960', NULL, 1, '1');
INSERT INTO `sys_menu` VALUES ('413892fe8d52c1163d6659f51299dc96', '代码生成', NULL, '/gen', '-1', NULL, 'icon-weibiaoti46', 'Layout', '0', '1', '0', b'0', 100, '1', '2019-07-20 12:00:48.000', '1', '2019-08-11 08:49:50.093', NULL, 21, '0');
INSERT INTO `sys_menu` VALUES ('52715698214e88cb09fa4dd1ea5ad348', '生成方案菜单', 'gen_scheme_menu', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-07-25 13:03:03.000', '1', '2019-08-11 09:20:09.081', NULL, 6, '0');
INSERT INTO `sys_menu` VALUES ('6e3f89cda84ac2c6e715e7812c102ae8', '在线用户', '', 'online-user', 'ef2382c0cc2d99ee73444e684237a88a', 'ef2382c0cc2d99ee73444e684237a88a,', 'icon-team', 'views/admin/online-user/index', '0', '1', '0', b'0', 30, '1', '2019-08-07 09:03:52.000', '1', '2019-08-11 16:45:02.964', NULL, 5, '1');
INSERT INTO `sys_menu` VALUES ('7b14af9e9fbff286856338a194422b07', '令牌查看', 'sys_token_view', NULL, '2600', '2000,2600,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-08-08 09:44:25.000', '1', '2019-08-11 17:36:03.491', NULL, 3, '0');
INSERT INTO `sys_menu` VALUES ('825f7504bb7932eec7b19716c9afea0f', '服务监控', NULL, 'http://localhost:5001', 'ef2382c0cc2d99ee73444e684237a88a', 'ef2382c0cc2d99ee73444e684237a88a,', 'icon-monitor', NULL, '0', '1', '0', b'1', 30, '1', '2019-08-11 17:39:04.000', '1', '2019-08-11 17:40:41.086', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('8d3517427e527df11d51da528261c915', '测试树管理', NULL, 'test-tree-book', '413892fe8d52c1163d6659f51299dc96', NULL, 'icon-right-square', 'views/test/test-tree-book/index', '0', '1', '0', b'0', 30, '1', '2019-08-11 14:32:06.849', '1', '2019-08-11 14:44:10.280', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('92f78825551a22fa130c03066f398448', '在线用户删除', 'sys_userOnline_del', NULL, '6e3f89cda84ac2c6e715e7812c102ae8', 'ef2382c0cc2d99ee73444e684237a88a,6e3f89cda84ac2c6e715e7812c102ae8,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-08-07 09:06:33.448', '1', '2019-08-11 16:44:27.263', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('94b57a562063d103423e2c6125cb30ad', '菜单查看', 'sys_menu_view', NULL, '1200', '1200,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-08-07 17:27:59.697', '1', '2019-08-09 10:57:24.065', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('97722c6d56c8b9990cc3c1a6eea3d6bb', '业务表编辑', 'gen_table_edit', 'edit', 'a18b33e15bde209a3c9115517c56d9ec', '413892fe8d52c1163d6659f51299dc96,a18b33e15bde209a3c9115517c56d9ec,', NULL, 'views/gen/table/edit', '0', '1', '2', b'1', 30, '1', '2019-07-21 13:24:02.000', '1', '2019-08-08 15:21:18.115', NULL, 5, '0');
INSERT INTO `sys_menu` VALUES ('a18b33e15bde209a3c9115517c56d9ec', '业务表', '', 'table', '413892fe8d52c1163d6659f51299dc96', '413892fe8d52c1163d6659f51299dc96,', 'icon-table', 'views/gen/table/index', '0', '1', '0', b'0', 30, '1', '2019-07-20 12:02:02.000', '1', '2019-08-11 08:47:39.824', NULL, 17, '0');
INSERT INTO `sys_menu` VALUES ('b961670cbf3454f5927c4bd2a327e915', '生成方案删除', 'gen_scheme_del', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-07-21 13:30:18.000', '1', '2019-08-11 08:50:09.304', NULL, 6, '0');
INSERT INTO `sys_menu` VALUES ('bb9dd4b7a2a462193d0f01517308f812', '业务表查看', 'gen_table_view', NULL, 'a18b33e15bde209a3c9115517c56d9ec', '413892fe8d52c1163d6659f51299dc96,a18b33e15bde209a3c9115517c56d9ec,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-08-11 08:47:39.828', '1', '2019-08-11 08:47:39.828', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('bd62904371247f56594741ff8e9bded9', '用户管理导入', 'sys_user_import', NULL, '1100', '1000,1100,', NULL, NULL, '0', '1', '1', b'1', 80, '1', '2019-08-07 17:50:02.000', '1', '2019-08-09 10:55:47.711', NULL, 3, '0');
INSERT INTO `sys_menu` VALUES ('c0ba37c10abaecd89a738c5cf2a2fd24', '服务状态', NULL, 'health', 'ef2382c0cc2d99ee73444e684237a88a', 'ef2382c0cc2d99ee73444e684237a88a,', 'icon-boxplot', 'views/admin/health/index', '0', '1', '0', b'1', 40, '1', '2019-08-05 17:21:10.000', '1', '2019-08-17 14:13:22.779', NULL, 2, '1');
INSERT INTO `sys_menu` VALUES ('caaec41413c5713c6f290efe08c11415', '生成方案查看', 'gen_scheme_view', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-08-11 08:48:09.000', '1', '2019-08-11 08:50:16.065', NULL, 3, '0');
INSERT INTO `sys_menu` VALUES ('d4c16faad8f883650a3a8eab829ebad9', '操作日志查看', 'sys_logOperate_view', NULL, '2100', '2000,2100,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-08-07 17:51:38.454', '1', '2019-08-08 15:06:52.844', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('e086c4aa4943a883b29cf94680608b89', '生成方案代码', 'gen_scheme_code', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-08-11 08:55:37.000', '1', '2019-08-11 09:19:50.418', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('e590df103d3382d3091eae818f68626b', '测试树管理查看', 'test_testTreeBook_view', NULL, '8d3517427e527df11d51da528261c915', NULL, NULL, NULL, '0', '1', '1', b'0', 20, '1', '2019-08-11 14:32:06.853', '1', '2019-08-11 14:44:05.503', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('e5ea38c1f97dee0043e78f3fb27b25d6', '生成方案编辑', 'gen_scheme_edit', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-07-21 13:29:14.000', '1', '2019-08-05 15:54:01.914', NULL, 4, '0');
INSERT INTO `sys_menu` VALUES ('e710a66583fe0e324492462adb16014e', '业务表删除', 'gen_table_del', NULL, 'a18b33e15bde209a3c9115517c56d9ec', '413892fe8d52c1163d6659f51299dc96,a18b33e15bde209a3c9115517c56d9ec,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-07-21 13:24:45.000', '1', '2019-07-25 13:32:11.051', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('ef2382c0cc2d99ee73444e684237a88a', '资源管理', NULL, '/admin', '-1', NULL, 'icon-barchart', 'Layout', '0', '1', '0', b'0', 30, '1', '2019-08-05 15:58:12.000', '1', '2019-08-11 17:40:41.078', NULL, 19, '0');
INSERT INTO `sys_menu` VALUES ('f15e2186907d22765cd149a94905842a', '在线用户强退', 'sys_userOnline_logout', NULL, '6e3f89cda84ac2c6e715e7812c102ae8', 'ef2382c0cc2d99ee73444e684237a88a,6e3f89cda84ac2c6e715e7812c102ae8,', NULL, NULL, '0', '1', '1', b'1', 30, '1', '2019-08-11 10:57:51.502', '1', '2019-08-11 16:44:29.411', NULL, 0, '1');

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
  `available` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '1' COMMENT '1-正常，0-锁定',
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
INSERT INTO `sys_role` VALUES ('1', '管理员', 'ROLE_ADMIN', '管理员', '1', '1', '', '2017-10-29 15:45:51.000', '1', '2019-08-17 14:13:29.798', NULL, 54, '0');
INSERT INTO `sys_role` VALUES ('2', 'ROLE_CQQ', 'ROLE_CQQ', 'ROLE_CQQ', '5', '1', '', '2018-11-11 19:42:26.000', '1', '2019-08-07 18:00:54.000', NULL, 8, '0');

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
INSERT INTO `sys_role_dept` VALUES ('067f6ef72da05584b6a2fadf9e148bd7', '2', '1');
INSERT INTO `sys_role_dept` VALUES ('239cec91e90626a61f9d8032325093fe', '2', '3');
INSERT INTO `sys_role_dept` VALUES ('39b406c21b50fd62276c923205923675', '1', '8');
INSERT INTO `sys_role_dept` VALUES ('92d988094cded15b88e112f168ca3f9b', '2', '4');
INSERT INTO `sys_role_dept` VALUES ('dc7028df1d55ae7e0b3044d493643b0c', '2', '5');

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
INSERT INTO `sys_role_menu` VALUES ('1', '13093fb658c1806ad5bd0600316158f2');
INSERT INTO `sys_role_menu` VALUES ('1', '1400');
INSERT INTO `sys_role_menu` VALUES ('1', '1401');
INSERT INTO `sys_role_menu` VALUES ('1', '1402');
INSERT INTO `sys_role_menu` VALUES ('1', '1403');
INSERT INTO `sys_role_menu` VALUES ('1', '1a900c3f10ef5b0987e0a8ee4445316d');
INSERT INTO `sys_role_menu` VALUES ('1', '2000');
INSERT INTO `sys_role_menu` VALUES ('1', '2100');
INSERT INTO `sys_role_menu` VALUES ('1', '2101');
INSERT INTO `sys_role_menu` VALUES ('1', '2200');
INSERT INTO `sys_role_menu` VALUES ('1', '2201');
INSERT INTO `sys_role_menu` VALUES ('1', '2202');
INSERT INTO `sys_role_menu` VALUES ('1', '247071d42ff40267c8d8c44eac92da67');
INSERT INTO `sys_role_menu` VALUES ('1', '2500');
INSERT INTO `sys_role_menu` VALUES ('1', '2600');
INSERT INTO `sys_role_menu` VALUES ('1', '2601');
INSERT INTO `sys_role_menu` VALUES ('1', '413892fe8d52c1163d6659f51299dc96');
INSERT INTO `sys_role_menu` VALUES ('1', '52715698214e88cb09fa4dd1ea5ad348');
INSERT INTO `sys_role_menu` VALUES ('1', '7b14af9e9fbff286856338a194422b07');
INSERT INTO `sys_role_menu` VALUES ('1', '825f7504bb7932eec7b19716c9afea0f');
INSERT INTO `sys_role_menu` VALUES ('1', '94b57a562063d103423e2c6125cb30ad');
INSERT INTO `sys_role_menu` VALUES ('1', '97722c6d56c8b9990cc3c1a6eea3d6bb');
INSERT INTO `sys_role_menu` VALUES ('1', 'a18b33e15bde209a3c9115517c56d9ec');
INSERT INTO `sys_role_menu` VALUES ('1', 'b961670cbf3454f5927c4bd2a327e915');
INSERT INTO `sys_role_menu` VALUES ('1', 'bb9dd4b7a2a462193d0f01517308f812');
INSERT INTO `sys_role_menu` VALUES ('1', 'bd62904371247f56594741ff8e9bded9');
INSERT INTO `sys_role_menu` VALUES ('1', 'caaec41413c5713c6f290efe08c11415');
INSERT INTO `sys_role_menu` VALUES ('1', 'd4c16faad8f883650a3a8eab829ebad9');
INSERT INTO `sys_role_menu` VALUES ('1', 'e086c4aa4943a883b29cf94680608b89');
INSERT INTO `sys_role_menu` VALUES ('1', 'e5ea38c1f97dee0043e78f3fb27b25d6');
INSERT INTO `sys_role_menu` VALUES ('1', 'e710a66583fe0e324492462adb16014e');
INSERT INTO `sys_role_menu` VALUES ('1', 'ef2382c0cc2d99ee73444e684237a88a');
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
  `available` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '1' COMMENT '1-正常，0-锁定',
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
INSERT INTO `sys_user` VALUES ('1', 'admin', '$2a$10$81JhU58/uM.JmWKiCAcxoOiSS///NT6rXbSRATa.UgGG8stlA1ABy', NULL, '17034642999', NULL, '', '1', NULL, 'o_0FT0uyg_H1vVy2H0JpSwlVGhWQ', '1', '', '2018-04-20 07:15:18.000', '1', '2019-08-11 17:31:05.678', NULL, 9, '0');
INSERT INTO `sys_user` VALUES ('53fb3761bdd95ed3d03f4a07f78ea0eb', 'dsafdf', '$2a$10$81JhU58/uM.JmWKiCAcxoOiSS///NT6rXbSRATa.UgGG8stlA1ABy', NULL, '12343543432', '837158@qq.com', NULL, '3', NULL, NULL, '1', '1', '2019-07-07 14:32:17.000', '1', '2019-07-13 01:38:33.000', NULL, 19, '1');
INSERT INTO `sys_user` VALUES ('90da0206c39867a1b36ac36ced80c1a9', 'test', '$2a$10$NmGuhLe7ODgRC0cwHPa0IuJh94uFYGrAMCyndqMwX07s.CH18RmlS', NULL, NULL, NULL, NULL, '3', NULL, NULL, '1', '1', '2019-07-07 14:35:13.000', '1', '2019-08-11 17:35:37.062', NULL, 37, '0');

-- ----------------------------
-- Table structure for sys_user_online
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_online`;
CREATE TABLE `sys_user_online`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `session_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户会话id',
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '登录ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录账号',
  `dept_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门ID',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `ip_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'IP',
  `ip_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'IP地址',
  `user_agent` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户代理',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '在线状态on_line在线off_line离线',
  `start_timestamp` datetime(0) NULL DEFAULT NULL COMMENT 'session创建时间',
  `last_access_time` datetime(0) NULL DEFAULT NULL COMMENT 'session最后访问时间',
  `expire_time` int(5) NULL DEFAULT 0 COMMENT '超时时间，单位为分钟',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '在线用户记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_online
-- ----------------------------
INSERT INTO `sys_user_online` VALUES ('2bbb8f598defbad04ec9228fb5459618', 'sU2KCmqXBvf3gMyFdFjxhiPJP5rAouNVlPP_YFEq', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2019-08-11 14:40:29', '2019-08-11 14:48:56', 1800, '0');
INSERT INTO `sys_user_online` VALUES ('58d412adc195f0acf1a8ffa9862ebd08', 'gu0ZkNLVcEqTnpk7R-pqhsTrim1Y0YCG-73cY1Z_', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2019-08-11 14:38:13', '2019-08-11 14:40:26', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('6e32f5d8292f31b6de8da4764d507b12', 'iV9_ltjWdrzcuX-xJqFoOIeMOWlLA8LRWTIXNORU', '1', 'admin', '1', '山东农信', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36', 'Chrome', 'Windows 10 or Windows Server 2016', 'on_line', '2019-08-11 14:54:10', '2019-08-11 14:57:36', 1800, '1');

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
-- Records of zipkin_annotations
-- ----------------------------
INSERT INTO `zipkin_annotations` VALUES (0, 272343372844899494, -3028944364851724551, 'cs', NULL, -1, 1564126875798069, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 272343372844899494, -3028944364851724551, 'cr', NULL, -1, 1564126875809732, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 272343372844899494, -3028944364851724551, 'http.method', 0x504F5354, 6, 1564126875798069, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 272343372844899494, -3028944364851724551, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1564126875798069, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 272343372844899494, 8650847360064451318, 'sr', NULL, -1, 1564126875787087, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 272343372844899494, 8650847360064451318, 'ss', NULL, -1, 1564126875832472, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 272343372844899494, 8650847360064451318, 'ca', 0x01, 0, 1564126875787087, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, 272343372844899494, 8650847360064451318, 'http.method', 0x474554, 6, 1564126875787087, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 272343372844899494, 8650847360064451318, 'http.path', 0x2F6C6F672F, 6, 1564126875787087, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 272343372844899494, 8650847360064451318, 'mvc.controller.class', 0x4C6F675265736F75726365, 6, 1564126875787087, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 272343372844899494, 8650847360064451318, 'mvc.controller.method', 0x67657450616765, 6, 1564126875787087, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -2563163435213653073, -2340382440083905913, 'cs', NULL, -1, 1564127042307045, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -2563163435213653073, -2340382440083905913, 'cr', NULL, -1, 1564127042313844, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -2563163435213653073, -2340382440083905913, 'http.method', 0x504F5354, 6, 1564127042307045, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -2563163435213653073, -2340382440083905913, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1564127042307045, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -2563163435213653073, -3109682506393738710, 'sr', NULL, -1, 1564127042304040, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -2563163435213653073, -3109682506393738710, 'ss', NULL, -1, 1564127042369467, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -2563163435213653073, -3109682506393738710, 'ca', 0x01, 0, 1564127042304040, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, -2563163435213653073, -3109682506393738710, 'http.method', 0x474554, 6, 1564127042304040, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -2563163435213653073, -3109682506393738710, 'http.path', 0x2F6D656E752F, 6, 1564127042304040, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -2563163435213653073, -3109682506393738710, 'mvc.controller.class', 0x4D656E755265736F75726365, 6, 1564127042304040, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -2563163435213653073, -3109682506393738710, 'mvc.controller.method', 0x67657450616765, 6, 1564127042304040, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -6158490369995999212, 582558505829247247, 'cs', NULL, -1, 1564127054021038, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -6158490369995999212, 582558505829247247, 'cr', NULL, -1, 1564127054032491, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -6158490369995999212, 582558505829247247, 'http.method', 0x504F5354, 6, 1564127054021038, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -6158490369995999212, 582558505829247247, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1564127054021038, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -6158490369995999212, 1917815909472501094, 'sr', NULL, -1, 1564127054018045, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -6158490369995999212, 1917815909472501094, 'ss', NULL, -1, 1564127054057881, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -6158490369995999212, 1917815909472501094, 'ca', 0x01, 0, 1564127054018045, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, -6158490369995999212, 1917815909472501094, 'http.method', 0x474554, 6, 1564127054018045, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -6158490369995999212, 1917815909472501094, 'http.path', 0x2F6D656E752F, 6, 1564127054018045, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -6158490369995999212, 1917815909472501094, 'mvc.controller.class', 0x4D656E755265736F75726365, 6, 1564127054018045, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -6158490369995999212, 1917815909472501094, 'mvc.controller.method', 0x67657450616765, 6, 1564127054018045, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6562926606632462282, -2279825729456383093, 'cs', NULL, -1, 1564127133294039, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6562926606632462282, -2279825729456383093, 'cr', NULL, -1, 1564127133301527, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6562926606632462282, -2279825729456383093, 'http.method', 0x504F5354, 6, 1564127133294039, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6562926606632462282, -2279825729456383093, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1564127133294039, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6562926606632462282, 8796924593109324980, 'sr', NULL, -1, 1564127133291040, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6562926606632462282, 8796924593109324980, 'ss', NULL, -1, 1564127133327789, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6562926606632462282, 8796924593109324980, 'ca', 0x01, 0, 1564127133291040, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, 6562926606632462282, 8796924593109324980, 'http.method', 0x474554, 6, 1564127133291040, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6562926606632462282, 8796924593109324980, 'http.path', 0x2F6D656E752F, 6, 1564127133291040, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6562926606632462282, 8796924593109324980, 'mvc.controller.class', 0x4D656E755265736F75726365, 6, 1564127133291040, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6562926606632462282, 8796924593109324980, 'mvc.controller.method', 0x67657450616765, 6, 1564127133291040, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -3021737358036785199, -4856311730907896364, 'cs', NULL, -1, 1564127136022057, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -3021737358036785199, -4856311730907896364, 'cr', NULL, -1, 1564127136030676, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -3021737358036785199, -4856311730907896364, 'http.method', 0x504F5354, 6, 1564127136022057, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -3021737358036785199, -4856311730907896364, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1564127136022057, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -3021737358036785199, -1630741176487065905, 'sr', NULL, -1, 1564127136017039, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -3021737358036785199, -1630741176487065905, 'ss', NULL, -1, 1564127136059154, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -3021737358036785199, -1630741176487065905, 'ca', 0x01, 0, 1564127136017039, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, -3021737358036785199, -1630741176487065905, 'http.method', 0x474554, 6, 1564127136017039, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -3021737358036785199, -1630741176487065905, 'http.path', 0x2F6D656E752F, 6, 1564127136017039, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -3021737358036785199, -1630741176487065905, 'mvc.controller.class', 0x4D656E755265736F75726365, 6, 1564127136017039, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -3021737358036785199, -1630741176487065905, 'mvc.controller.method', 0x67657450616765, 6, 1564127136017039, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -268161805056592825, -5574115193676832827, 'cs', NULL, -1, 1564127148935093, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -268161805056592825, -5574115193676832827, 'cr', NULL, -1, 1564127148943745, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -268161805056592825, -5574115193676832827, 'http.method', 0x504F5354, 6, 1564127148935093, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -268161805056592825, -5574115193676832827, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1564127148935093, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -268161805056592825, 2316860013070603731, 'sr', NULL, -1, 1564127148932062, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -268161805056592825, 2316860013070603731, 'ss', NULL, -1, 1564127148962969, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -268161805056592825, 2316860013070603731, 'ca', 0x01, 0, 1564127148932062, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, -268161805056592825, 2316860013070603731, 'http.method', 0x474554, 6, 1564127148932062, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -268161805056592825, 2316860013070603731, 'http.path', 0x2F6D656E752F, 6, 1564127148932062, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -268161805056592825, 2316860013070603731, 'mvc.controller.class', 0x4D656E755265736F75726365, 6, 1564127148932062, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -268161805056592825, 2316860013070603731, 'mvc.controller.method', 0x67657450616765, 6, 1564127148932062, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6911326512282472477, 6911326512282472477, 'lc', '', 6, 1564127280833000, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4778990109135373312, 6111860762014105667, 'cs', NULL, -1, 1564127452602389, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4778990109135373312, 6111860762014105667, 'cr', NULL, -1, 1564127452623370, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4778990109135373312, 6111860762014105667, 'http.method', 0x504F5354, 6, 1564127452602389, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4778990109135373312, 6111860762014105667, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1564127452602389, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4778990109135373312, 7190951313902771152, 'sr', NULL, -1, 1564127452592231, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4778990109135373312, 7190951313902771152, 'ss', NULL, -1, 1564127452855628, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4778990109135373312, 7190951313902771152, 'ca', 0x01, 0, 1564127452592231, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, 4778990109135373312, 7190951313902771152, 'http.method', 0x504F5354, 6, 1564127452592231, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4778990109135373312, 7190951313902771152, 'http.path', 0x2F6D656E752F, 6, 1564127452592231, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4778990109135373312, 7190951313902771152, 'mvc.controller.class', 0x4D656E755265736F75726365, 6, 1564127452592231, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4778990109135373312, 7190951313902771152, 'mvc.controller.method', 0x73617665, 6, 1564127452592231, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4778990109135373312, 1370163678030963890, 'sr', NULL, -1, 1564127453271910, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4778990109135373312, 1370163678030963890, 'ss', NULL, -1, 1564127453333828, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4778990109135373312, 1370163678030963890, 'ca', 0x01, 0, 1564127453271910, -1442926724, NULL, -11160, '');
INSERT INTO `zipkin_annotations` VALUES (0, 4778990109135373312, 1370163678030963890, 'http.method', 0x504F5354, 6, 1564127453271910, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4778990109135373312, 1370163678030963890, 'http.path', 0x2F6C6F672F, 6, 1564127453271910, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4778990109135373312, 1370163678030963890, 'mvc.controller.class', 0x4C6F675265736F75726365, 6, 1564127453271910, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4778990109135373312, 1370163678030963890, 'mvc.controller.method', 0x73617665, 6, 1564127453271910, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4778990109135373312, 1370163678030963890, 'cs', NULL, -1, 1564127453244839, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4778990109135373312, 1370163678030963890, 'cr', NULL, -1, 1564127453338774, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4778990109135373312, 1370163678030963890, 'http.method', 0x504F5354, 6, 1564127453244839, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4778990109135373312, 1370163678030963890, 'http.path', 0x2F6C6F672F, 6, 1564127453244839, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4778990109135373312, -8674154234655274627, 'class', 0x5379734C6F674C697374656E6572, 6, 1564127452854322, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4778990109135373312, -8674154234655274627, 'method', 0x736176655379734C6F67, 6, 1564127452854322, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4778990109135373312, -5398263470130861237, 'lc', '', 6, 1564127452853000, 168100642, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -6936895372755776972, -6936895372755776972, 'lc', '', 6, 1564143730234000, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8065351666883172947, 2768744459530448875, 'cs', NULL, -1, 1564144475295323, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8065351666883172947, 2768744459530448875, 'cr', NULL, -1, 1564144475311403, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8065351666883172947, 2768744459530448875, 'http.method', 0x504F5354, 6, 1564144475295323, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8065351666883172947, 2768744459530448875, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1564144475295323, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8065351666883172947, -3386541002682211472, 'sr', NULL, -1, 1564144475288152, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8065351666883172947, -3386541002682211472, 'ss', NULL, -1, 1564144475424464, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8065351666883172947, -3386541002682211472, 'ca', 0x01, 0, 1564144475288152, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, -8065351666883172947, -3386541002682211472, 'http.method', 0x474554, 6, 1564144475288152, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8065351666883172947, -3386541002682211472, 'http.path', 0x2F757365722F, 6, 1564144475288152, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8065351666883172947, -3386541002682211472, 'mvc.controller.class', 0x557365725265736F75726365, 6, 1564144475288152, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8065351666883172947, -3386541002682211472, 'mvc.controller.method', 0x6765745573657250616765, 6, 1564144475288152, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 8992016267829347601, 2627253114081378149, 'cs', NULL, -1, 1564144476874063, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 8992016267829347601, 2627253114081378149, 'cr', NULL, -1, 1564144476884036, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 8992016267829347601, 2627253114081378149, 'http.method', 0x504F5354, 6, 1564144476874063, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 8992016267829347601, 2627253114081378149, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1564144476874063, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 8992016267829347601, -4193095262562206421, 'sr', NULL, -1, 1564144476870049, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 8992016267829347601, -4193095262562206421, 'ss', NULL, -1, 1564144476908397, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 8992016267829347601, -4193095262562206421, 'ca', 0x01, 0, 1564144476870049, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, 8992016267829347601, -4193095262562206421, 'http.method', 0x474554, 6, 1564144476870049, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 8992016267829347601, -4193095262562206421, 'http.path', 0x2F646570742F757365722D74726565, 6, 1564144476870049, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 8992016267829347601, -4193095262562206421, 'mvc.controller.class', 0x446570745265736F75726365, 6, 1564144476870049, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 8992016267829347601, -4193095262562206421, 'mvc.controller.method', 0x6C69737443757272656E7455736572446570745472656573, 6, 1564144476870049, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6954355325704957947, 6954355325704957947, 'lc', '', 6, 1564144562595000, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, -4481387658750219201, -8983763692872096073, 'cs', NULL, -1, 1564147612630200, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, -4481387658750219201, -8983763692872096073, 'cr', NULL, -1, 1564147612642865, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, -4481387658750219201, -8983763692872096073, 'http.method', 0x504F5354, 6, 1564147612630200, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, -4481387658750219201, -8983763692872096073, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1564147612630200, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, -4481387658750219201, 2693488637519040796, 'sr', NULL, -1, 1564147612629390, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, -4481387658750219201, 2693488637519040796, 'ss', NULL, -1, 1564147613410111, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, -4481387658750219201, 2693488637519040796, 'ca', 0x01, 0, 1564147612629390, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, -4481387658750219201, 2693488637519040796, 'http.method', 0x504F5354, 6, 1564147612629390, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, -4481387658750219201, 2693488637519040796, 'http.path', 0x2F7461626C652F, 6, 1564147612629390, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, -4481387658750219201, 2693488637519040796, 'mvc.controller.class', 0x5461626C655265736F75726365, 6, 1564147612629390, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, -4481387658750219201, 2693488637519040796, 'mvc.controller.method', 0x73617665, 6, 1564147612629390, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, 7674822648128898262, 694147418137379562, 'cs', NULL, -1, 1564147615089075, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, 7674822648128898262, 694147418137379562, 'cr', NULL, -1, 1564147615100144, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, 7674822648128898262, 694147418137379562, 'http.method', 0x504F5354, 6, 1564147615089075, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, 7674822648128898262, 694147418137379562, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1564147615089075, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, 7674822648128898262, -4731720891015785583, 'sr', NULL, -1, 1564147615088096, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, 7674822648128898262, -4731720891015785583, 'ss', NULL, -1, 1564147615146002, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, 7674822648128898262, -4731720891015785583, 'ca', 0x01, 0, 1564147615088096, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, 7674822648128898262, -4731720891015785583, 'http.method', 0x474554, 6, 1564147615088096, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, 7674822648128898262, -4731720891015785583, 'http.path', 0x2F7461626C652F7461626C652D6C697374, 6, 1564147615088096, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, 7674822648128898262, -4731720891015785583, 'mvc.controller.class', 0x5461626C655265736F75726365, 6, 1564147615088096, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, 7674822648128898262, -4731720891015785583, 'mvc.controller.method', 0x7461626C654C697374, 6, 1564147615088096, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, 5511027341642523932, 6545413765238496601, 'cs', NULL, -1, 1564147630219052, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, 5511027341642523932, 6545413765238496601, 'cr', NULL, -1, 1564147630226400, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, 5511027341642523932, 6545413765238496601, 'http.method', 0x504F5354, 6, 1564147630219052, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, 5511027341642523932, 6545413765238496601, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1564147630219052, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, 5511027341642523932, -4691941664588638033, 'sr', NULL, -1, 1564147630218085, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, 5511027341642523932, -4691941664588638033, 'ss', NULL, -1, 1564147630237338, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, 5511027341642523932, -4691941664588638033, 'ca', 0x01, 0, 1564147630218085, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, 5511027341642523932, -4691941664588638033, 'http.method', 0x474554, 6, 1564147630218085, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, 5511027341642523932, -4691941664588638033, 'http.path', 0x2F736368656D652F666F726D2D64617461, 6, 1564147630218085, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, 5511027341642523932, -4691941664588638033, 'mvc.controller.class', 0x536368656D655265736F75726365, 6, 1564147630218085, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, 5511027341642523932, -4691941664588638033, 'mvc.controller.method', 0x666F726D44617461, 6, 1564147630218085, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, -5261490983564080458, -1629662300544416867, 'cs', NULL, -1, 1564147697648059, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5261490983564080458, -1629662300544416867, 'cr', NULL, -1, 1564147697661988, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5261490983564080458, -1629662300544416867, 'http.method', 0x504F5354, 6, 1564147697648059, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5261490983564080458, -1629662300544416867, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1564147697648059, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5261490983564080458, -2013046227378460334, 'sr', NULL, -1, 1564147697642067, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5261490983564080458, -2013046227378460334, 'ss', NULL, -1, 1564147697692406, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5261490983564080458, -2013046227378460334, 'ca', 0x01, 0, 1564147697642067, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, -5261490983564080458, -2013046227378460334, 'http.method', 0x474554, 6, 1564147697642067, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5261490983564080458, -2013046227378460334, 'http.path', 0x2F757365722F696E666F, 6, 1564147697642067, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5261490983564080458, -2013046227378460334, 'mvc.controller.class', 0x557365725265736F75726365, 6, 1564147697642067, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5261490983564080458, -2013046227378460334, 'mvc.controller.method', 0x696E666F, 6, 1564147697642067, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8455761351455901773, -3518082823187538009, 'cs', NULL, -1, 1564147702163166, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8455761351455901773, -3518082823187538009, 'cr', NULL, -1, 1564147702180864, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8455761351455901773, -3518082823187538009, 'http.method', 0x504F5354, 6, 1564147702163166, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8455761351455901773, -3518082823187538009, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1564147702163166, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8455761351455901773, 1152068604995359929, 'sr', NULL, -1, 1564147702148149, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8455761351455901773, 1152068604995359929, 'ss', NULL, -1, 1564147702199359, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8455761351455901773, 1152068604995359929, 'ca', 0x01, 0, 1564147702148149, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, -8455761351455901773, 1152068604995359929, 'http.method', 0x474554, 6, 1564147702148149, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8455761351455901773, 1152068604995359929, 'http.path', 0x2F6D656E752F757365722D6D656E75, 6, 1564147702148149, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8455761351455901773, 1152068604995359929, 'mvc.controller.class', 0x4D656E755265736F75726365, 6, 1564147702148149, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8455761351455901773, 1152068604995359929, 'mvc.controller.method', 0x676574557365724D656E75, 6, 1564147702148149, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6013133406702748688, 6164247087470285309, 'cs', NULL, -1, 1564147766114173, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6013133406702748688, 6164247087470285309, 'cr', NULL, -1, 1564147766126033, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6013133406702748688, 6164247087470285309, 'http.method', 0x504F5354, 6, 1564147766114173, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6013133406702748688, 6164247087470285309, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1564147766114173, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6013133406702748688, -2628634802612973396, 'sr', NULL, -1, 1564147766109083, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6013133406702748688, -2628634802612973396, 'ss', NULL, -1, 1564147766167108, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6013133406702748688, -2628634802612973396, 'ca', 0x01, 0, 1564147766109083, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, 6013133406702748688, -2628634802612973396, 'http.method', 0x474554, 6, 1564147766109083, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6013133406702748688, -2628634802612973396, 'http.path', 0x2F726F6C652F, 6, 1564147766109083, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6013133406702748688, -2628634802612973396, 'mvc.controller.class', 0x526F6C655265736F75726365, 6, 1564147766109083, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6013133406702748688, -2628634802612973396, 'mvc.controller.method', 0x67657450616765, 6, 1564147766109083, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6894246148321329473, -4488172146535554564, 'cs', NULL, -1, 1564147800497037, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6894246148321329473, -4488172146535554564, 'cr', NULL, -1, 1564147800506257, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6894246148321329473, -4488172146535554564, 'http.method', 0x504F5354, 6, 1564147800497037, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6894246148321329473, -4488172146535554564, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1564147800497037, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6894246148321329473, -1142619961319169511, 'sr', NULL, -1, 1564147800495042, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6894246148321329473, -1142619961319169511, 'ss', NULL, -1, 1564147800546940, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6894246148321329473, -1142619961319169511, 'ca', 0x01, 0, 1564147800495042, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, 6894246148321329473, -1142619961319169511, 'http.method', 0x474554, 6, 1564147800495042, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6894246148321329473, -1142619961319169511, 'http.path', 0x2F6D656E752F, 6, 1564147800495042, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6894246148321329473, -1142619961319169511, 'mvc.controller.class', 0x4D656E755265736F75726365, 6, 1564147800495042, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6894246148321329473, -1142619961319169511, 'mvc.controller.method', 0x67657450616765, 6, 1564147800495042, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3129301285365936962, 3730770745487628212, 'cs', NULL, -1, 1564147813512036, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3129301285365936962, 3730770745487628212, 'cr', NULL, -1, 1564147813521524, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3129301285365936962, 3730770745487628212, 'http.method', 0x504F5354, 6, 1564147813512036, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3129301285365936962, 3730770745487628212, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1564147813512036, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3129301285365936962, -8044878592960487486, 'sr', NULL, -1, 1564147813509038, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3129301285365936962, -8044878592960487486, 'ss', NULL, -1, 1564147813545422, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3129301285365936962, -8044878592960487486, 'ca', 0x01, 0, 1564147813509038, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, 3129301285365936962, -8044878592960487486, 'http.method', 0x44454C455445, 6, 1564147813509038, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3129301285365936962, -8044878592960487486, 'http.path', 0x2F6D656E752F3862663232396665336563366333336436663132666533646239613832653130, 6, 1564147813509038, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3129301285365936962, -8044878592960487486, 'mvc.controller.class', 0x4D656E755265736F75726365, 6, 1564147813509038, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3129301285365936962, -8044878592960487486, 'mvc.controller.method', 0x72656D6F76654279496473, 6, 1564147813509038, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3129301285365936962, 4629762446910278000, 'cs', NULL, -1, 1564147813545444, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3129301285365936962, 4629762446910278000, 'cr', NULL, -1, 1564147813566256, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3129301285365936962, 4629762446910278000, 'http.method', 0x504F5354, 6, 1564147813545444, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3129301285365936962, 4629762446910278000, 'http.path', 0x2F6C6F672F, 6, 1564147813545444, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3129301285365936962, 4629762446910278000, 'sr', NULL, -1, 1564147813549523, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3129301285365936962, 4629762446910278000, 'ss', NULL, -1, 1564147813567720, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3129301285365936962, 4629762446910278000, 'ca', 0x01, 0, 1564147813549523, -1062724095, NULL, -9144, '');
INSERT INTO `zipkin_annotations` VALUES (0, 3129301285365936962, 4629762446910278000, 'http.method', 0x504F5354, 6, 1564147813549523, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3129301285365936962, 4629762446910278000, 'http.path', 0x2F6C6F672F, 6, 1564147813549523, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3129301285365936962, 4629762446910278000, 'mvc.controller.class', 0x4C6F675265736F75726365, 6, 1564147813549523, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3129301285365936962, 4629762446910278000, 'mvc.controller.method', 0x73617665, 6, 1564147813549523, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3129301285365936962, -2614130353363870953, 'class', 0x5379734C6F674C697374656E6572, 6, 1564147813544075, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3129301285365936962, -2614130353363870953, 'method', 0x736176655379734C6F67, 6, 1564147813544075, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3129301285365936962, 5982015845856067070, 'lc', '', 6, 1564147813544000, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8793589550846761246, -6382342476590241182, 'cs', NULL, -1, 1564147829697040, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8793589550846761246, -6382342476590241182, 'cr', NULL, -1, 1564147829706188, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8793589550846761246, -6382342476590241182, 'http.method', 0x504F5354, 6, 1564147829697040, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8793589550846761246, -6382342476590241182, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1564147829697040, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8793589550846761246, -4047996050968153425, 'sr', NULL, -1, 1564147829695040, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8793589550846761246, -4047996050968153425, 'ss', NULL, -1, 1564147829729656, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8793589550846761246, -4047996050968153425, 'ca', 0x01, 0, 1564147829695040, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, -8793589550846761246, -4047996050968153425, 'http.method', 0x474554, 6, 1564147829695040, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8793589550846761246, -4047996050968153425, 'http.path', 0x2F757365722F, 6, 1564147829695040, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8793589550846761246, -4047996050968153425, 'mvc.controller.class', 0x557365725265736F75726365, 6, 1564147829695040, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8793589550846761246, -4047996050968153425, 'mvc.controller.method', 0x6765745573657250616765, 6, 1564147829695040, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5740114021630398243, -1489399621864045088, 'cs', NULL, -1, 1564147841046039, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5740114021630398243, -1489399621864045088, 'cr', NULL, -1, 1564147841052898, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5740114021630398243, -1489399621864045088, 'http.method', 0x504F5354, 6, 1564147841046039, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5740114021630398243, -1489399621864045088, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1564147841046039, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5740114021630398243, -2597668654520588970, 'sr', NULL, -1, 1564147841044038, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5740114021630398243, -2597668654520588970, 'ss', NULL, -1, 1564147841078372, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5740114021630398243, -2597668654520588970, 'ca', 0x01, 0, 1564147841044038, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, -5740114021630398243, -2597668654520588970, 'http.method', 0x474554, 6, 1564147841044038, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5740114021630398243, -2597668654520588970, 'http.path', 0x2F757365722F, 6, 1564147841044038, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5740114021630398243, -2597668654520588970, 'mvc.controller.class', 0x557365725265736F75726365, 6, 1564147841044038, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5740114021630398243, -2597668654520588970, 'mvc.controller.method', 0x6765745573657250616765, 6, 1564147841044038, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 1655008465583353777, 1680153166953823309, 'cs', NULL, -1, 1564147852784077, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 1655008465583353777, 1680153166953823309, 'cr', NULL, -1, 1564147852791007, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 1655008465583353777, 1680153166953823309, 'http.method', 0x504F5354, 6, 1564147852784077, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 1655008465583353777, 1680153166953823309, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1564147852784077, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 1655008465583353777, -2740099875452738405, 'sr', NULL, -1, 1564147852781037, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 1655008465583353777, -2740099875452738405, 'ss', NULL, -1, 1564147852810922, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 1655008465583353777, -2740099875452738405, 'ca', 0x01, 0, 1564147852781037, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, 1655008465583353777, -2740099875452738405, 'http.method', 0x474554, 6, 1564147852781037, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 1655008465583353777, -2740099875452738405, 'http.path', 0x2F757365722F636865636B427950726F7065727479, 6, 1564147852781037, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 1655008465583353777, -2740099875452738405, 'mvc.controller.class', 0x557365725265736F75726365, 6, 1564147852781037, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 1655008465583353777, -2740099875452738405, 'mvc.controller.method', 0x636865636B427950726F7065727479, 6, 1564147852781037, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -431207948352572260, 2749338896832596103, 'cs', NULL, -1, 1564147867315037, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -431207948352572260, 2749338896832596103, 'cr', NULL, -1, 1564147867351690, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -431207948352572260, 2749338896832596103, 'http.method', 0x504F5354, 6, 1564147867315037, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -431207948352572260, 2749338896832596103, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1564147867315037, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -431207948352572260, -6752047083918617771, 'sr', NULL, -1, 1564147867313038, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -431207948352572260, -6752047083918617771, 'ss', NULL, -1, 1564147867377433, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -431207948352572260, -6752047083918617771, 'ca', 0x01, 0, 1564147867313038, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, -431207948352572260, -6752047083918617771, 'http.method', 0x474554, 6, 1564147867313038, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -431207948352572260, -6752047083918617771, 'http.path', 0x2F757365722F, 6, 1564147867313038, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -431207948352572260, -6752047083918617771, 'mvc.controller.class', 0x557365725265736F75726365, 6, 1564147867313038, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -431207948352572260, -6752047083918617771, 'mvc.controller.method', 0x6765745573657250616765, 6, 1564147867313038, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7181797609704093568, -4987766697490223013, 'cs', NULL, -1, 1564147881336109, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7181797609704093568, -4987766697490223013, 'cr', NULL, -1, 1564147881353022, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7181797609704093568, -4987766697490223013, 'http.method', 0x504F5354, 6, 1564147881336109, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7181797609704093568, -4987766697490223013, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1564147881336109, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7181797609704093568, -3198899466499725070, 'sr', NULL, -1, 1564147881327124, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7181797609704093568, -3198899466499725070, 'ss', NULL, -1, 1564147881368091, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7181797609704093568, -3198899466499725070, 'ca', 0x01, 0, 1564147881327124, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, 7181797609704093568, -3198899466499725070, 'http.method', 0x474554, 6, 1564147881327124, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7181797609704093568, -3198899466499725070, 'http.path', 0x2F646963742F636F646573, 6, 1564147881327124, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7181797609704093568, -3198899466499725070, 'mvc.controller.class', 0x446963745265736F75726365, 6, 1564147881327124, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7181797609704093568, -3198899466499725070, 'mvc.controller.method', 0x6765744279436F646573, 6, 1564147881327124, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5865426433412924760, 3636337855647556068, 'cs', NULL, -1, 1564147929863061, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5865426433412924760, 3636337855647556068, 'cr', NULL, -1, 1564147929872350, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5865426433412924760, 3636337855647556068, 'http.method', 0x504F5354, 6, 1564147929863061, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5865426433412924760, 3636337855647556068, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1564147929863061, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5865426433412924760, -4038519678537304339, 'sr', NULL, -1, 1564147929856085, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5865426433412924760, -4038519678537304339, 'ss', NULL, -1, 1564147929898698, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5865426433412924760, -4038519678537304339, 'ca', 0x01, 0, 1564147929856085, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, 5865426433412924760, -4038519678537304339, 'http.method', 0x474554, 6, 1564147929856085, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5865426433412924760, -4038519678537304339, 'http.path', 0x2F646570742F757365722D74726565, 6, 1564147929856085, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5865426433412924760, -4038519678537304339, 'mvc.controller.class', 0x446570745265736F75726365, 6, 1564147929856085, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5865426433412924760, -4038519678537304339, 'mvc.controller.method', 0x6C69737443757272656E7455736572446570745472656573, 6, 1564147929856085, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3367269100038395620, -46460841534491160, 'cs', NULL, -1, 1564147991774103, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3367269100038395620, -46460841534491160, 'cr', NULL, -1, 1564147991786554, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3367269100038395620, -46460841534491160, 'http.method', 0x504F5354, 6, 1564147991774103, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3367269100038395620, -46460841534491160, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1564147991774103, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3367269100038395620, 8506321341350091640, 'sr', NULL, -1, 1564147991760122, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3367269100038395620, 8506321341350091640, 'ss', NULL, -1, 1564147991799918, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3367269100038395620, 8506321341350091640, 'ca', 0x01, 0, 1564147991760122, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, 3367269100038395620, 8506321341350091640, 'http.method', 0x474554, 6, 1564147991760122, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3367269100038395620, 8506321341350091640, 'http.path', 0x2F646963742F636F646573, 6, 1564147991760122, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3367269100038395620, 8506321341350091640, 'mvc.controller.class', 0x446963745265736F75726365, 6, 1564147991760122, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3367269100038395620, 8506321341350091640, 'mvc.controller.method', 0x6765744279436F646573, 6, 1564147991760122, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 8678807562662393941, -4101361604169486532, 'cs', NULL, -1, 1564149792194038, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 8678807562662393941, -4101361604169486532, 'cr', NULL, -1, 1564149792203212, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 8678807562662393941, -4101361604169486532, 'http.method', 0x504F5354, 6, 1564149792194038, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 8678807562662393941, -4101361604169486532, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1564149792194038, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 8678807562662393941, -7387131151831318932, 'sr', NULL, -1, 1564149792191044, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 8678807562662393941, -7387131151831318932, 'ss', NULL, -1, 1564149792226599, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 8678807562662393941, -7387131151831318932, 'ca', 0x01, 0, 1564149792191044, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, 8678807562662393941, -7387131151831318932, 'http.method', 0x474554, 6, 1564149792191044, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 8678807562662393941, -7387131151831318932, 'http.path', 0x2F646570742F757365722D74726565, 6, 1564149792191044, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 8678807562662393941, -7387131151831318932, 'mvc.controller.class', 0x446570745265736F75726365, 6, 1564149792191044, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 8678807562662393941, -7387131151831318932, 'mvc.controller.method', 0x6C69737443757272656E7455736572446570745472656573, 6, 1564149792191044, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 1145187086391838044, 892178470258862251, 'cs', NULL, -1, 1564277567324134, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 1145187086391838044, 892178470258862251, 'cr', NULL, -1, 1564277567339093, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 1145187086391838044, 892178470258862251, 'http.method', 0x504F5354, 6, 1564277567324134, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 1145187086391838044, 892178470258862251, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1564277567324134, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 1145187086391838044, -2639627917545412689, 'sr', NULL, -1, 1564277567320399, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 1145187086391838044, -2639627917545412689, 'ss', NULL, -1, 1564277567356527, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 1145187086391838044, -2639627917545412689, 'ca', 0x01, 0, 1564277567320399, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, 1145187086391838044, -2639627917545412689, 'http.method', 0x474554, 6, 1564277567320399, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 1145187086391838044, -2639627917545412689, 'http.path', 0x2F6C6F672F, 6, 1564277567320399, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 1145187086391838044, -2639627917545412689, 'mvc.controller.class', 0x4C6F675265736F75726365, 6, 1564277567320399, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 1145187086391838044, -2639627917545412689, 'mvc.controller.method', 0x67657450616765, 6, 1564277567320399, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -6648472576722263832, -6648472576722263832, 'lc', '', 6, 1565316734249000, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 573678328805564423, 573678328805564423, 'lc', '', 6, 1565316740690000, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, 172356668049389335, 172356668049389335, 'sr', NULL, -1, 1565316823333617, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 172356668049389335, 172356668049389335, 'ss', NULL, -1, 1565316823371457, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 172356668049389335, 172356668049389335, 'ca', 0x01, 0, 1565316823333617, -1062724095, NULL, -11732, '');
INSERT INTO `zipkin_annotations` VALUES (0, 172356668049389335, 172356668049389335, 'error', 0x343031, 6, 1565316823333617, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 172356668049389335, 172356668049389335, 'http.method', 0x474554, 6, 1565316823333617, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 172356668049389335, 172356668049389335, 'http.path', 0x2F, 6, 1565316823333617, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 172356668049389335, 172356668049389335, 'http.status_code', 0x343031, 6, 1565316823333617, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3262852030929109926, -2279462078727246973, 'cs', NULL, -1, 1565316915438140, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3262852030929109926, -2279462078727246973, 'cr', NULL, -1, 1565316915453450, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3262852030929109926, -2279462078727246973, 'http.method', 0x504F5354, 6, 1565316915438140, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3262852030929109926, -2279462078727246973, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1565316915438140, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3262852030929109926, -8498425111551683836, 'sr', NULL, -1, 1565316915434074, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3262852030929109926, -8498425111551683836, 'ss', NULL, -1, 1565316915510747, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3262852030929109926, -8498425111551683836, 'ca', 0x01, 0, 1565316915434074, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, 3262852030929109926, -8498425111551683836, 'http.method', 0x474554, 6, 1565316915434074, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3262852030929109926, -8498425111551683836, 'http.path', 0x2F646963742F, 6, 1565316915434074, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3262852030929109926, -8498425111551683836, 'mvc.controller.class', 0x446963745265736F75726365, 6, 1565316915434074, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3262852030929109926, -8498425111551683836, 'mvc.controller.method', 0x67657450616765, 6, 1565316915434074, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -3070756364526189412, 340616879310416155, 'cs', NULL, -1, 1565316927275059, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -3070756364526189412, 340616879310416155, 'cr', NULL, -1, 1565316927289039, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -3070756364526189412, 340616879310416155, 'http.method', 0x504F5354, 6, 1565316927275059, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -3070756364526189412, 340616879310416155, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1565316927275059, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -3070756364526189412, 136589306972155371, 'sr', NULL, -1, 1565316927272060, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -3070756364526189412, 136589306972155371, 'ss', NULL, -1, 1565316927334404, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -3070756364526189412, 136589306972155371, 'ca', 0x01, 0, 1565316927272060, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, -3070756364526189412, 136589306972155371, 'http.method', 0x474554, 6, 1565316927272060, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -3070756364526189412, 136589306972155371, 'http.path', 0x2F646963742F, 6, 1565316927272060, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -3070756364526189412, 136589306972155371, 'mvc.controller.class', 0x446963745265736F75726365, 6, 1565316927272060, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -3070756364526189412, 136589306972155371, 'mvc.controller.method', 0x67657450616765, 6, 1565316927272060, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -1372655929968508112, -1372655929968508112, 'lc', '', 6, 1565512094429000, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7268522765970669814, 7268522765970669814, 'lc', '', 6, 1565512200133000, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, 5632143410142579208, 5473597828406620825, 'cs', NULL, -1, 1565512921265234, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5632143410142579208, 5473597828406620825, 'cr', NULL, -1, 1565512921374946, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5632143410142579208, 5473597828406620825, 'http.method', 0x504F5354, 6, 1565512921265234, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5632143410142579208, 5473597828406620825, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1565512921265234, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 2689939368749152554, -5545688115408127641, 'cs', NULL, -1, 1565512921265215, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 2689939368749152554, -5545688115408127641, 'cr', NULL, -1, 1565512921374951, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 2689939368749152554, -5545688115408127641, 'http.method', 0x504F5354, 6, 1565512921265215, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 2689939368749152554, -5545688115408127641, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1565512921265215, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 2689939368749152554, 655296934707481513, 'sr', NULL, -1, 1565512921252438, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 2689939368749152554, 655296934707481513, 'ss', NULL, -1, 1565512921411566, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 2689939368749152554, 655296934707481513, 'ca', 0x01, 0, 1565512921252438, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, 2689939368749152554, 655296934707481513, 'http.method', 0x474554, 6, 1565512921252438, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 2689939368749152554, 655296934707481513, 'http.path', 0x2F757365722F696E666F, 6, 1565512921252438, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 2689939368749152554, 655296934707481513, 'mvc.controller.class', 0x557365725265736F75726365, 6, 1565512921252438, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 2689939368749152554, 655296934707481513, 'mvc.controller.method', 0x696E666F, 6, 1565512921252438, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5632143410142579208, -7774782370477556542, 'sr', NULL, -1, 1565512921252430, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5632143410142579208, -7774782370477556542, 'ss', NULL, -1, 1565512921500708, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5632143410142579208, -7774782370477556542, 'ca', 0x01, 0, 1565512921252430, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, 5632143410142579208, -7774782370477556542, 'http.method', 0x474554, 6, 1565512921252430, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5632143410142579208, -7774782370477556542, 'http.path', 0x2F646963742F636F646573, 6, 1565512921252430, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5632143410142579208, -7774782370477556542, 'mvc.controller.class', 0x446963745265736F75726365, 6, 1565512921252430, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5632143410142579208, -7774782370477556542, 'mvc.controller.method', 0x6765744279436F646573, 6, 1565512921252430, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -1330536912762221635, 8251288837777870642, 'cs', NULL, -1, 1565512928755056, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -1330536912762221635, 8251288837777870642, 'cr', NULL, -1, 1565512928763554, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -1330536912762221635, 8251288837777870642, 'http.method', 0x504F5354, 6, 1565512928755056, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -1330536912762221635, 8251288837777870642, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1565512928755056, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -1330536912762221635, 7759313169544684753, 'sr', NULL, -1, 1565512928751067, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -1330536912762221635, 7759313169544684753, 'ss', NULL, -1, 1565512928782794, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -1330536912762221635, 7759313169544684753, 'ca', 0x01, 0, 1565512928751067, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, -1330536912762221635, 7759313169544684753, 'http.method', 0x474554, 6, 1565512928751067, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -1330536912762221635, 7759313169544684753, 'http.path', 0x2F646570742F757365722D74726565, 6, 1565512928751067, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -1330536912762221635, 7759313169544684753, 'mvc.controller.class', 0x446570745265736F75726365, 6, 1565512928751067, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -1330536912762221635, 7759313169544684753, 'mvc.controller.method', 0x6C69737443757272656E7455736572446570745472656573, 6, 1565512928751067, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -7363059286881599968, 821353517389264534, 'cs', NULL, -1, 1565512953013051, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -7363059286881599968, 821353517389264534, 'cr', NULL, -1, 1565512953020704, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -7363059286881599968, 821353517389264534, 'http.method', 0x504F5354, 6, 1565512953013051, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -7363059286881599968, 821353517389264534, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1565512953013051, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -7363059286881599968, 5493875958703770684, 'sr', NULL, -1, 1565512953011049, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -7363059286881599968, 5493875958703770684, 'ss', NULL, -1, 1565512953055088, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -7363059286881599968, 5493875958703770684, 'ca', 0x01, 0, 1565512953011049, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, -7363059286881599968, 5493875958703770684, 'http.method', 0x474554, 6, 1565512953011049, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -7363059286881599968, 5493875958703770684, 'http.path', 0x2F6D656E752F, 6, 1565512953011049, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -7363059286881599968, 5493875958703770684, 'mvc.controller.class', 0x4D656E755265736F75726365, 6, 1565512953011049, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -7363059286881599968, 5493875958703770684, 'mvc.controller.method', 0x67657450616765, 6, 1565512953011049, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -1304104302293840455, -5764359237784661948, 'cs', NULL, -1, 1565513061039038, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -1304104302293840455, -5764359237784661948, 'cr', NULL, -1, 1565513061048779, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -1304104302293840455, -5764359237784661948, 'http.method', 0x504F5354, 6, 1565513061039038, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -1304104302293840455, -5764359237784661948, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1565513061039038, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -1304104302293840455, -8523546588327824222, 'sr', NULL, -1, 1565513061037159, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -1304104302293840455, -8523546588327824222, 'ss', NULL, -1, 1565513061076502, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -1304104302293840455, -8523546588327824222, 'ca', 0x01, 0, 1565513061037159, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, -1304104302293840455, -8523546588327824222, 'http.method', 0x474554, 6, 1565513061037159, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -1304104302293840455, -8523546588327824222, 'http.path', 0x2F6D656E752F, 6, 1565513061037159, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -1304104302293840455, -8523546588327824222, 'mvc.controller.class', 0x4D656E755265736F75726365, 6, 1565513061037159, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -1304104302293840455, -8523546588327824222, 'mvc.controller.method', 0x67657450616765, 6, 1565513061037159, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4899617154936566187, -3742288722538773892, 'cs', NULL, -1, 1565513269784275, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4899617154936566187, -3742288722538773892, 'cr', NULL, -1, 1565513269802581, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4899617154936566187, -3742288722538773892, 'http.method', 0x504F5354, 6, 1565513269784275, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4899617154936566187, -3742288722538773892, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1565513269784275, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4899617154936566187, -3546005529701156241, 'sr', NULL, -1, 1565513269778072, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4899617154936566187, -3546005529701156241, 'ss', NULL, -1, 1565513269839947, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4899617154936566187, -3546005529701156241, 'ca', 0x01, 0, 1565513269778072, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, 4899617154936566187, -3546005529701156241, 'http.method', 0x474554, 6, 1565513269778072, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4899617154936566187, -3546005529701156241, 'http.path', 0x2F757365722F696E666F, 6, 1565513269778072, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4899617154936566187, -3546005529701156241, 'mvc.controller.class', 0x557365725265736F75726365, 6, 1565513269778072, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4899617154936566187, -3546005529701156241, 'mvc.controller.method', 0x696E666F, 6, 1565513269778072, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -4649373168822057525, 3196168045870938261, 'cs', NULL, -1, 1565513273517040, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -4649373168822057525, 3196168045870938261, 'cr', NULL, -1, 1565513273525361, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -4649373168822057525, 3196168045870938261, 'http.method', 0x504F5354, 6, 1565513273517040, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -4649373168822057525, 3196168045870938261, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1565513273517040, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -4649373168822057525, -4776190528464734531, 'sr', NULL, -1, 1565513273514036, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -4649373168822057525, -4776190528464734531, 'ss', NULL, -1, 1565513273547718, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -4649373168822057525, -4776190528464734531, 'ca', 0x01, 0, 1565513273514036, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, -4649373168822057525, -4776190528464734531, 'http.method', 0x474554, 6, 1565513273514036, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -4649373168822057525, -4776190528464734531, 'http.path', 0x2F726F6C652F, 6, 1565513273514036, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -4649373168822057525, -4776190528464734531, 'mvc.controller.class', 0x526F6C655265736F75726365, 6, 1565513273514036, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -4649373168822057525, -4776190528464734531, 'mvc.controller.method', 0x67657450616765, 6, 1565513273514036, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8373816033037084699, -6975693944977333301, 'cs', NULL, -1, 1565513342192068, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8373816033037084699, -6975693944977333301, 'cr', NULL, -1, 1565513342200971, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8373816033037084699, -6975693944977333301, 'http.method', 0x504F5354, 6, 1565513342192068, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8373816033037084699, -6975693944977333301, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1565513342192068, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8373816033037084699, 4575444824033203003, 'sr', NULL, -1, 1565513342189044, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8373816033037084699, 4575444824033203003, 'ss', NULL, -1, 1565513342235271, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8373816033037084699, 4575444824033203003, 'ca', 0x01, 0, 1565513342189044, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, -8373816033037084699, 4575444824033203003, 'http.method', 0x474554, 6, 1565513342189044, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8373816033037084699, 4575444824033203003, 'http.path', 0x2F757365722F696E666F, 6, 1565513342189044, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8373816033037084699, 4575444824033203003, 'mvc.controller.class', 0x557365725265736F75726365, 6, 1565513342189044, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8373816033037084699, 4575444824033203003, 'mvc.controller.method', 0x696E666F, 6, 1565513342189044, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -7523391195008277533, 5499364981133141459, 'cs', NULL, -1, 1565513376026052, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -7523391195008277533, 5499364981133141459, 'cr', NULL, -1, 1565513376035889, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -7523391195008277533, 5499364981133141459, 'http.method', 0x504F5354, 6, 1565513376026052, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -7523391195008277533, 5499364981133141459, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1565513376026052, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -7523391195008277533, 3361787619712472526, 'sr', NULL, -1, 1565513376023063, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -7523391195008277533, 3361787619712472526, 'ss', NULL, -1, 1565513376075852, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -7523391195008277533, 3361787619712472526, 'ca', 0x01, 0, 1565513376023063, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, -7523391195008277533, 3361787619712472526, 'http.method', 0x474554, 6, 1565513376023063, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -7523391195008277533, 3361787619712472526, 'http.path', 0x2F646963742F, 6, 1565513376023063, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -7523391195008277533, 3361787619712472526, 'mvc.controller.class', 0x446963745265736F75726365, 6, 1565513376023063, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -7523391195008277533, 3361787619712472526, 'mvc.controller.method', 0x67657450616765, 6, 1565513376023063, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7137541702423205482, -6768674554799681420, 'cs', NULL, -1, 1565513405942039, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7137541702423205482, -6768674554799681420, 'cr', NULL, -1, 1565513405949417, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7137541702423205482, -6768674554799681420, 'http.method', 0x504F5354, 6, 1565513405942039, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7137541702423205482, -6768674554799681420, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1565513405942039, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7137541702423205482, -5123544269024153221, 'sr', NULL, -1, 1565513405940038, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7137541702423205482, -5123544269024153221, 'ss', NULL, -1, 1565513405997657, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7137541702423205482, -5123544269024153221, 'ca', 0x01, 0, 1565513405940038, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, 7137541702423205482, -5123544269024153221, 'http.method', 0x504F5354, 6, 1565513405940038, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7137541702423205482, -5123544269024153221, 'http.path', 0x2F6D656E752F, 6, 1565513405940038, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7137541702423205482, -5123544269024153221, 'mvc.controller.class', 0x4D656E755265736F75726365, 6, 1565513405940038, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7137541702423205482, -5123544269024153221, 'mvc.controller.method', 0x73617665, 6, 1565513405940038, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7137541702423205482, -5372157265008047820, 'sr', NULL, -1, 1565513406003666, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7137541702423205482, -5372157265008047820, 'ss', NULL, -1, 1565513406011371, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7137541702423205482, -5372157265008047820, 'ca', 0x01, 0, 1565513406003666, -1062724095, NULL, -5906, '');
INSERT INTO `zipkin_annotations` VALUES (0, 7137541702423205482, -5372157265008047820, 'error', 0x343034, 6, 1565513406003666, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7137541702423205482, -5372157265008047820, 'http.method', 0x504F5354, 6, 1565513406003666, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7137541702423205482, -5372157265008047820, 'http.path', 0x2F6C6F672F, 6, 1565513406003666, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7137541702423205482, -5372157265008047820, 'http.status_code', 0x343034, 6, 1565513406003666, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7137541702423205482, -5372157265008047820, 'mvc.controller.class', 0x5265736F75726365487474705265717565737448616E646C6572, 6, 1565513406003666, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7137541702423205482, -5372157265008047820, 'cs', NULL, -1, 1565513406001103, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7137541702423205482, -5372157265008047820, 'cr', NULL, -1, 1565513406015598, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7137541702423205482, -5372157265008047820, 'error', 0x343034, 6, 1565513406001103, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7137541702423205482, -5372157265008047820, 'http.method', 0x504F5354, 6, 1565513406001103, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7137541702423205482, -5372157265008047820, 'http.path', 0x2F6C6F672F, 6, 1565513406001103, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7137541702423205482, -5372157265008047820, 'http.status_code', 0x343034, 6, 1565513406001103, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7137541702423205482, 6287603609518013260, 'class', 0x5379734C6F674C697374656E6572, 6, 1565513405996193, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7137541702423205482, 6287603609518013260, 'method', 0x736176655379734C6F67, 6, 1565513405996193, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7137541702423205482, -4084289593524695016, 'lc', '', 6, 1565513405996000, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -4323007565025674782, -8527898491177712243, 'cs', NULL, -1, 1565513410559037, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -4323007565025674782, -8527898491177712243, 'cr', NULL, -1, 1565513410569248, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -4323007565025674782, -8527898491177712243, 'http.method', 0x504F5354, 6, 1565513410559037, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -4323007565025674782, -8527898491177712243, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1565513410559037, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -4323007565025674782, 4817795328682991744, 'sr', NULL, -1, 1565513410556041, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -4323007565025674782, 4817795328682991744, 'ss', NULL, -1, 1565513410583405, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -4323007565025674782, 4817795328682991744, 'ca', 0x01, 0, 1565513410556041, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, -4323007565025674782, 4817795328682991744, 'http.method', 0x474554, 6, 1565513410556041, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -4323007565025674782, 4817795328682991744, 'http.path', 0x2F6D656E752F74726565, 6, 1565513410556041, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -4323007565025674782, 4817795328682991744, 'mvc.controller.class', 0x4D656E755265736F75726365, 6, 1565513410556041, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -4323007565025674782, 4817795328682991744, 'mvc.controller.method', 0x67657454726565, 6, 1565513410556041, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -6204279053785215442, 7741963634081025648, 'cs', NULL, -1, 1565513411009037, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -6204279053785215442, 7741963634081025648, 'cr', NULL, -1, 1565513411016583, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -6204279053785215442, 7741963634081025648, 'http.method', 0x504F5354, 6, 1565513411009037, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -6204279053785215442, 7741963634081025648, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1565513411009037, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -6204279053785215442, -3818632110213054470, 'sr', NULL, -1, 1565513411007033, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -6204279053785215442, -3818632110213054470, 'ss', NULL, -1, 1565513411040932, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -6204279053785215442, -3818632110213054470, 'ca', 0x01, 0, 1565513411007033, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, -6204279053785215442, -3818632110213054470, 'http.method', 0x474554, 6, 1565513411007033, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -6204279053785215442, -3818632110213054470, 'http.path', 0x2F6D656E752F, 6, 1565513411007033, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -6204279053785215442, -3818632110213054470, 'mvc.controller.class', 0x4D656E755265736F75726365, 6, 1565513411007033, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -6204279053785215442, -3818632110213054470, 'mvc.controller.method', 0x67657450616765, 6, 1565513411007033, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -7802855738292136311, -4285884172393188555, 'cs', NULL, -1, 1565513444390033, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -7802855738292136311, -4285884172393188555, 'cr', NULL, -1, 1565513444397738, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -7802855738292136311, -4285884172393188555, 'http.method', 0x504F5354, 6, 1565513444390033, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -7802855738292136311, -4285884172393188555, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1565513444390033, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -7802855738292136311, -4007501789172264277, 'sr', NULL, -1, 1565513444388035, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -7802855738292136311, -4007501789172264277, 'ss', NULL, -1, 1565513444418793, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -7802855738292136311, -4007501789172264277, 'ca', 0x01, 0, 1565513444388035, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, -7802855738292136311, -4007501789172264277, 'http.method', 0x474554, 6, 1565513444388035, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -7802855738292136311, -4007501789172264277, 'http.path', 0x2F6D656E752F, 6, 1565513444388035, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -7802855738292136311, -4007501789172264277, 'mvc.controller.class', 0x4D656E755265736F75726365, 6, 1565513444388035, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -7802855738292136311, -4007501789172264277, 'mvc.controller.method', 0x67657450616765, 6, 1565513444388035, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4199721487034974718, 213462493218474059, 'cs', NULL, -1, 1565513525178038, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4199721487034974718, 213462493218474059, 'cr', NULL, -1, 1565513525183902, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4199721487034974718, 213462493218474059, 'http.method', 0x504F5354, 6, 1565513525178038, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4199721487034974718, 213462493218474059, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1565513525178038, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4199721487034974718, 3463300795218433453, 'sr', NULL, -1, 1565513525175034, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4199721487034974718, 3463300795218433453, 'ss', NULL, -1, 1565513525197486, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4199721487034974718, 3463300795218433453, 'ca', 0x01, 0, 1565513525175034, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, 4199721487034974718, 3463300795218433453, 'http.method', 0x474554, 6, 1565513525175034, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4199721487034974718, 3463300795218433453, 'http.path', 0x2F646570742F74726565, 6, 1565513525175034, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4199721487034974718, 3463300795218433453, 'mvc.controller.class', 0x446570745265736F75726365, 6, 1565513525175034, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4199721487034974718, 3463300795218433453, 'mvc.controller.method', 0x6C697374446570745472656573, 6, 1565513525175034, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5238252700695042326, -3995930151166512581, 'cs', NULL, -1, 1565513527449040, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5238252700695042326, -3995930151166512581, 'cr', NULL, -1, 1565513527458681, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5238252700695042326, -3995930151166512581, 'http.method', 0x504F5354, 6, 1565513527449040, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5238252700695042326, -3995930151166512581, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1565513527449040, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5238252700695042326, -605517523891978658, 'sr', NULL, -1, 1565513527446039, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5238252700695042326, -605517523891978658, 'ss', NULL, -1, 1565513527483157, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5238252700695042326, -605517523891978658, 'ca', 0x01, 0, 1565513527446039, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, 5238252700695042326, -605517523891978658, 'http.method', 0x474554, 6, 1565513527446039, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5238252700695042326, -605517523891978658, 'http.path', 0x2F757365722F31, 6, 1565513527446039, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5238252700695042326, -605517523891978658, 'mvc.controller.class', 0x557365725265736F75726365, 6, 1565513527446039, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5238252700695042326, -605517523891978658, 'mvc.controller.method', 0x676574, 6, 1565513527446039, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -7482253234374756369, -7482253234374756369, 'lc', '', 6, 1565513723476000, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -4219971026021447105, -4219971026021447105, 'lc', '', 6, 1565514810188000, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6835945609450209147, 6835945609450209147, 'lc', '', 6, 1565515336254000, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 1879345426996711639, 3220647193235117175, 'cs', NULL, -1, 1565515397173231, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 1879345426996711639, 3220647193235117175, 'cr', NULL, -1, 1565515397247092, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 1879345426996711639, 3220647193235117175, 'http.method', 0x504F5354, 6, 1565515397173231, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 1879345426996711639, 3220647193235117175, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1565515397173231, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 1879345426996711639, -7612878910295443125, 'sr', NULL, -1, 1565515397163226, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 1879345426996711639, -7612878910295443125, 'ss', NULL, -1, 1565515397280850, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 1879345426996711639, -7612878910295443125, 'ca', 0x01, 0, 1565515397163226, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, 1879345426996711639, -7612878910295443125, 'http.method', 0x474554, 6, 1565515397163226, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 1879345426996711639, -7612878910295443125, 'http.path', 0x2F757365722F696E666F, 6, 1565515397163226, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 1879345426996711639, -7612878910295443125, 'mvc.controller.class', 0x557365725265736F75726365, 6, 1565515397163226, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 1879345426996711639, -7612878910295443125, 'mvc.controller.method', 0x696E666F, 6, 1565515397163226, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5705631767125715719, -6388969170460495618, 'cs', NULL, -1, 1565515405354066, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5705631767125715719, -6388969170460495618, 'cr', NULL, -1, 1565515405363223, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5705631767125715719, -6388969170460495618, 'http.method', 0x504F5354, 6, 1565515405354066, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5705631767125715719, -6388969170460495618, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1565515405354066, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5705631767125715719, 8926551870049059943, 'sr', NULL, -1, 1565515405352067, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5705631767125715719, 8926551870049059943, 'ss', NULL, -1, 1565515405382584, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5705631767125715719, 8926551870049059943, 'ca', 0x01, 0, 1565515405352067, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, -5705631767125715719, 8926551870049059943, 'http.method', 0x474554, 6, 1565515405352067, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5705631767125715719, 8926551870049059943, 'http.path', 0x2F757365722F31, 6, 1565515405352067, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5705631767125715719, 8926551870049059943, 'mvc.controller.class', 0x557365725265736F75726365, 6, 1565515405352067, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5705631767125715719, 8926551870049059943, 'mvc.controller.method', 0x676574, 6, 1565515405352067, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3719358027852259459, -7735009332324576904, 'cs', NULL, -1, 1565516137000084, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3719358027852259459, -7735009332324576904, 'cr', NULL, -1, 1565516137014047, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3719358027852259459, -7735009332324576904, 'http.method', 0x504F5354, 6, 1565516137000084, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3719358027852259459, -7735009332324576904, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1565516137000084, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3719358027852259459, -9105660896860752857, 'sr', NULL, -1, 1565516136995111, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3719358027852259459, -9105660896860752857, 'ss', NULL, -1, 1565516137083999, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3719358027852259459, -9105660896860752857, 'ca', 0x01, 0, 1565516136995111, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, 3719358027852259459, -9105660896860752857, 'http.method', 0x504F5354, 6, 1565516136995111, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3719358027852259459, -9105660896860752857, 'http.path', 0x2F757365722F, 6, 1565516136995111, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3719358027852259459, -9105660896860752857, 'mvc.controller.class', 0x557365725265736F75726365, 6, 1565516136995111, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3719358027852259459, -9105660896860752857, 'mvc.controller.method', 0x7361766555736572, 6, 1565516136995111, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3719358027852259459, 2402364196403592865, 'sr', NULL, -1, 1565516137097054, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3719358027852259459, 2402364196403592865, 'ss', NULL, -1, 1565516137111076, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3719358027852259459, 2402364196403592865, 'ca', 0x01, 0, 1565516137097054, -1062724095, NULL, -1529, '');
INSERT INTO `zipkin_annotations` VALUES (0, 3719358027852259459, 2402364196403592865, 'error', 0x343034, 6, 1565516137097054, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3719358027852259459, 2402364196403592865, 'http.method', 0x504F5354, 6, 1565516137097054, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3719358027852259459, 2402364196403592865, 'http.path', 0x2F6C6F672F, 6, 1565516137097054, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3719358027852259459, 2402364196403592865, 'http.status_code', 0x343034, 6, 1565516137097054, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3719358027852259459, 2402364196403592865, 'mvc.controller.class', 0x5265736F75726365487474705265717565737448616E646C6572, 6, 1565516137097054, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3719358027852259459, 2402364196403592865, 'cs', NULL, -1, 1565516137093103, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3719358027852259459, 2402364196403592865, 'cr', NULL, -1, 1565516137118416, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3719358027852259459, 2402364196403592865, 'error', 0x343034, 6, 1565516137093103, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3719358027852259459, 2402364196403592865, 'http.method', 0x504F5354, 6, 1565516137093103, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3719358027852259459, 2402364196403592865, 'http.path', 0x2F6C6F672F, 6, 1565516137093103, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3719358027852259459, 2402364196403592865, 'http.status_code', 0x343034, 6, 1565516137093103, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3719358027852259459, -4646717793053461180, 'class', 0x5379734C6F674C697374656E6572, 6, 1565516137082305, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3719358027852259459, -4646717793053461180, 'method', 0x736176655379734C6F67, 6, 1565516137082305, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3719358027852259459, 4065389773714106800, 'lc', '', 6, 1565516137082000, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 9061347141147650074, -2325742125000844633, 'cs', NULL, -1, 1565516157528049, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 9061347141147650074, -2325742125000844633, 'cr', NULL, -1, 1565516157538128, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 9061347141147650074, -2325742125000844633, 'http.method', 0x504F5354, 6, 1565516157528049, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 9061347141147650074, -2325742125000844633, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1565516157528049, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 9061347141147650074, -8456985985003462484, 'sr', NULL, -1, 1565516157526056, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 9061347141147650074, -8456985985003462484, 'ss', NULL, -1, 1565516157575741, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 9061347141147650074, -8456985985003462484, 'ca', 0x01, 0, 1565516157526056, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, 9061347141147650074, -8456985985003462484, 'http.method', 0x474554, 6, 1565516157526056, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 9061347141147650074, -8456985985003462484, 'http.path', 0x2F6D656E752F, 6, 1565516157526056, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 9061347141147650074, -8456985985003462484, 'mvc.controller.class', 0x4D656E755265736F75726365, 6, 1565516157526056, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 9061347141147650074, -8456985985003462484, 'mvc.controller.method', 0x67657450616765, 6, 1565516157526056, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8237058313866304576, 9057604368583936668, 'cs', NULL, -1, 1565516192911052, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8237058313866304576, 9057604368583936668, 'cr', NULL, -1, 1565516192917738, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8237058313866304576, 9057604368583936668, 'http.method', 0x504F5354, 6, 1565516192911052, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8237058313866304576, 9057604368583936668, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1565516192911052, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8237058313866304576, -214698524418173079, 'sr', NULL, -1, 1565516192909057, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8237058313866304576, -214698524418173079, 'ss', NULL, -1, 1565516192934750, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8237058313866304576, -214698524418173079, 'ca', 0x01, 0, 1565516192909057, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, -8237058313866304576, -214698524418173079, 'http.method', 0x474554, 6, 1565516192909057, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8237058313866304576, -214698524418173079, 'http.path', 0x2F6D656E752F74726565, 6, 1565516192909057, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8237058313866304576, -214698524418173079, 'mvc.controller.class', 0x4D656E755265736F75726365, 6, 1565516192909057, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8237058313866304576, -214698524418173079, 'mvc.controller.method', 0x67657454726565, 6, 1565516192909057, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5382785875220979146, 7713626404735386346, 'cs', NULL, -1, 1565516200947116, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5382785875220979146, 7713626404735386346, 'cr', NULL, -1, 1565516200965572, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5382785875220979146, 7713626404735386346, 'http.method', 0x504F5354, 6, 1565516200947116, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5382785875220979146, 7713626404735386346, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1565516200947116, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5382785875220979146, -3258971330017880550, 'sr', NULL, -1, 1565516200943060, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5382785875220979146, -3258971330017880550, 'ss', NULL, -1, 1565516201001870, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5382785875220979146, -3258971330017880550, 'ca', 0x01, 0, 1565516200943060, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, -5382785875220979146, -3258971330017880550, 'http.method', 0x474554, 6, 1565516200943060, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5382785875220979146, -3258971330017880550, 'http.path', 0x2F6D656E752F74726565, 6, 1565516200943060, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5382785875220979146, -3258971330017880550, 'mvc.controller.class', 0x4D656E755265736F75726365, 6, 1565516200943060, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -5382785875220979146, -3258971330017880550, 'mvc.controller.method', 0x67657454726565, 6, 1565516200943060, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -973501318611360127, -162399283020514936, 'cs', NULL, -1, 1565516201294066, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -973501318611360127, -162399283020514936, 'cr', NULL, -1, 1565516201308697, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -973501318611360127, -162399283020514936, 'http.method', 0x504F5354, 6, 1565516201294066, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -973501318611360127, -162399283020514936, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1565516201294066, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -973501318611360127, 3691625396749899606, 'sr', NULL, -1, 1565516201291189, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -973501318611360127, 3691625396749899606, 'ss', NULL, -1, 1565516201360340, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -973501318611360127, 3691625396749899606, 'ca', 0x01, 0, 1565516201291189, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, -973501318611360127, 3691625396749899606, 'http.method', 0x474554, 6, 1565516201291189, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -973501318611360127, 3691625396749899606, 'http.path', 0x2F6D656E752F, 6, 1565516201291189, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -973501318611360127, 3691625396749899606, 'mvc.controller.class', 0x4D656E755265736F75726365, 6, 1565516201291189, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -973501318611360127, 3691625396749899606, 'mvc.controller.method', 0x67657450616765, 6, 1565516201291189, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -372925305519050998, -7368083627760655627, 'cs', NULL, -1, 1565516219086091, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -372925305519050998, -7368083627760655627, 'cr', NULL, -1, 1565516219102649, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -372925305519050998, -7368083627760655627, 'http.method', 0x504F5354, 6, 1565516219086091, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -372925305519050998, -7368083627760655627, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1565516219086091, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -372925305519050998, 7306810891675108622, 'sr', NULL, -1, 1565516219082057, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -372925305519050998, 7306810891675108622, 'ss', NULL, -1, 1565516219160962, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -372925305519050998, 7306810891675108622, 'ca', 0x01, 0, 1565516219082057, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, -372925305519050998, 7306810891675108622, 'http.method', 0x474554, 6, 1565516219082057, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -372925305519050998, 7306810891675108622, 'http.path', 0x2F726F6C652F, 6, 1565516219082057, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -372925305519050998, 7306810891675108622, 'mvc.controller.class', 0x526F6C655265736F75726365, 6, 1565516219082057, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -372925305519050998, 7306810891675108622, 'mvc.controller.method', 0x67657450616765, 6, 1565516219082057, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8107907975138317451, -8107907975138317451, 'sr', NULL, -1, 1565516313508063, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8107907975138317451, -8107907975138317451, 'ss', NULL, -1, 1565516313532142, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8107907975138317451, -8107907975138317451, 'ca', 0x01, 0, 1565516313508063, NULL, 0x00000000000000000000000000000001, -1087, '');
INSERT INTO `zipkin_annotations` VALUES (0, -8107907975138317451, -8107907975138317451, 'error', 0x343031, 6, 1565516313508063, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8107907975138317451, -8107907975138317451, 'http.method', 0x474554, 6, 1565516313508063, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8107907975138317451, -8107907975138317451, 'http.path', 0x2F, 6, 1565516313508063, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -8107907975138317451, -8107907975138317451, 'http.status_code', 0x343031, 6, 1565516313508063, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7472449667980354619, -2675402958197466783, 'cs', NULL, -1, 1565516414712044, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7472449667980354619, -2675402958197466783, 'cr', NULL, -1, 1565516414721810, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7472449667980354619, -2675402958197466783, 'http.method', 0x504F5354, 6, 1565516414712044, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7472449667980354619, -2675402958197466783, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1565516414712044, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7472449667980354619, 8810264056298482633, 'sr', NULL, -1, 1565516414709098, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7472449667980354619, 8810264056298482633, 'ss', NULL, -1, 1565516414752543, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7472449667980354619, 8810264056298482633, 'ca', 0x01, 0, 1565516414709098, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, 7472449667980354619, 8810264056298482633, 'http.method', 0x474554, 6, 1565516414709098, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7472449667980354619, 8810264056298482633, 'http.path', 0x2F6D656E752F, 6, 1565516414709098, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7472449667980354619, 8810264056298482633, 'mvc.controller.class', 0x4D656E755265736F75726365, 6, 1565516414709098, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7472449667980354619, 8810264056298482633, 'mvc.controller.method', 0x67657450616765, 6, 1565516414709098, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5673805893290378162, -2378753179746003079, 'cs', NULL, -1, 1565516443657149, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5673805893290378162, -2378753179746003079, 'cr', NULL, -1, 1565516443672130, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5673805893290378162, -2378753179746003079, 'http.method', 0x504F5354, 6, 1565516443657149, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5673805893290378162, -2378753179746003079, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1565516443657149, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5673805893290378162, -3254344565554196188, 'sr', NULL, -1, 1565516443654042, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5673805893290378162, -3254344565554196188, 'ss', NULL, -1, 1565516443701024, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5673805893290378162, -3254344565554196188, 'ca', 0x01, 0, 1565516443654042, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, 5673805893290378162, -3254344565554196188, 'http.method', 0x474554, 6, 1565516443654042, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5673805893290378162, -3254344565554196188, 'http.path', 0x2F757365722F696E666F, 6, 1565516443654042, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5673805893290378162, -3254344565554196188, 'mvc.controller.class', 0x557365725265736F75726365, 6, 1565516443654042, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 5673805893290378162, -3254344565554196188, 'mvc.controller.method', 0x696E666F, 6, 1565516443654042, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -1783836202705190303, -5015024705899798229, 'cs', NULL, -1, 1565516464280085, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -1783836202705190303, -5015024705899798229, 'cr', NULL, -1, 1565516464290541, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -1783836202705190303, -5015024705899798229, 'http.method', 0x504F5354, 6, 1565516464280085, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -1783836202705190303, -5015024705899798229, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1565516464280085, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -1783836202705190303, -4379921093930544582, 'sr', NULL, -1, 1565516464276086, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -1783836202705190303, -4379921093930544582, 'ss', NULL, -1, 1565516464332471, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -1783836202705190303, -4379921093930544582, 'ca', 0x01, 0, 1565516464276086, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, -1783836202705190303, -4379921093930544582, 'http.method', 0x474554, 6, 1565516464276086, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -1783836202705190303, -4379921093930544582, 'http.path', 0x2F757365722F696E666F, 6, 1565516464276086, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -1783836202705190303, -4379921093930544582, 'mvc.controller.class', 0x557365725265736F75726365, 6, 1565516464276086, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -1783836202705190303, -4379921093930544582, 'mvc.controller.method', 0x696E666F, 6, 1565516464276086, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3185167637884786959, 4164401636324103234, 'cs', NULL, -1, 1565516480265095, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3185167637884786959, 4164401636324103234, 'cr', NULL, -1, 1565516480275239, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3185167637884786959, 4164401636324103234, 'http.method', 0x504F5354, 6, 1565516480265095, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3185167637884786959, 4164401636324103234, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1565516480265095, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3185167637884786959, 544365760885970297, 'sr', NULL, -1, 1565516480263036, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3185167637884786959, 544365760885970297, 'ss', NULL, -1, 1565516480292978, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3185167637884786959, 544365760885970297, 'ca', 0x01, 0, 1565516480263036, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, 3185167637884786959, 544365760885970297, 'http.method', 0x474554, 6, 1565516480263036, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3185167637884786959, 544365760885970297, 'http.path', 0x2F646570742F757365722D74726565, 6, 1565516480263036, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3185167637884786959, 544365760885970297, 'mvc.controller.class', 0x446570745265736F75726365, 6, 1565516480263036, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3185167637884786959, 544365760885970297, 'mvc.controller.method', 0x6C69737443757272656E7455736572446570745472656573, 6, 1565516480263036, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7610887752079939934, 7610887752079939934, 'lc', '', 6, 1566013507351000, -1062724095, NULL, NULL, 'albedo-quartz');
INSERT INTO `zipkin_annotations` VALUES (0, 8115825570070754608, 8115825570070754608, 'lc', '', 6, 1566020101285000, -1062724095, NULL, NULL, 'albedo-quartz');
INSERT INTO `zipkin_annotations` VALUES (0, -491077864830843261, -383381829308966000, 'sr', NULL, -1, 1566020253360626, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, -491077864830843261, -383381829308966000, 'ss', NULL, -1, 1566020253502000, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, -491077864830843261, -383381829308966000, 'ca', 0x01, 0, 1566020253360626, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, -491077864830843261, -383381829308966000, 'http.method', 0x474554, 6, 1566020253360626, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, -491077864830843261, -383381829308966000, 'http.path', 0x2F76322F6170692D646F6373, 6, 1566020253360626, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, -7363482646801388892, -3123088345577420541, 'sr', NULL, -1, 1566020256644188, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -7363482646801388892, -3123088345577420541, 'ss', NULL, -1, 1566020256667167, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -7363482646801388892, -3123088345577420541, 'ca', 0x01, 0, 1566020256644188, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, -7363482646801388892, -3123088345577420541, 'http.method', 0x474554, 6, 1566020256644188, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -7363482646801388892, -3123088345577420541, 'http.path', 0x2F76322F6170692D646F6373, 6, 1566020256644188, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -6680900699482679288, -8575029914461506808, 'sr', NULL, -1, 1566020433861058, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -6680900699482679288, -8575029914461506808, 'ss', NULL, -1, 1566020433885972, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -6680900699482679288, -8575029914461506808, 'ca', 0x01, 0, 1566020433861058, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, -6680900699482679288, -8575029914461506808, 'http.method', 0x474554, 6, 1566020433861058, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -6680900699482679288, -8575029914461506808, 'http.path', 0x2F76322F6170692D646F6373, 6, 1566020433861058, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7499200519655978951, 7433681128120479622, 'cs', NULL, -1, 1566022353210125, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7499200519655978951, 7433681128120479622, 'cr', NULL, -1, 1566022353224210, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7499200519655978951, 7433681128120479622, 'http.method', 0x504F5354, 6, 1566022353210125, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7499200519655978951, 7433681128120479622, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1566022353210125, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7499200519655978951, -5672175635464032231, 'sr', NULL, -1, 1566022353207059, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7499200519655978951, -5672175635464032231, 'ss', NULL, -1, 1566022353252049, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7499200519655978951, -5672175635464032231, 'ca', 0x01, 0, 1566022353207059, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, 7499200519655978951, -5672175635464032231, 'http.method', 0x474554, 6, 1566022353207059, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7499200519655978951, -5672175635464032231, 'http.path', 0x2F757365722F696E666F, 6, 1566022353207059, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7499200519655978951, -5672175635464032231, 'mvc.controller.class', 0x557365725265736F75726365, 6, 1566022353207059, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 7499200519655978951, -5672175635464032231, 'mvc.controller.method', 0x696E666F, 6, 1566022353207059, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3018022057925972397, 4514679528761094025, 'cs', NULL, -1, 1566022363148080, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3018022057925972397, 4514679528761094025, 'cr', NULL, -1, 1566022363168716, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3018022057925972397, 4514679528761094025, 'http.method', 0x504F5354, 6, 1566022363148080, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3018022057925972397, 4514679528761094025, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1566022363148080, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4909776268729705650, 1940882414332737998, 'cs', NULL, -1, 1566022363159111, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4909776268729705650, 1940882414332737998, 'cr', NULL, -1, 1566022363173630, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4909776268729705650, 1940882414332737998, 'http.method', 0x504F5354, 6, 1566022363159111, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4909776268729705650, 1940882414332737998, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1566022363159111, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4909776268729705650, -6897733441299925228, 'sr', NULL, -1, 1566022363145122, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4909776268729705650, -6897733441299925228, 'ss', NULL, -1, 1566022363317142, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4909776268729705650, -6897733441299925228, 'ca', 0x01, 0, 1566022363145122, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, 4909776268729705650, -6897733441299925228, 'http.method', 0x474554, 6, 1566022363145122, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4909776268729705650, -6897733441299925228, 'http.path', 0x2F6D656E752F74726565, 6, 1566022363145122, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4909776268729705650, -6897733441299925228, 'mvc.controller.class', 0x4D656E755265736F75726365, 6, 1566022363145122, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 4909776268729705650, -6897733441299925228, 'mvc.controller.method', 0x67657454726565, 6, 1566022363145122, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3018022057925972397, -4342284854115108489, 'sr', NULL, -1, 1566022363140282, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3018022057925972397, -4342284854115108489, 'ss', NULL, -1, 1566022363327103, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3018022057925972397, -4342284854115108489, 'ca', 0x01, 0, 1566022363140282, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, 3018022057925972397, -4342284854115108489, 'http.method', 0x474554, 6, 1566022363140282, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3018022057925972397, -4342284854115108489, 'http.path', 0x2F726F6C652F, 6, 1566022363140282, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3018022057925972397, -4342284854115108489, 'mvc.controller.class', 0x526F6C655265736F75726365, 6, 1566022363140282, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 3018022057925972397, -4342284854115108489, 'mvc.controller.method', 0x67657450616765, 6, 1566022363140282, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, -240078901033205946, -8011911462331719453, 'cs', NULL, -1, 1566022373640473, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, -240078901033205946, -8011911462331719453, 'cr', NULL, -1, 1566022373809233, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, -240078901033205946, -8011911462331719453, 'http.method', 0x504F5354, 6, 1566022373640473, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, -240078901033205946, -8011911462331719453, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1566022373640473, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, -240078901033205946, -6854533347371995129, 'sr', NULL, -1, 1566022373314051, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, -240078901033205946, -6854533347371995129, 'ss', NULL, -1, 1566022374105892, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, -240078901033205946, -6854533347371995129, 'ca', 0x01, 0, 1566022373314051, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, -240078901033205946, -6854533347371995129, 'http.method', 0x474554, 6, 1566022373314051, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, -240078901033205946, -6854533347371995129, 'http.path', 0x2F7461626C652F, 6, 1566022373314051, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, -240078901033205946, -6854533347371995129, 'mvc.controller.class', 0x5461626C655265736F75726365, 6, 1566022373314051, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, -240078901033205946, -6854533347371995129, 'mvc.controller.method', 0x67657450616765, 6, 1566022373314051, -1062724095, NULL, NULL, 'albedo-gen');
INSERT INTO `zipkin_annotations` VALUES (0, 6885068868983485372, 2608699163923058582, 'cs', NULL, -1, 1566022412281061, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6885068868983485372, 2608699163923058582, 'cr', NULL, -1, 1566022412292784, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6885068868983485372, 2608699163923058582, 'http.method', 0x504F5354, 6, 1566022412281061, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6885068868983485372, 2608699163923058582, 'http.path', 0x2F6F617574682F636865636B5F746F6B656E, 6, 1566022412281061, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6885068868983485372, 7473558721986038682, 'sr', NULL, -1, 1566022412275097, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6885068868983485372, 7473558721986038682, 'ss', NULL, -1, 1566022412340134, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6885068868983485372, 7473558721986038682, 'ca', 0x01, 0, 1566022412275097, 2130706433, NULL, NULL, '');
INSERT INTO `zipkin_annotations` VALUES (0, 6885068868983485372, 7473558721986038682, 'http.method', 0x474554, 6, 1566022412275097, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6885068868983485372, 7473558721986038682, 'http.path', 0x2F6D656E752F757365722D6D656E75, 6, 1566022412275097, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6885068868983485372, 7473558721986038682, 'mvc.controller.class', 0x4D656E755265736F75726365, 6, 1566022412275097, -1062724095, NULL, NULL, 'albedo-sys');
INSERT INTO `zipkin_annotations` VALUES (0, 6885068868983485372, 7473558721986038682, 'mvc.controller.method', 0x676574557365724D656E75, 6, 1566022412275097, -1062724095, NULL, NULL, 'albedo-sys');

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

-- ----------------------------
-- Records of zipkin_spans
-- ----------------------------
INSERT INTO `zipkin_spans` VALUES (0, -8793589550846761246, -6382342476590241182, 'post', -4047996050968153425, NULL, 1564147829697040, 9148);
INSERT INTO `zipkin_spans` VALUES (0, -8793589550846761246, -4047996050968153425, 'get /user/', -8793589550846761246, NULL, 1564147829695040, NULL);
INSERT INTO `zipkin_spans` VALUES (0, -8455761351455901773, -3518082823187538009, 'post', 1152068604995359929, NULL, 1564147702163166, 17698);
INSERT INTO `zipkin_spans` VALUES (0, -8455761351455901773, 1152068604995359929, 'get /menu/user-menu', -8455761351455901773, NULL, 1564147702148149, NULL);
INSERT INTO `zipkin_spans` VALUES (0, -8373816033037084699, -6975693944977333301, 'post', 4575444824033203003, NULL, 1565513342192068, 8903);
INSERT INTO `zipkin_spans` VALUES (0, -8373816033037084699, 4575444824033203003, 'get /user/info', -8373816033037084699, NULL, 1565513342189044, NULL);
INSERT INTO `zipkin_spans` VALUES (0, -8237058313866304576, -214698524418173079, 'get /menu/tree', -8237058313866304576, NULL, 1565516192909057, NULL);
INSERT INTO `zipkin_spans` VALUES (0, -8237058313866304576, 9057604368583936668, 'post', -214698524418173079, NULL, 1565516192911052, 6686);
INSERT INTO `zipkin_spans` VALUES (0, -8107907975138317451, -8107907975138317451, 'get', NULL, NULL, 1565516313508063, 24079);
INSERT INTO `zipkin_spans` VALUES (0, -8065351666883172947, -3386541002682211472, 'get /user/', -8065351666883172947, NULL, 1564144475288152, NULL);
INSERT INTO `zipkin_spans` VALUES (0, -8065351666883172947, 2768744459530448875, 'post', -3386541002682211472, NULL, 1564144475295323, 16080);
INSERT INTO `zipkin_spans` VALUES (0, -7802855738292136311, -4285884172393188555, 'post', -4007501789172264277, NULL, 1565513444390033, 7705);
INSERT INTO `zipkin_spans` VALUES (0, -7802855738292136311, -4007501789172264277, 'get /menu/', -7802855738292136311, NULL, 1565513444388035, NULL);
INSERT INTO `zipkin_spans` VALUES (0, -7523391195008277533, 3361787619712472526, 'get /dict/', -7523391195008277533, NULL, 1565513376023063, NULL);
INSERT INTO `zipkin_spans` VALUES (0, -7523391195008277533, 5499364981133141459, 'post', 3361787619712472526, NULL, 1565513376026052, 9837);
INSERT INTO `zipkin_spans` VALUES (0, -7482253234374756369, -7482253234374756369, 'async', NULL, NULL, 1565513723476000, 28868);
INSERT INTO `zipkin_spans` VALUES (0, -7363482646801388892, -3123088345577420541, 'get', -7363482646801388892, NULL, 1566020256644188, NULL);
INSERT INTO `zipkin_spans` VALUES (0, -7363059286881599968, 821353517389264534, 'post', 5493875958703770684, NULL, 1565512953013051, 7653);
INSERT INTO `zipkin_spans` VALUES (0, -7363059286881599968, 5493875958703770684, 'get /menu/', -7363059286881599968, NULL, 1565512953011049, NULL);
INSERT INTO `zipkin_spans` VALUES (0, -6936895372755776972, -6936895372755776972, 'async', NULL, NULL, 1564143730234000, 30354);
INSERT INTO `zipkin_spans` VALUES (0, -6680900699482679288, -8575029914461506808, 'get', -6680900699482679288, NULL, 1566020433861058, NULL);
INSERT INTO `zipkin_spans` VALUES (0, -6648472576722263832, -6648472576722263832, 'async', NULL, NULL, 1565316734249000, 31901);
INSERT INTO `zipkin_spans` VALUES (0, -6204279053785215442, -3818632110213054470, 'get /menu/', -6204279053785215442, NULL, 1565513411007033, NULL);
INSERT INTO `zipkin_spans` VALUES (0, -6204279053785215442, 7741963634081025648, 'post', -3818632110213054470, NULL, 1565513411009037, 7546);
INSERT INTO `zipkin_spans` VALUES (0, -6158490369995999212, 582558505829247247, 'post', 1917815909472501094, NULL, 1564127054021038, 11453);
INSERT INTO `zipkin_spans` VALUES (0, -6158490369995999212, 1917815909472501094, 'get /menu/', -6158490369995999212, NULL, 1564127054018045, NULL);
INSERT INTO `zipkin_spans` VALUES (0, -5740114021630398243, -2597668654520588970, 'get /user/', -5740114021630398243, NULL, 1564147841044038, NULL);
INSERT INTO `zipkin_spans` VALUES (0, -5740114021630398243, -1489399621864045088, 'post', -2597668654520588970, NULL, 1564147841046039, 6859);
INSERT INTO `zipkin_spans` VALUES (0, -5705631767125715719, -6388969170460495618, 'post', 8926551870049059943, NULL, 1565515405354066, 9157);
INSERT INTO `zipkin_spans` VALUES (0, -5705631767125715719, 8926551870049059943, 'get /user/{id:^[_\',.@a-za-z0-9-]*$}', -5705631767125715719, NULL, 1565515405352067, NULL);
INSERT INTO `zipkin_spans` VALUES (0, -5382785875220979146, -3258971330017880550, 'get /menu/tree', -5382785875220979146, NULL, 1565516200943060, NULL);
INSERT INTO `zipkin_spans` VALUES (0, -5382785875220979146, 7713626404735386346, 'post', -3258971330017880550, NULL, 1565516200947116, 18456);
INSERT INTO `zipkin_spans` VALUES (0, -5261490983564080458, -2013046227378460334, 'get /user/info', -5261490983564080458, NULL, 1564147697642067, NULL);
INSERT INTO `zipkin_spans` VALUES (0, -5261490983564080458, -1629662300544416867, 'post', -2013046227378460334, NULL, 1564147697648059, 13929);
INSERT INTO `zipkin_spans` VALUES (0, -4649373168822057525, -4776190528464734531, 'get /role/', -4649373168822057525, NULL, 1565513273514036, NULL);
INSERT INTO `zipkin_spans` VALUES (0, -4649373168822057525, 3196168045870938261, 'post', -4776190528464734531, NULL, 1565513273517040, 8321);
INSERT INTO `zipkin_spans` VALUES (0, -4481387658750219201, -8983763692872096073, 'post', 2693488637519040796, NULL, 1564147612630200, 12665);
INSERT INTO `zipkin_spans` VALUES (0, -4481387658750219201, 2693488637519040796, 'post /table/', -4481387658750219201, NULL, 1564147612629390, NULL);
INSERT INTO `zipkin_spans` VALUES (0, -4323007565025674782, -8527898491177712243, 'post', 4817795328682991744, NULL, 1565513410559037, 10211);
INSERT INTO `zipkin_spans` VALUES (0, -4323007565025674782, 4817795328682991744, 'get /menu/tree', -4323007565025674782, NULL, 1565513410556041, NULL);
INSERT INTO `zipkin_spans` VALUES (0, -4219971026021447105, -4219971026021447105, 'async', NULL, NULL, 1565514810188000, 28746);
INSERT INTO `zipkin_spans` VALUES (0, -3070756364526189412, 136589306972155371, 'get /dict/', -3070756364526189412, NULL, 1565316927272060, NULL);
INSERT INTO `zipkin_spans` VALUES (0, -3070756364526189412, 340616879310416155, 'post', 136589306972155371, NULL, 1565316927275059, 13980);
INSERT INTO `zipkin_spans` VALUES (0, -3021737358036785199, -4856311730907896364, 'post', -1630741176487065905, NULL, 1564127136022057, 8619);
INSERT INTO `zipkin_spans` VALUES (0, -3021737358036785199, -1630741176487065905, 'get /menu/', -3021737358036785199, NULL, 1564127136017039, NULL);
INSERT INTO `zipkin_spans` VALUES (0, -2563163435213653073, -3109682506393738710, 'get /menu/', -2563163435213653073, NULL, 1564127042304040, NULL);
INSERT INTO `zipkin_spans` VALUES (0, -2563163435213653073, -2340382440083905913, 'post', -3109682506393738710, NULL, 1564127042307045, 6799);
INSERT INTO `zipkin_spans` VALUES (0, -1783836202705190303, -5015024705899798229, 'post', -4379921093930544582, NULL, 1565516464280085, 10456);
INSERT INTO `zipkin_spans` VALUES (0, -1783836202705190303, -4379921093930544582, 'get /user/info', -1783836202705190303, NULL, 1565516464276086, NULL);
INSERT INTO `zipkin_spans` VALUES (0, -1372655929968508112, -1372655929968508112, 'async', NULL, NULL, 1565512094429000, 33657);
INSERT INTO `zipkin_spans` VALUES (0, -1330536912762221635, 7759313169544684753, 'get /dept/user-tree', -1330536912762221635, NULL, 1565512928751067, NULL);
INSERT INTO `zipkin_spans` VALUES (0, -1330536912762221635, 8251288837777870642, 'post', 7759313169544684753, NULL, 1565512928755056, 8498);
INSERT INTO `zipkin_spans` VALUES (0, -1304104302293840455, -8523546588327824222, 'get /menu/', -1304104302293840455, NULL, 1565513061037159, NULL);
INSERT INTO `zipkin_spans` VALUES (0, -1304104302293840455, -5764359237784661948, 'post', -8523546588327824222, NULL, 1565513061039038, 9741);
INSERT INTO `zipkin_spans` VALUES (0, -973501318611360127, -162399283020514936, 'post', 3691625396749899606, NULL, 1565516201294066, 14631);
INSERT INTO `zipkin_spans` VALUES (0, -973501318611360127, 3691625396749899606, 'get /menu/', -973501318611360127, NULL, 1565516201291189, NULL);
INSERT INTO `zipkin_spans` VALUES (0, -491077864830843261, -383381829308966000, 'get', -491077864830843261, NULL, 1566020253360626, NULL);
INSERT INTO `zipkin_spans` VALUES (0, -431207948352572260, -6752047083918617771, 'get /user/', -431207948352572260, NULL, 1564147867313038, NULL);
INSERT INTO `zipkin_spans` VALUES (0, -431207948352572260, 2749338896832596103, 'post', -6752047083918617771, NULL, 1564147867315037, 36653);
INSERT INTO `zipkin_spans` VALUES (0, -372925305519050998, -7368083627760655627, 'post', 7306810891675108622, NULL, 1565516219086091, 16558);
INSERT INTO `zipkin_spans` VALUES (0, -372925305519050998, 7306810891675108622, 'get /role/', -372925305519050998, NULL, 1565516219082057, NULL);
INSERT INTO `zipkin_spans` VALUES (0, -268161805056592825, -5574115193676832827, 'post', 2316860013070603731, NULL, 1564127148935093, 8652);
INSERT INTO `zipkin_spans` VALUES (0, -268161805056592825, 2316860013070603731, 'get /menu/', -268161805056592825, NULL, 1564127148932062, NULL);
INSERT INTO `zipkin_spans` VALUES (0, -240078901033205946, -8011911462331719453, 'post', -6854533347371995129, NULL, 1566022373640473, 168760);
INSERT INTO `zipkin_spans` VALUES (0, -240078901033205946, -6854533347371995129, 'get /table/', -240078901033205946, NULL, 1566022373314051, NULL);
INSERT INTO `zipkin_spans` VALUES (0, 172356668049389335, 172356668049389335, 'get', NULL, NULL, 1565316823333617, 37840);
INSERT INTO `zipkin_spans` VALUES (0, 272343372844899494, -3028944364851724551, 'post', 8650847360064451318, NULL, 1564126875798069, 11663);
INSERT INTO `zipkin_spans` VALUES (0, 272343372844899494, 8650847360064451318, 'get /log/', 272343372844899494, NULL, 1564126875787087, NULL);
INSERT INTO `zipkin_spans` VALUES (0, 573678328805564423, 573678328805564423, 'async', NULL, NULL, 1565316740690000, 763375);
INSERT INTO `zipkin_spans` VALUES (0, 1145187086391838044, -2639627917545412689, 'get /log/', 1145187086391838044, NULL, 1564277567320399, NULL);
INSERT INTO `zipkin_spans` VALUES (0, 1145187086391838044, 892178470258862251, 'post', -2639627917545412689, NULL, 1564277567324134, 14959);
INSERT INTO `zipkin_spans` VALUES (0, 1655008465583353777, -2740099875452738405, 'get /user/checkbyproperty', 1655008465583353777, NULL, 1564147852781037, NULL);
INSERT INTO `zipkin_spans` VALUES (0, 1655008465583353777, 1680153166953823309, 'post', -2740099875452738405, NULL, 1564147852784077, 6930);
INSERT INTO `zipkin_spans` VALUES (0, 1879345426996711639, -7612878910295443125, 'get /user/info', 1879345426996711639, NULL, 1565515397163226, NULL);
INSERT INTO `zipkin_spans` VALUES (0, 1879345426996711639, 3220647193235117175, 'post', -7612878910295443125, NULL, 1565515397173231, 73861);
INSERT INTO `zipkin_spans` VALUES (0, 2689939368749152554, -5545688115408127641, 'post', 655296934707481513, NULL, 1565512921265215, 109736);
INSERT INTO `zipkin_spans` VALUES (0, 2689939368749152554, 655296934707481513, 'get /user/info', 2689939368749152554, NULL, 1565512921252438, NULL);
INSERT INTO `zipkin_spans` VALUES (0, 3018022057925972397, -4342284854115108489, 'get /role/', 3018022057925972397, NULL, 1566022363140282, NULL);
INSERT INTO `zipkin_spans` VALUES (0, 3018022057925972397, 4514679528761094025, 'post', -4342284854115108489, NULL, 1566022363148080, 20636);
INSERT INTO `zipkin_spans` VALUES (0, 3129301285365936962, -8044878592960487486, 'delete /menu/{ids:^[_\',.@a-za-z0-9-]*$}', 3129301285365936962, NULL, 1564147813509038, NULL);
INSERT INTO `zipkin_spans` VALUES (0, 3129301285365936962, -2614130353363870953, 'save-sys-log', -8044878592960487486, NULL, 1564147813544075, 24347);
INSERT INTO `zipkin_spans` VALUES (0, 3129301285365936962, 3730770745487628212, 'post', -8044878592960487486, NULL, 1564147813512036, 9488);
INSERT INTO `zipkin_spans` VALUES (0, 3129301285365936962, 4629762446910278000, 'post /log/', -2614130353363870953, NULL, 1564147813545444, 20812);
INSERT INTO `zipkin_spans` VALUES (0, 3129301285365936962, 5982015845856067070, 'async', -8044878592960487486, NULL, 1564147813544000, 24482);
INSERT INTO `zipkin_spans` VALUES (0, 3185167637884786959, 544365760885970297, 'get /dept/user-tree', 3185167637884786959, NULL, 1565516480263036, NULL);
INSERT INTO `zipkin_spans` VALUES (0, 3185167637884786959, 4164401636324103234, 'post', 544365760885970297, NULL, 1565516480265095, 10144);
INSERT INTO `zipkin_spans` VALUES (0, 3262852030929109926, -8498425111551683836, 'get /dict/', 3262852030929109926, NULL, 1565316915434074, NULL);
INSERT INTO `zipkin_spans` VALUES (0, 3262852030929109926, -2279462078727246973, 'post', -8498425111551683836, NULL, 1565316915438140, 15310);
INSERT INTO `zipkin_spans` VALUES (0, 3367269100038395620, -46460841534491160, 'post', 8506321341350091640, NULL, 1564147991774103, 12451);
INSERT INTO `zipkin_spans` VALUES (0, 3367269100038395620, 8506321341350091640, 'get /dict/codes', 3367269100038395620, NULL, 1564147991760122, NULL);
INSERT INTO `zipkin_spans` VALUES (0, 3719358027852259459, -9105660896860752857, 'post /user/', 3719358027852259459, NULL, 1565516136995111, NULL);
INSERT INTO `zipkin_spans` VALUES (0, 3719358027852259459, -7735009332324576904, 'post', -9105660896860752857, NULL, 1565516137000084, 13963);
INSERT INTO `zipkin_spans` VALUES (0, 3719358027852259459, -4646717793053461180, 'save-sys-log', -9105660896860752857, NULL, 1565516137082305, 38298);
INSERT INTO `zipkin_spans` VALUES (0, 3719358027852259459, 2402364196403592865, 'post', -4646717793053461180, NULL, 1565516137093103, 25313);
INSERT INTO `zipkin_spans` VALUES (0, 3719358027852259459, 4065389773714106800, 'async', -9105660896860752857, NULL, 1565516137082000, 38726);
INSERT INTO `zipkin_spans` VALUES (0, 4199721487034974718, 213462493218474059, 'post', 3463300795218433453, NULL, 1565513525178038, 5864);
INSERT INTO `zipkin_spans` VALUES (0, 4199721487034974718, 3463300795218433453, 'get /dept/tree', 4199721487034974718, NULL, 1565513525175034, NULL);
INSERT INTO `zipkin_spans` VALUES (0, 4778990109135373312, -8674154234655274627, 'save-sys-log', 7190951313902771152, NULL, 1564127452854322, 498263);
INSERT INTO `zipkin_spans` VALUES (0, 4778990109135373312, -5398263470130861237, 'async', 7190951313902771152, NULL, 1564127452853000, 499692);
INSERT INTO `zipkin_spans` VALUES (0, 4778990109135373312, 1370163678030963890, 'post', -8674154234655274627, NULL, 1564127453244839, 93935);
INSERT INTO `zipkin_spans` VALUES (0, 4778990109135373312, 6111860762014105667, 'post', 7190951313902771152, NULL, 1564127452602389, 20981);
INSERT INTO `zipkin_spans` VALUES (0, 4778990109135373312, 7190951313902771152, 'post /menu/', 4778990109135373312, NULL, 1564127452592231, NULL);
INSERT INTO `zipkin_spans` VALUES (0, 4899617154936566187, -3742288722538773892, 'post', -3546005529701156241, NULL, 1565513269784275, 18306);
INSERT INTO `zipkin_spans` VALUES (0, 4899617154936566187, -3546005529701156241, 'get /user/info', 4899617154936566187, NULL, 1565513269778072, NULL);
INSERT INTO `zipkin_spans` VALUES (0, 4909776268729705650, -6897733441299925228, 'get /menu/tree', 4909776268729705650, NULL, 1566022363145122, NULL);
INSERT INTO `zipkin_spans` VALUES (0, 4909776268729705650, 1940882414332737998, 'post', -6897733441299925228, NULL, 1566022363159111, 14519);
INSERT INTO `zipkin_spans` VALUES (0, 5238252700695042326, -3995930151166512581, 'post', -605517523891978658, NULL, 1565513527449040, 9641);
INSERT INTO `zipkin_spans` VALUES (0, 5238252700695042326, -605517523891978658, 'get /user/{id:^[_\',.@a-za-z0-9-]*$}', 5238252700695042326, NULL, 1565513527446039, NULL);
INSERT INTO `zipkin_spans` VALUES (0, 5511027341642523932, -4691941664588638033, 'get /scheme/form-data', 5511027341642523932, NULL, 1564147630218085, NULL);
INSERT INTO `zipkin_spans` VALUES (0, 5511027341642523932, 6545413765238496601, 'post', -4691941664588638033, NULL, 1564147630219052, 7348);
INSERT INTO `zipkin_spans` VALUES (0, 5632143410142579208, -7774782370477556542, 'get /dict/codes', 5632143410142579208, NULL, 1565512921252430, NULL);
INSERT INTO `zipkin_spans` VALUES (0, 5632143410142579208, 5473597828406620825, 'post', -7774782370477556542, NULL, 1565512921265234, 109712);
INSERT INTO `zipkin_spans` VALUES (0, 5673805893290378162, -3254344565554196188, 'get /user/info', 5673805893290378162, NULL, 1565516443654042, NULL);
INSERT INTO `zipkin_spans` VALUES (0, 5673805893290378162, -2378753179746003079, 'post', -3254344565554196188, NULL, 1565516443657149, 14981);
INSERT INTO `zipkin_spans` VALUES (0, 5865426433412924760, -4038519678537304339, 'get /dept/user-tree', 5865426433412924760, NULL, 1564147929856085, NULL);
INSERT INTO `zipkin_spans` VALUES (0, 5865426433412924760, 3636337855647556068, 'post', -4038519678537304339, NULL, 1564147929863061, 9289);
INSERT INTO `zipkin_spans` VALUES (0, 6013133406702748688, -2628634802612973396, 'get /role/', 6013133406702748688, NULL, 1564147766109083, NULL);
INSERT INTO `zipkin_spans` VALUES (0, 6013133406702748688, 6164247087470285309, 'post', -2628634802612973396, NULL, 1564147766114173, 11860);
INSERT INTO `zipkin_spans` VALUES (0, 6562926606632462282, -2279825729456383093, 'post', 8796924593109324980, NULL, 1564127133294039, 7488);
INSERT INTO `zipkin_spans` VALUES (0, 6562926606632462282, 8796924593109324980, 'get /menu/', 6562926606632462282, NULL, 1564127133291040, NULL);
INSERT INTO `zipkin_spans` VALUES (0, 6835945609450209147, 6835945609450209147, 'async', NULL, NULL, 1565515336254000, 35594);
INSERT INTO `zipkin_spans` VALUES (0, 6885068868983485372, 2608699163923058582, 'post', 7473558721986038682, NULL, 1566022412281061, 11723);
INSERT INTO `zipkin_spans` VALUES (0, 6885068868983485372, 7473558721986038682, 'get /menu/user-menu', 6885068868983485372, NULL, 1566022412275097, NULL);
INSERT INTO `zipkin_spans` VALUES (0, 6894246148321329473, -4488172146535554564, 'post', -1142619961319169511, NULL, 1564147800497037, 9220);
INSERT INTO `zipkin_spans` VALUES (0, 6894246148321329473, -1142619961319169511, 'get /menu/', 6894246148321329473, NULL, 1564147800495042, NULL);
INSERT INTO `zipkin_spans` VALUES (0, 6911326512282472477, 6911326512282472477, 'async', NULL, NULL, 1564127280833000, 43431);
INSERT INTO `zipkin_spans` VALUES (0, 6954355325704957947, 6954355325704957947, 'async', NULL, NULL, 1564144562595000, 782918);
INSERT INTO `zipkin_spans` VALUES (0, 7137541702423205482, -6768674554799681420, 'post', -5123544269024153221, NULL, 1565513405942039, 7378);
INSERT INTO `zipkin_spans` VALUES (0, 7137541702423205482, -5372157265008047820, 'post', 6287603609518013260, NULL, 1565513406001103, 14495);
INSERT INTO `zipkin_spans` VALUES (0, 7137541702423205482, -5123544269024153221, 'post /menu/', 7137541702423205482, NULL, 1565513405940038, NULL);
INSERT INTO `zipkin_spans` VALUES (0, 7137541702423205482, -4084289593524695016, 'async', -5123544269024153221, NULL, 1565513405996000, 21933);
INSERT INTO `zipkin_spans` VALUES (0, 7137541702423205482, 6287603609518013260, 'save-sys-log', -5123544269024153221, NULL, 1565513405996193, 21665);
INSERT INTO `zipkin_spans` VALUES (0, 7181797609704093568, -4987766697490223013, 'post', -3198899466499725070, NULL, 1564147881336109, 16913);
INSERT INTO `zipkin_spans` VALUES (0, 7181797609704093568, -3198899466499725070, 'get /dict/codes', 7181797609704093568, NULL, 1564147881327124, NULL);
INSERT INTO `zipkin_spans` VALUES (0, 7268522765970669814, 7268522765970669814, 'async', NULL, NULL, 1565512200133000, 803274);
INSERT INTO `zipkin_spans` VALUES (0, 7472449667980354619, -2675402958197466783, 'post', 8810264056298482633, NULL, 1565516414712044, 9766);
INSERT INTO `zipkin_spans` VALUES (0, 7472449667980354619, 8810264056298482633, 'get /menu/', 7472449667980354619, NULL, 1565516414709098, NULL);
INSERT INTO `zipkin_spans` VALUES (0, 7499200519655978951, -5672175635464032231, 'get /user/info', 7499200519655978951, NULL, 1566022353207059, NULL);
INSERT INTO `zipkin_spans` VALUES (0, 7499200519655978951, 7433681128120479622, 'post', -5672175635464032231, NULL, 1566022353210125, 14085);
INSERT INTO `zipkin_spans` VALUES (0, 7610887752079939934, 7610887752079939934, 'async', NULL, NULL, 1566013507351000, 796043);
INSERT INTO `zipkin_spans` VALUES (0, 7674822648128898262, -4731720891015785583, 'get /table/table-list', 7674822648128898262, NULL, 1564147615088096, NULL);
INSERT INTO `zipkin_spans` VALUES (0, 7674822648128898262, 694147418137379562, 'post', -4731720891015785583, NULL, 1564147615089075, 11069);
INSERT INTO `zipkin_spans` VALUES (0, 8115825570070754608, 8115825570070754608, 'async', NULL, NULL, 1566020101285000, 768243);
INSERT INTO `zipkin_spans` VALUES (0, 8678807562662393941, -7387131151831318932, 'get /dept/user-tree', 8678807562662393941, NULL, 1564149792191044, NULL);
INSERT INTO `zipkin_spans` VALUES (0, 8678807562662393941, -4101361604169486532, 'post', -7387131151831318932, NULL, 1564149792194038, 9174);
INSERT INTO `zipkin_spans` VALUES (0, 8992016267829347601, -4193095262562206421, 'get /dept/user-tree', 8992016267829347601, NULL, 1564144476870049, NULL);
INSERT INTO `zipkin_spans` VALUES (0, 8992016267829347601, 2627253114081378149, 'post', -4193095262562206421, NULL, 1564144476874063, 9973);
INSERT INTO `zipkin_spans` VALUES (0, 9061347141147650074, -8456985985003462484, 'get /menu/', 9061347141147650074, NULL, 1565516157526056, NULL);
INSERT INTO `zipkin_spans` VALUES (0, 9061347141147650074, -2325742125000844633, 'post', -8456985985003462484, NULL, 1565516157528049, 10079);

SET FOREIGN_KEY_CHECKS = 1;
