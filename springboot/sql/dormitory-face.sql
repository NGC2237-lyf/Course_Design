/*
 Navicat Premium Data Transfer

 Source Server         : localhsot
 Source Server Type    : MySQL
 Source Server Version : 80028
 Source Host           : localhost:3306
 Source Schema         : dormitory

 Target Server Type    : MySQL
 Target Server Version : 80028
 File Encoding         : 65001

 Date: 07/01/2024 20:33:52
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for adjust_room
-- ----------------------------
DROP TABLE IF EXISTS `adjust_room`;
CREATE TABLE `adjust_room`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '账号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `currentroom_id` int NOT NULL COMMENT '当前房间',
  `currentbed_id` int NOT NULL COMMENT '当前床位号',
  `towardsroom_id` int NOT NULL COMMENT '目标房间',
  `towardsbed_id` int NOT NULL COMMENT '目标床位号',
  `state` enum('未处理','通过','驳回') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '未处理' COMMENT '申请状态',
  `apply_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '申请时间',
  `finish_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '处理时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of adjust_room
-- ----------------------------
INSERT INTO `adjust_room` VALUES (2, 'stu1', '张三', 1101, 1, 1102, 4, '通过', '2023-06-26 14:35:02', '2023-06-26 14:35:02');
INSERT INTO `adjust_room` VALUES (5, 'stu2', '田田', 1101, 2, 1104, 1, '未处理', '2023-06-26 14:35:02', '2023-06-26 14:35:02');
INSERT INTO `adjust_room` VALUES (6, 'stu3', '吉安', 1101, 3, 1104, 2, '驳回', '2023-06-26 14:35:02', '2023-06-26 14:35:02');
INSERT INTO `adjust_room` VALUES (7, 'stu9', '德萨', 1103, 2, 1105, 1, '未处理', '2023-06-26 14:35:02', '2023-06-26 14:35:02');
INSERT INTO `adjust_room` VALUES (8, 'stu6', '泡泡', 1102, 2, 1104, 4, '未处理', '2023-06-26 14:35:02', '2023-06-26 14:35:02');
INSERT INTO `adjust_room` VALUES (9, '2020007694', '刘宇航', 1101, 1, 1104, 2, '驳回', '2023-06-26 14:35:02', '2023-06-26 14:35:02');
INSERT INTO `adjust_room` VALUES (10, '2020007694', '刘宇航', 1101, 1, 1104, 1, '驳回', '2023-06-26 14:35:02', '2023-06-26 14:35:02');
INSERT INTO `adjust_room` VALUES (11, '2020007694', '刘宇航', 1101, 1, 1104, 1, '驳回', '2023-06-26 14:35:02', '2023-06-26 14:35:02');
INSERT INTO `adjust_room` VALUES (12, '2020007694', '刘宇航', 1101, 1, 1104, 1, '驳回', '2023-06-26 14:35:02', '2023-06-26 14:35:02');
INSERT INTO `adjust_room` VALUES (13, '2020007694', '刘宇航', 1101, 1, 1104, 1, '通过', '2023-06-26 14:35:02', '2023-06-26 14:35:02');

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `gender` enum('男','女') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '男' COMMENT '性别',
  `age` int NOT NULL COMMENT '年龄',
  `phone_num` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('admin', '123456', '刘宇航', '男', 22, '15234390329', '1531137510@qq.com', '7d9ba1c8d26f4fa88b262dc13e73cfff.jpg');

-- ----------------------------
-- Table structure for dorm_build
-- ----------------------------
DROP TABLE IF EXISTS `dorm_build`;
CREATE TABLE `dorm_build`  (
  `dormbuild_id` int NOT NULL COMMENT '宿舍楼号码',
  `dormbuild_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '宿舍楼名称',
  `dormbuild_detail` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '宿舍楼备注',
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dorm_build
-- ----------------------------
INSERT INTO `dorm_build` VALUES (1, '一号楼', '男宿舍', 1);
INSERT INTO `dorm_build` VALUES (2, '二号楼', '女宿舍', 2);
INSERT INTO `dorm_build` VALUES (3, '三号楼', '男宿舍', 3);
INSERT INTO `dorm_build` VALUES (4, '四号楼', '女宿舍', 4);

-- ----------------------------
-- Table structure for dorm_manager
-- ----------------------------
DROP TABLE IF EXISTS `dorm_manager`;
CREATE TABLE `dorm_manager`  (
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '123456' COMMENT '密码',
  `dormbuild_id` int NOT NULL COMMENT '所管理的宿舍楼栋号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名字',
  `gender` enum('男','女') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '男' COMMENT '性别',
  `age` int NOT NULL COMMENT '年龄',
  `phone_num` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dorm_manager
-- ----------------------------
INSERT INTO `dorm_manager` VALUES ('dorm1', '123456', 1, '张三', '男', 35, '15995917873', NULL, NULL);
INSERT INTO `dorm_manager` VALUES ('dorm2', '123456', 2, '李四', '女', 55, '15995917874', NULL, NULL);
INSERT INTO `dorm_manager` VALUES ('dorm3', '123456', 3, '王五', '男', 38, '15896875201', NULL, NULL);
INSERT INTO `dorm_manager` VALUES ('dorm4', '123456', 4, '赵花', '女', 40, '15877535247', NULL, NULL);

-- ----------------------------
-- Table structure for dorm_room
-- ----------------------------
DROP TABLE IF EXISTS `dorm_room`;
CREATE TABLE `dorm_room`  (
  `dormroom_id` int NOT NULL COMMENT '宿舍房间号',
  `dormbuild_id` int NOT NULL COMMENT '宿舍楼号',
  `floor_num` int NOT NULL COMMENT '楼层',
  `max_capacity` int NOT NULL DEFAULT 4 COMMENT '房间最大入住人数',
  `current_capacity` int NOT NULL DEFAULT 0 COMMENT '当前房间入住人数',
  `first_bed` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '一号床位',
  `second_bed` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '二号床位',
  `third_bed` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '三号床位',
  `fourth_bed` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '四号床位',
  PRIMARY KEY (`dormroom_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dorm_room
-- ----------------------------
INSERT INTO `dorm_room` VALUES (1101, 1, 1, 4, 3, NULL, 'stu2', 'stu3', 'stu4');
INSERT INTO `dorm_room` VALUES (1102, 1, 1, 4, 4, 'stu5', 'stu6', 'stu7', 'stu1');
INSERT INTO `dorm_room` VALUES (1103, 1, 1, 4, 4, 'stu8', 'stu9', 'stu10', 'stu11');
INSERT INTO `dorm_room` VALUES (1104, 1, 1, 4, 1, '2020007694', NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (1105, 1, 1, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (1201, 1, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (1202, 1, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (1203, 1, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (1204, 1, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (1205, 1, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (1301, 1, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (1302, 1, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (1303, 1, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (1304, 1, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (1305, 1, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (2101, 2, 1, 4, 3, 'stu12', 'stu13', 'stu14', NULL);
INSERT INTO `dorm_room` VALUES (2102, 2, 1, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (2103, 2, 1, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (2104, 2, 1, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (2105, 2, 1, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (2201, 2, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (2202, 2, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (2203, 2, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (2204, 2, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (2205, 2, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (2301, 2, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (2302, 2, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (2303, 2, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (2304, 2, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (2305, 2, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (3101, 3, 1, 4, 3, 'stu15', 'stu16', 'stu16', NULL);
INSERT INTO `dorm_room` VALUES (3102, 3, 1, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (3103, 3, 1, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (3104, 3, 1, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (3105, 3, 1, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (3201, 3, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (3202, 3, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (3203, 3, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (3204, 3, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (3205, 3, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (3301, 3, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (3302, 3, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (3303, 3, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (3304, 3, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (3305, 3, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (4101, 4, 1, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (4102, 4, 1, 4, 3, 'stu17', 'stu18', 'stu19', NULL);
INSERT INTO `dorm_room` VALUES (4103, 4, 1, 4, 1, 'stu20', NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (4104, 4, 1, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (4105, 4, 1, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (4201, 4, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (4202, 4, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (4203, 4, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (4204, 4, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (4205, 4, 2, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (4301, 4, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (4302, 4, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (4303, 4, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (4304, 4, 3, 4, 0, NULL, NULL, NULL, NULL);
INSERT INTO `dorm_room` VALUES (4305, 4, 3, 4, 0, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主题',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容',
  `author` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '作者',
  `release_time` datetime NOT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 192 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (3, '期末考试通知', '<p>学期末降至，本学期所教授的课程也接近尾声，同学们利用好最后一段时间，好好复习争取考个好成绩！</p>', '刘宇航', '2023-06-28 15:20:33');
INSERT INTO `notice` VALUES (164, '招生宣传资料印刷服务成交结果公告', 'http://jwc.tyut.edu.cn/info/1057/4601.htm', '太原理工大学', '2023-06-21 00:00:00');
INSERT INTO `notice` VALUES (165, '关于2023年推荐省级教育教学改革创新项目（思想政治理论课）的公示', 'http://jwc.tyut.edu.cn/info/1057/4585.htm', '太原理工大学', '2023-06-05 00:01:00');
INSERT INTO `notice` VALUES (166, '关于2023年推荐省级教育教学改革创新项目的公示', 'http://jwc.tyut.edu.cn/info/1057/4571.htm', '太原理工大学', '2023-05-15 00:02:00');
INSERT INTO `notice` VALUES (167, '关于加强2023届本科生毕业设计（论文）管理工作的通知', 'http://jwc.tyut.edu.cn/info/1057/4570.htm', '太原理工大学', '2023-05-12 00:03:00');
INSERT INTO `notice` VALUES (168, '关于依托我校申报的2023年省级指令性项目结果公示', 'http://jwc.tyut.edu.cn/info/1057/4569.htm', '太原理工大学', '2023-05-05 00:04:00');
INSERT INTO `notice` VALUES (169, '关于申报2023年山西省高等学校教学改革创新一般项目（本科教改项目）的通知', 'http://jwc.tyut.edu.cn/info/1057/4565.htm', '太原理工大学', '2023-04-29 00:05:00');
INSERT INTO `notice` VALUES (170, '本科生院选任科级干部工作方案', 'http://jwc.tyut.edu.cn/info/1057/4563.htm', '太原理工大学', '2023-04-26 00:06:00');
INSERT INTO `notice` VALUES (171, '关于2023年特殊原因转专业拟录取学生名单公示', 'http://jwc.tyut.edu.cn/info/1057/4560.htm', '太原理工大学', '2023-04-21 00:07:00');
INSERT INTO `notice` VALUES (172, '关于2022级、2021二年级本科生转专业拟录名单公示', 'http://jwc.tyut.edu.cn/info/1057/4559.htm', '太原理工大学', '2023-04-13 00:08:00');
INSERT INTO `notice` VALUES (173, '关于做好2022级、2021级二年级本科生转专业工作的通知', 'http://jwc.tyut.edu.cn/info/1057/4537.htm', '太原理工大学', '2023-03-24 00:09:00');
INSERT INTO `notice` VALUES (174, '关于本学期通识基础选修实体课的选课结课及开课通知', 'http://jwc.tyut.edu.cn/info/1057/4511.htm', '太原理工大学', '2023-02-24 00:10:00');
INSERT INTO `notice` VALUES (175, '关于2022-2023学年春季学期2018-2021年级通识基础选修课的选课通知', 'http://jwc.tyut.edu.cn/info/1057/4505.htm', '太原理工大学', '2023-02-16 00:11:00');
INSERT INTO `notice` VALUES (176, '关于开展2023届本科生毕业设计（论文）工作的通知', 'http://jwc.tyut.edu.cn/info/1057/4504.htm', '太原理工大学', '2023-02-13 00:12:00');
INSERT INTO `notice` VALUES (177, '关于2023年省级卓越（拔尖）人才培养改革试点专业申报推荐工作的通知', 'http://jwc.tyut.edu.cn/info/1057/4503.htm', '太原理工大学', '2023-02-08 00:13:00');
INSERT INTO `notice` VALUES (178, '太原理工大学高等学历继续教育校外教学点设置公示（二）', 'http://jwc.tyut.edu.cn/info/1057/4502.htm', '太原理工大学', '2023-02-04 00:14:00');
INSERT INTO `notice` VALUES (179, '关于公布宗复学院2022级学生导师的通知', 'http://jwc.tyut.edu.cn/info/1057/4738.htm', '太原理工大学', '2023-11-15 00:00:00');
INSERT INTO `notice` VALUES (180, '关于推荐第二届高等学校优秀思政课教师奖励基金候选人的公示', 'http://jwc.tyut.edu.cn/info/1057/4737.htm', '太原理工大学', '2023-11-14 00:01:00');
INSERT INTO `notice` VALUES (181, '关于2023年度校级一流本科课程和“课程思政”示范课程立项培育结果的公示', 'http://jwc.tyut.edu.cn/info/1057/4731.htm', '太原理工大学', '2023-11-03 00:02:00');
INSERT INTO `notice` VALUES (182, '关于2023年度校级一流本科课程和“课程思政”示范课程建设立项结果的公示', 'http://jwc.tyut.edu.cn/info/1057/4721.htm', '太原理工大学', '2023-10-27 00:03:00');
INSERT INTO `notice` VALUES (183, '宗复学院导师制通知', 'http://jwc.tyut.edu.cn/info/1057/4711.htm', '太原理工大学', '2023-10-10 00:04:00');
INSERT INTO `notice` VALUES (184, '本科核心基础课教师、本科特优毕业设计（论文）指导教师“中国工商银行奖教金”拟获奖名单公示', 'http://jwc.tyut.edu.cn/info/1057/4701.htm', '太原理工大学', '2023-09-22 00:05:00');
INSERT INTO `notice` VALUES (185, '关于申报2023年教育部产学合作协同育人项目的通知', 'http://jwc.tyut.edu.cn/info/1057/4691.htm', '太原理工大学', '2023-09-21 00:06:00');
INSERT INTO `notice` VALUES (186, '关于开展本科核心基础课教师、本科特优毕业设计（论文）指导教师“中国工商银行奖教金”评选工作的通知', 'http://jwc.tyut.edu.cn/info/1057/4686.htm', '太原理工大学', '2023-09-14 00:07:00');
INSERT INTO `notice` VALUES (187, '关于开展2023年度校级一流本科课程、“课程思政”示范课程立项建设申报的通知', 'http://jwc.tyut.edu.cn/info/1057/4684.htm', '太原理工大学', '2023-09-13 00:08:00');
INSERT INTO `notice` VALUES (188, '关于本科教学改革创新项目结题验收工作的通知', 'http://jwc.tyut.edu.cn/info/1057/4674.htm', '太原理工大学', '2023-09-11 00:10:00');
INSERT INTO `notice` VALUES (189, '关于2023-2024学年秋季学期2023级本科生通识必修课《高等数学A(一)》的选课通知', 'http://jwc.tyut.edu.cn/info/1057/4673.htm', '太原理工大学', '2023-09-08 00:11:00');
INSERT INTO `notice` VALUES (190, '关于公布2023届本科毕业生特优毕业设计（论文）评选结果的通知', 'http://jwc.tyut.edu.cn/info/1057/4656.htm', '太原理工大学', '2023-08-28 00:12:00');
INSERT INTO `notice` VALUES (191, '关于2023-2024学年秋季学期2019-2021年级通识基础选修课的选课通知', 'http://jwc.tyut.edu.cn/info/1057/4654.htm', '太原理工大学', '2023-08-28 00:13:00');
INSERT INTO `notice` VALUES (192, '关于2022年级通识选修创新创业课程的选课说明', 'http://jwc.tyut.edu.cn/info/1057/4653.htm', '太原理工大学', '2023-08-28 00:14:00');

-- ----------------------------
-- Table structure for repair
-- ----------------------------
DROP TABLE IF EXISTS `repair`;
CREATE TABLE `repair`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '订单编号',
  `repairer` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '报修人',
  `dormbuild_id` int NOT NULL COMMENT '报修宿舍楼',
  `dormroom_id` int NOT NULL COMMENT '报修宿舍房间号',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '表单标题',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '表单内容',
  `state` enum('完成','未完成') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '未完成' COMMENT '订单状态（是否维修完成）',
  `order_buildtime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '订单创建时间',
  `order_finishtime` datetime NULL DEFAULT NULL COMMENT '订单完成时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2139713537 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of repair
-- ----------------------------
INSERT INTO `repair` VALUES (-1371443198, '刘宇航', 1, 1101, '水龙头坏了', '水龙头坏了', '完成', '2023-06-26 14:35:02', '2023-06-26 14:35:02');
INSERT INTO `repair` VALUES (-1182195711, 'NFC用户', 1, 1001, '水龙头需要保修！', '水龙头需要保修！', '未完成', '2023-07-04 15:12:45', NULL);
INSERT INTO `repair` VALUES (-218079230, '刘宇航', 1, 1101, '水管坏了', '一直漏水', '完成', '2023-06-26 14:35:02', '2023-06-26 14:35:02');
INSERT INTO `repair` VALUES (-12455934, '张三', 1, 1101, '阳台漏水', '阳台使用时会漏水请来修理', '完成', '2023-06-26 14:35:02', '2023-06-26 14:35:02');
INSERT INTO `repair` VALUES (1, '强强', 1, 1101, '水龙头损坏', '水龙头损坏，请来1-1101宿舍修理', '完成', '2023-06-26 14:35:02', '2023-06-26 14:35:02');
INSERT INTO `repair` VALUES (2, '七七', 1, 1101, '门把手损坏', '门把手损坏，请来修理', '完成', '2023-06-26 14:35:02', '2023-06-26 14:35:02');
INSERT INTO `repair` VALUES (3, '丽丽', 2, 2102, '水池损坏', '水池损坏，请来修理', '完成', '2023-06-26 14:35:02', '2023-06-26 14:35:02');
INSERT INTO `repair` VALUES (4, '贝贝', 1, 1102, '阳台漏水', '宿舍阳台漏水，速来修理', '完成', '2023-06-26 14:35:02', '2023-06-26 14:35:02');
INSERT INTO `repair` VALUES (5, '哈哈', 1, 1101, '窗台损坏', '宿舍窗台损坏，速来修理', '完成', '2023-06-26 14:35:02', '2023-06-26 14:35:02');
INSERT INTO `repair` VALUES (6, '张三', 1, 1101, '浴室天花板漏水', '浴室天花板漏水', '完成', '2023-06-26 14:35:02', '2023-06-26 14:35:02');
INSERT INTO `repair` VALUES (545869825, '水管', 1, 1101, '水管坏了', '水管坏了', '未完成', '2023-12-01 15:21:13', NULL);
INSERT INTO `repair` VALUES (1065992193, '刘宇航', 1, 1104, '水龙头坏了', '水龙头坏了', '完成', '2023-06-26 14:35:02', '2023-06-26 14:35:02');
INSERT INTO `repair` VALUES (1833549825, '刘宇航', 1, 1101, '风扇坏了', '它不吹风了', '完成', '2023-06-26 14:35:02', '2023-06-26 14:35:02');
INSERT INTO `repair` VALUES (2139713537, '刘宇航', 1, 1101, '下水道堵了', '下水道堵了', '完成', '2023-06-26 14:35:02', '2023-06-26 14:35:02');

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '学号',
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '123456' COMMENT '密码',
  `age` int UNSIGNED NOT NULL COMMENT '年龄',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `gender` enum('男','女') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '男' COMMENT '性别',
  `phone_num` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `institute` varchar(75) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '学院',
  `major` varchar(75) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '专业班级',
  PRIMARY KEY (`username`) USING BTREE,
  UNIQUE INDEX `stu_num`(`username` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('2020007694', '123456', 22, '刘宇航', '男', '15234390329', '15311****@qq.com', '', '软件学院', '软件2029');
INSERT INTO `student` VALUES ('2020007696', '147258369', 21, '赵新浩', '男', '1770346****', '16054*****@qq.com', NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu1', '123456', 18, '张三', '男', '15875696511', NULL, '', '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu10', '123456', 19, '马克', '女', '15889635874', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu11', '123456', 16, '巧巧', '女', '18978431781', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu12', '123456', 17, '丽丽', '女', '17986573547', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu13', '123456', 18, '美美', '女', '15896475354', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu14', '123456', 20, '拉拉', '女', '14896527357', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu15', '123456', 18, '贝贝', '男', '15896745351', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu16', '123456', 18, '力力', '男', '14596475257', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu17', '123456', 18, '阿成', '男', '15896542147', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu18', '123456', 19, '阿达', '女', '14785635874', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu19', '123456', 19, '帕森斯', '男', '15889658475', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu2', '123456', 18, '田田', '男', '15875359641', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu20', '123456', 21, '柠檬', '男', '15874563558', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu21', '123456', 21, '面对', '男', '15889635874', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu22', '123456', 25, '等等', '男', '15589963321', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu3', '123456', 18, '吉安', '男', '15798657350', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu4', '123456', 22, '力力', '男', '15878965874', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu5', '123456', 19, '哦哦', '男', '15897535478', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu6', '123456', 18, '泡泡', '男', '18987554765', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu7', '123456', 15, '刚刚', '男', '15897543854', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu8', '123456', 18, '七七', '男', '12332143215', NULL, NULL, '软件学院', '软件2029');
INSERT INTO `student` VALUES ('stu9', '123456', 20, '德萨', '男', '15889658741', NULL, NULL, '软件学院', '软件2029');

-- ----------------------------
-- Table structure for user_face_info
-- ----------------------------
DROP TABLE IF EXISTS `user_face_info`;
CREATE TABLE `user_face_info`  (
  `face_id` int NOT NULL AUTO_INCREMENT COMMENT '面部ID',
  `face_feature` blob NOT NULL COMMENT '人脸特征',
  `user_role` int NOT NULL COMMENT '用户角色',
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  PRIMARY KEY (`face_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_face_info
-- ----------------------------
INSERT INTO `user_face_info` VALUES (5, 0x0080FA440000A04101DCAC3C8F8130BD8F87A33D0686F9BD7BB13F3C721561BC281A713CD533853D7EEAE8BDC3FA5FBACB24143C70B24BBD6077E9BD786515BE4D2FB3BBD60E80BA8994173E19D499BDBB49513DFD04C7BB7D4C183CFEA6FBBA4719FABB9A8BB2BD103617BDE06A8CBD0C8925BD2C72BEBC78382EBD2D8DBCBD272F6CBC9344B93C611380BC98ECB6BD6B15A2BD883FE9BB0AA589B9A20753BBF155D2BD5C703F3DBF33B23DE07562395C2393BC4956073DB6E44BBCC39109BD29A4233D053BC03C7A4FF9BC2F61B43C37FE36BC9D7CFEBDC675DA3B6AFA94BC9A52453D4B5C99BCD2415C3DF90B8ABD5B2269BD06BD443D624D7EBD6EBAB5BCF11F993DD94DD7BD31CFEB3CB8F7A03AADAB58BC708F90BD015AE7BD72C4073EDC21D63DF39D053D09735B3D698795BCFD47B53D827CD23C4A36673DF5F5133D601F2B3E01E0B83D5A50903C4B3FBDBD1B8E313DE5B413BDEC90F53BFA4CBABB909605BD4273763DE3379DBDF4C4FC3D2FF6EDBDE35E0A3DD8DE0C3DEB2E3A3D91B1CA3DA026E4BC8A48CEBD0323A43C1EE25DBC567E16BDD53C423D034D2FBEEA2FACBD3C2B67BCA5D90D3DC3B207BD90252B3D87DB4B3CCBFD04BD25F0E53C1FAAFCBC840D693DD8ECFFBD95010ABCA96BBF3DB5C7243D564003BB8D914DBD4AC4F13D0F2253BC3714B13DC3A3A73D54847DBCE8D5E7BDB1D90A3DBD84F73D1C7BC5BC5A32903DA3F0003DCE63193E90299D3C6F61ACBD836EE53CD728BE3D44A986BDEB1FC3BB1F33A2BB5D25943DF99991BCB3F2A7BD091B80BC10F44F3D69D0DCBCB808BDBC2EB8E9BD26E1583DC22A623DA8A65ABD2A0D85BD9E99203DAE46903D98D7C63BD6604F3D3485FB3DFD1591BD8D9691BCA70A253D00A902BDCACE06BE996EAA3D10E34C3DDDD825BD08FAD2BC4FD1193E5A0024BEB43AF8BCB516CF3D31BB90BABF6A683DB895A4BC952E3E3D6D1DD93D6D470CBCED6607BD275785BDFA20E5BC9BDB99BC47B881BD0158EBBD27D5FA3A662B943DF5C12A3CF8FA78BC49D8C7BC4B0E71BA888ECFBD5124CB3B59B65D3DE937443D15F36DBDCB1103BC10A4E2BC258C63BD1DBC913BF9084DB9669FDD3B0D8547BDA523C2BD8E84593C7352253DD52B90BDE8FC88BD33FC923D9569213D467971BDA0261F3D7298B7BC4F8D263D1C1179BD23D06FBD9F2BB13CBEE96B3D3C1067BA69F23DBCF7CB45BDD94B9B3DEA61BABB0C8949BD440EB4BCB999FC3DDA1A363C0F170FBE2E88393C30E70ABE500D04BD5A07453D72AE88BD55E2BD3CB0F673BB5C4ACEBC2323643D3065A6BCD02F8BBA5323B63C4AA0A9BC4B878A3C0785D83BD461AABD44C5E83D6A3A56BC2587F13C0B3F10BD47B062BDA9A31EBDD8808DBD11E4893D8E552DBC9D6D2ABDCC41C6BAE968EEBCC837A83DACF4FB3C8935363DB46495BC82107C3BB30ABB3D, 3, 'admin');

-- ----------------------------
-- Table structure for visitor
-- ----------------------------
DROP TABLE IF EXISTS `visitor`;
CREATE TABLE `visitor`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `gender` enum('男','女') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '男' COMMENT '性别',
  `phone_num` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电话',
  `origin_city` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '来源城市',
  `visit_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '来访时间',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '事情',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of visitor
-- ----------------------------
INSERT INTO `visitor` VALUES (1, '张三', '男', '14587896544', '运城', '2023-06-26 14:35:02', '探访孩子');
INSERT INTO `visitor` VALUES (2, '李四', '女', '15774147563', '吕梁', '2023-06-26 14:35:02', '运送快递');
INSERT INTO `visitor` VALUES (3, '啊啊', '男', '14588635774', '临汾', '2023-06-26 14:35:02', '运送食品');
INSERT INTO `visitor` VALUES (5, '刘宇航父母', '男', '15234390322', '吕梁', '2023-06-26 14:35:02', '看访孩子');

SET FOREIGN_KEY_CHECKS = 1;
