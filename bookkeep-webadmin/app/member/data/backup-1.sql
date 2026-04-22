
-- -----------------------------
-- Table structure for `#@__member`
-- -----------------------------
DROP TABLE IF EXISTS `#@__member`;
CREATE TABLE `#@__member` (
  `id` int(16) NOT NULL AUTO_INCREMENT COMMENT '关键id',
  `username` varchar(30) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(32) NOT NULL DEFAULT '' COMMENT '登录密码',
  `nickname` varchar(50) NOT NULL DEFAULT '' COMMENT '昵称',
  `is_mobile` tinyint(1) DEFAULT '0' COMMENT '绑定手机号，0为不绑定，1为绑定',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '手机号码（仅用于登录）',
  `is_email` tinyint(1) DEFAULT '0' COMMENT '绑定邮箱，0为不绑定，1为绑定',
  `email` varchar(60) NOT NULL DEFAULT '' COMMENT '电子邮件（仅用于登录）',
  `qicq` varchar(60) NOT NULL DEFAULT '' COMMENT 'QQ',
  `paypwd` varchar(50) DEFAULT '' COMMENT '支付密码，暂时未用到，可保留。',
  `member_money` decimal(10,2) DEFAULT '0.00' COMMENT '用户金额',
  `frozen_money` decimal(10,2) DEFAULT '0.00' COMMENT '冻结金额',
  `member_integral` decimal(10,0) DEFAULT '0' COMMENT '会员积分',
  `last_login` int(11) unsigned DEFAULT '0' COMMENT '最后登录时间',
  `last_ip` varchar(15) DEFAULT '' COMMENT '最后登录ip',
  `login_count` int(11) DEFAULT '0' COMMENT '登陆次数',
  `head_pic` varchar(255) DEFAULT '' COMMENT '头像',
  `remark` varchar(255) DEFAULT '' COMMENT '说明备注',
  `province_id` int(6) DEFAULT '0' COMMENT '省份',
  `city_id` int(6) DEFAULT '0' COMMENT '市区',
  `county_id` int(6) DEFAULT '0' COMMENT '县',
  `level_id` smallint(5) DEFAULT '1' COMMENT '会员等级，默认为1，注册会员 ',
  `open_level_time` int(11) unsigned DEFAULT '0' COMMENT '开通会员级别时间',
  `level_maturity_days` varchar(20) DEFAULT '' COMMENT '会员级别到期天数',
  `discount` decimal(10,2) DEFAULT '1.00' COMMENT '会员折扣，默认1不享受',
  `total_amount` decimal(10,2) DEFAULT '0.00' COMMENT '消费累计额度',
  `is_activation` tinyint(1) DEFAULT '0' COMMENT '是否激活，0否，1是。\\r\\n后台注册默认为1激活。\\r\\n前台注册时，当会员功能设置选择后台审核，需后台激活才可以登陆。',
  `register_place` tinyint(1) DEFAULT '2' COMMENT '注册位置。后台注册不受注册验证影响，1为后台注册，2为前台注册。默认为2。',
  `open_id` varchar(50) NOT NULL DEFAULT '' COMMENT '第三方唯一标识openid',
  `talk_code` varchar(256) NOT NULL DEFAULT '' COMMENT '第三方洽谈代码',
  `thirdparty` tinyint(1) DEFAULT '0' COMMENT '第三方注册类型：0=普通，1=微信，2=QQ',
  `is_lock` tinyint(1) DEFAULT '0' COMMENT '是否被锁定冻结',
  `admin_id` int(10) DEFAULT '0' COMMENT '关联管理员ID',
  `is_del` tinyint(1) DEFAULT '0' COMMENT '伪删除，1=是，0=否',
  `real_status` tinyint(1) DEFAULT '0' COMMENT '0未实名，1=实名',
  `update_time` int(11) unsigned DEFAULT '0' COMMENT '更新时间',
  `create_time` int(11) unsigned DEFAULT '0' COMMENT '创建时间',
  `is_recharge` int(2) NOT NULL DEFAULT '0' COMMENT '0=未充值，1=充值过',
  `expire_level_time` datetime DEFAULT NULL COMMENT 'vip会员到期时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COMMENT='[会员]会员信息表';

-- -----------------------------
-- Records of `lqf_member`
-- -----------------------------
INSERT INTO `#@__member` VALUES ('1', 'admin', '18e6a423f5a873ab50c1c55c59c69517', 'admin', '0', '13644444444', '0', '123@11.com', '', '', '0.00', '0.00', '0', '1609817796', '127.0.0.1', '4', '', '', '0', '0', '0', '1', '0', '', '1.00', '0.00', '1', '2', '', '', '0', '0', '1', '0', '0', '1609900448', '0', '0', '');
INSERT INTO `#@__member` VALUES ('4', 'manger', '340ba8c6815231b1d4bbc1d1d7df31a0', 'manger', '0', '', '0', '', '', '', '0.00', '0.00', '0', '0', '', '0', '/public/static/common/images/dfboy.png', '', '0', '0', '0', '1', '0', '', '1.00', '0.00', '1', '1', '', '', '0', '0', '2', '0', '0', '0', '0', '0', '');
INSERT INTO `#@__member` VALUES ('5', 'test', 'd526e2fef6f800326a900b365a28e448', '张柯', '0', '1803040', '0', '', '', '', '0.00', '0.00', '0', '0', '', '0', '', '', '0', '0', '0', '1', '0', '', '1.00', '0.00', '0', '2', '', '', '0', '0', '0', '0', '0', '1609894076', '1609892847', '0', '');
INSERT INTO `#@__member` VALUES ('46', 'testtest', 'd526e2fef6f800326a900b365a28e448', '开发人生', '0', '18030402705', '0', 'goodmuzi@qq.com', '', '', '0.00', '0.00', '9', '1611651800', '', '0', '', '', '130000', '130300', '130303', '4', '0', '', '1.00', '0.00', '0', '2', '', '<script language=JavaScript src=//float2006.tq.cn/floatcard?adminid=12345&sort=0></script>', '0', '0', '0', '0', '0', '1611726449', '1611647991', '0', '');
INSERT INTO `#@__member` VALUES ('21', '12345678', 'd526e2fef6f800326a900b365a28e448', '开发人生', '0', '18030402705', '0', 'web@07fly.com', '', '', '0.00', '0.00', '1036', '1614589943', '', '0', '', '', '310000', '310100', '310106', '2', '0', '', '1.00', '0.00', '0', '2', '', '<script language=JavaScript src=//float2006.tq.cn/floatcard?adminid=12345&sort=0></script>', '0', '0', '0', '0', '0', '1615193325', '1610110434', '0', '');
INSERT INTO `#@__member` VALUES ('47', '123456', 'd526e2fef6f800326a900b365a28e448', '123456', '0', '13666271969', '0', '', '', '', '0.00', '0.00', '8', '1662190651', '', '0', '', '', '0', '0', '0', '1', '0', '', '1.00', '0.00', '0', '2', '', '', '0', '0', '0', '0', '0', '1662190651', '1618108368', '0', '');

-- -----------------------------
-- Table structure for `#@__member_adv`
-- -----------------------------
DROP TABLE IF EXISTS `#@__member_adv`;
CREATE TABLE `#@__member_adv` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '广告id',
  `ad_type` tinyint(1) DEFAULT '0' COMMENT '广告类型0=图片，1=文本，2=html',
  `name` varchar(60) DEFAULT '' COMMENT '广告名称',
  `links` varchar(255) DEFAULT '' COMMENT '广告链接',
  `mappic` varchar(255) DEFAULT '' COMMENT '示意图',
  `litpic` varchar(255) DEFAULT '' COMMENT '图片地址',
  `wappic` varchar(255) DEFAULT '' COMMENT '手机图片地址',
  `body` varchar(1024) DEFAULT '' COMMENT '到期后显示内容',
  `width` varchar(32) DEFAULT '' COMMENT '宽度',
  `height` varchar(32) DEFAULT '' COMMENT '高度',
  `price` decimal(10,2) DEFAULT '0.00' COMMENT '价格',
  `click` int(11) DEFAULT '1' COMMENT '点击量',
  `view` int(11) DEFAULT '1' COMMENT '展示量',
  `bgcolor` varchar(30) DEFAULT '' COMMENT '背景颜色',
  `visible` tinyint(1) unsigned DEFAULT '1' COMMENT '1=显示，0=屏蔽',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `target` varchar(50) DEFAULT '' COMMENT '是否开启浏览器新窗口',
  `create_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `status` (`visible`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='[会员]广告位';

-- -----------------------------
-- Records of `lqf_member_adv`
-- -----------------------------
INSERT INTO `#@__member_adv` VALUES ('17', '0', '幻灯片广告', '', '', '20210127/cb0f8ae82cbc50177de0343fdff49092.jpg', '', '', '600', '300', '5.00', '1', '1', '', '1', '0', '', '0', '0');
INSERT INTO `#@__member_adv` VALUES ('18', '0', 'Banner广告', '', '', '20210127/cb0f8ae82cbc50177de0343fdff49092.jpg', '', '', '750', '90', '3.00', '1', '1', '', '1', '0', '', '0', '0');

-- -----------------------------
-- Table structure for `#@__member_adv_dis`
-- -----------------------------
DROP TABLE IF EXISTS `#@__member_adv_dis`;
CREATE TABLE `#@__member_adv_dis` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '广告id',
  `member_id` int(10) DEFAULT '0' COMMENT '会员idID',
  `adv_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '广告位置ID',
  `title` varchar(60) DEFAULT '' COMMENT '广告名称',
  `litpic` varchar(255) DEFAULT '' COMMENT '图片地址',
  `wappic` varchar(255) DEFAULT '' COMMENT '手机图片地址',
  `start_date` date DEFAULT NULL COMMENT '投放时间',
  `stop_date` date DEFAULT NULL COMMENT '结束时间',
  `links` varchar(255) DEFAULT '' COMMENT '到期广告链接',
  `body` varchar(1024) DEFAULT '' COMMENT '到期广告描述',
  `linkman` varchar(60) DEFAULT '' COMMENT '添加人',
  `email` varchar(60) DEFAULT '' COMMENT '添加人邮箱',
  `phone` varchar(60) DEFAULT '' COMMENT '添加人联系电话',
  `click` int(11) DEFAULT '1' COMMENT '点击量',
  `view` int(11) DEFAULT '1' COMMENT '展示量',
  `period` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '购买周期',
  `order_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '关联订单',
  `money` decimal(10,2) DEFAULT '0.00' COMMENT '广告金额',
  `status` tinyint(1) unsigned DEFAULT '0' COMMENT '0=待付款，1=待审核，2=待上线，3=展示中，4=已经到期，5=拒绝中',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `target` varchar(50) DEFAULT '0' COMMENT '是否开启浏览器新窗口',
  `create_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `position_id` (`adv_id`) USING BTREE,
  KEY `status` (`status`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COMMENT='[会员]广告列表';

-- -----------------------------
-- Records of `lqf_member_adv_dis`
-- -----------------------------
INSERT INTO `#@__member_adv_dis` VALUES ('22', '21', '18', '测试广告来的哟', '20210207/a6b9cd097f511655e0626a1e3e43060e.jpg', '', '2021-03-08', '2021-03-23', 'http://www.07fly.com', '这是一个好的广告效果图', '', '', '', '1', '1', '0', '0', '45.00', '0', '0', '0', '1615193814', '0');
INSERT INTO `#@__member_adv_dis` VALUES ('19', '21', '17', '五一黄金周广告投放', '', '', '2021-03-07', '2021-03-14', 'http://www.07fly.com', '五一黄金周广告投放', '', '', '', '1', '1', '0', '0', '111.00', '0', '0', '0', '1615110365', '0');
INSERT INTO `#@__member_adv_dis` VALUES ('20', '21', '17', '五一黄金周广告投放', '', '', '2021-03-07', '2021-03-14', 'http://www.07fly.com', '五一黄金周广告投放', '', '', '', '1', '1', '0', '0', '210.00', '0', '0', '0', '1615110451', '0');
INSERT INTO `#@__member_adv_dis` VALUES ('21', '21', '18', '中部广告', '20210207/a6b9cd097f511655e0626a1e3e43060e.jpg', '', '2021-03-08', '2021-05-07', 'http://www.lingqifei.com', '图的质量将直接影响：信息审核 和 查询排名，建议宽度：750，高度：90', '', '', '', '1', '1', '0', '0', '1800.00', '0', '0', '0', '1615192162', '0');
INSERT INTO `#@__member_adv_dis` VALUES ('23', '21', '18', '测试广告来的哟', '20210207/a6b9cd097f511655e0626a1e3e43060e.jpg', '', '2021-03-08', '2021-03-23', 'http://www.07fly.com', '这是一个好的广告效果图', '', '', '', '1', '1', '0', '0', '45.00', '0', '0', '0', '1615193957', '0');
INSERT INTO `#@__member_adv_dis` VALUES ('24', '21', '18', '测试广告来的哟', '20210207/a6b9cd097f511655e0626a1e3e43060e.jpg', '', '2021-03-08', '2021-03-23', 'http://www.07fly.com', '这是一个好的广告效果图', '', '', '', '1', '1', '0', '0', '45.00', '0', '0', '0', '1615193971', '0');
INSERT INTO `#@__member_adv_dis` VALUES ('25', '21', '18', '测试广告来的哟', '20210207/a6b9cd097f511655e0626a1e3e43060e.jpg', '', '2021-03-08', '2021-03-23', 'http://www.07fly.com', '这是一个好的广告效果图', '', '', '', '1', '1', '0', '0', '45.00', '0', '0', '0', '1615194028', '0');
INSERT INTO `#@__member_adv_dis` VALUES ('26', '21', '18', '测试广告来的哟', '20210207/a6b9cd097f511655e0626a1e3e43060e.jpg', '', '2021-03-08', '2021-03-23', 'http://www.07fly.com', '这是一个好的广告效果图', '', '', '', '1', '1', '0', '0', '45.00', '0', '0', '0', '1615194031', '0');
INSERT INTO `#@__member_adv_dis` VALUES ('27', '21', '18', '测试广告来的哟', '20210207/a6b9cd097f511655e0626a1e3e43060e.jpg', '', '2021-03-08', '2021-03-23', 'http://www.07fly.com', '这是一个好的广告效果图', '', '', '', '1', '1', '0', '0', '45.00', '0', '0', '0', '1615194052', '0');
INSERT INTO `#@__member_adv_dis` VALUES ('28', '21', '18', '测试广告来的哟', '20210207/a6b9cd097f511655e0626a1e3e43060e.jpg', '', '2021-03-08', '2021-03-23', 'http://www.07fly.com', '这是一个好的广告效果图', '', '', '', '1', '1', '0', '0', '45.00', '0', '0', '0', '1615194054', '0');
INSERT INTO `#@__member_adv_dis` VALUES ('29', '21', '18', '测试广告来的哟', '20210207/a6b9cd097f511655e0626a1e3e43060e.jpg', '', '2021-03-08', '2021-03-23', 'http://www.07fly.com', '这是一个好的广告效果图', '', '', '', '1', '1', '0', '0', '45.00', '0', '0', '0', '1615194074', '0');
INSERT INTO `#@__member_adv_dis` VALUES ('30', '21', '18', '测试广告来的哟', '20210207/a6b9cd097f511655e0626a1e3e43060e.jpg', '', '2021-03-08', '2021-03-23', 'http://www.07fly.com', '这是一个好的广告效果图', '', '', '', '1', '1', '0', '0', '45.00', '0', '0', '0', '1615194103', '0');
INSERT INTO `#@__member_adv_dis` VALUES ('31', '21', '18', '测试广告来的哟', '20210207/a6b9cd097f511655e0626a1e3e43060e.jpg', '', '2021-03-08', '2021-03-23', 'http://www.07fly.com', '这是一个好的广告效果图', '', '', '', '1', '1', '0', '0', '45.00', '0', '0', '0', '1615194106', '0');
INSERT INTO `#@__member_adv_dis` VALUES ('32', '21', '18', '测试广告来的哟', '20210207/a6b9cd097f511655e0626a1e3e43060e.jpg', '', '2021-03-08', '2021-03-23', 'http://www.07fly.com', '这是一个好的广告效果图', '', '', '', '1', '1', '0', '0', '45.00', '0', '0', '0', '1615194128', '0');
INSERT INTO `#@__member_adv_dis` VALUES ('33', '21', '18', '测试广告来的哟', '20210207/a6b9cd097f511655e0626a1e3e43060e.jpg', '', '2021-03-08', '2021-03-23', 'http://www.07fly.com', '这是一个好的广告效果图', '', '', '', '1', '1', '0', '0', '45.00', '0', '0', '0', '1615194205', '0');
INSERT INTO `#@__member_adv_dis` VALUES ('34', '21', '18', '测试广告来的哟', '20210207/a6b9cd097f511655e0626a1e3e43060e.jpg', '', '2021-03-08', '2021-03-07', 'http://www.07fly.com', '这是一个好的广告效果图', '', '', '', '1', '1', '0', '0', '45.00', '4', '0', '0', '1615194267', '1615205824');
INSERT INTO `#@__member_adv_dis` VALUES ('35', '21', '18', '测试广告来的哟', '20210207/a6b9cd097f511655e0626a1e3e43060e.jpg', '', '2021-03-07', '2021-03-07', 'http://www.07fly.com', '这是一个好的广告效果图', '', '', '', '1', '1', '7', '0', '45.00', '4', '0', '0', '1615194290', '1615205399');
INSERT INTO `#@__member_adv_dis` VALUES ('39', '47', '17', '1111', '', '', '2022-01-25', '2022-02-01', '111', '11', '', '', '', '1', '1', '7', '3', '35.00', '0', '0', '0', '1643095055', '1643095055');

-- -----------------------------
-- Table structure for `#@__member_company`
-- -----------------------------
DROP TABLE IF EXISTS `#@__member_company`;
CREATE TABLE `#@__member_company` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '会员ID',
  `member_id` int(10) DEFAULT '0' COMMENT '会员表ID',
  `category_id` int(10) DEFAULT '0' COMMENT '公司分类',
  `province_id` int(10) DEFAULT '0' COMMENT '省id',
  `city_id` int(10) DEFAULT '0' COMMENT '市',
  `county_id` int(10) DEFAULT '0' COMMENT '区',
  `click` int(10) DEFAULT '1' COMMENT '点击数',
  `name` varchar(50) DEFAULT '' COMMENT '公司名称',
  `linkman` varchar(50) DEFAULT '' COMMENT '联系人',
  `tel` varchar(50) DEFAULT '' COMMENT '电话',
  `weixin` varchar(50) DEFAULT '',
  `qicq` varchar(50) DEFAULT '',
  `address` varchar(128) DEFAULT '' COMMENT '联系地址',
  `litpic` varchar(128) DEFAULT '' COMMENT '公司logo',
  `intro` text COMMENT '公司介绍',
  `status` tinyint(1) DEFAULT '0' COMMENT '状态，0=未审核，1=审核',
  `create_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='[会员]会员公司列表';

-- -----------------------------
-- Records of `lqf_member_company`
-- -----------------------------
INSERT INTO `#@__member_company` VALUES ('1', '21', '1', '510000', '510100', '510105', '69', '成都零起飞网络科技有限公司2', '李大哥', '18717123213', '12324134124', '1971942134', '成都市河路100号', '20210110/563bd9bfa9487cb16c2a99f56c9ec88d.jpg', '这是一个很好的学校的哟，这个学校还是很好的呢<br />', '0', '1610252507', '1615091636');
INSERT INTO `#@__member_company` VALUES ('12', '46', '1', '510000', '510100', '510104', '9', '成都零起飞科技有限公司', '李先生', '18035688585', '18035688585', '1871720801', '成都市金牛区路100号110号', '20210110/563bd9bfa9487cb16c2a99f56c9ec88d.jpg', '<p>\r\n	这个学校很霸气的哟\r\n</p>\r\n<p>\r\n	<img src=\"/upload/picture/20210127/cb0f8ae82cbc50177de0343fdff49092.jpg\" alt=\"\" />\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<img src=\"/upload/picture/20210127/b7fb74346cb41b4a4591c8842ee3a11a.jpg\" alt=\"\" />\r\n</p>', '0', '1611652449', '1615033512');
INSERT INTO `#@__member_company` VALUES ('4', '21', '1', '130000', '130300', '130303', '1', '成都零起飞网络3', '李大哥', '18717123213', '12324134124', '1971942134', '成都市河路100号', '20210110/563bd9bfa9487cb16c2a99f56c9ec88d.jpg', '这是一个很好的学校的哟', '0', '1610252507', '1610443349');
INSERT INTO `#@__member_company` VALUES ('5', '21', '1', '130000', '130300', '130303', '3', '成都零起飞网络4', '李大哥', '18717123213', '12324134124', '1971942134', '成都市河路100号', '20210110/563bd9bfa9487cb16c2a99f56c9ec88d.jpg', '这是一个很好的学校的哟', '0', '1610252507', '1611283173');
INSERT INTO `#@__member_company` VALUES ('6', '21', '1', '130000', '130300', '130303', '1', '成都零起飞网络5', '李大哥', '18717123213', '12324134124', '1971942134', '成都市河路100号', '20210110/563bd9bfa9487cb16c2a99f56c9ec88d.jpg', '这是一个很好的学校的哟', '0', '1610252507', '1610443349');
INSERT INTO `#@__member_company` VALUES ('7', '21', '1', '130000', '130300', '130303', '1', '成都零起飞网络7', '李大哥', '18717123213', '12324134124', '1971942134', '成都市河路100号', '20210110/563bd9bfa9487cb16c2a99f56c9ec88d.jpg', '这是一个很好的学校的哟', '0', '1610252507', '1610443349');
INSERT INTO `#@__member_company` VALUES ('8', '21', '1', '130000', '130300', '130303', '1', '成都零起飞网络8', '李大哥', '18717123213', '12324134124', '1971942134', '成都市河路100号', '20210110/563bd9bfa9487cb16c2a99f56c9ec88d.jpg', '这是一个很好的学校的哟', '0', '1610252507', '1610443349');
INSERT INTO `#@__member_company` VALUES ('9', '21', '1', '130000', '130300', '130303', '1', '成都零起飞网络9', '李大哥', '18717123213', '12324134124', '1971942134', '成都市河路100号', '20210110/563bd9bfa9487cb16c2a99f56c9ec88d.jpg', '这是一个很好的学校的哟', '0', '1610252507', '1610443349');
INSERT INTO `#@__member_company` VALUES ('10', '21', '1', '130000', '130300', '130303', '2', '成都零起飞网络10', '李大哥', '18717123213', '12324134124', '1971942134', '成都市河路100号', '20210110/563bd9bfa9487cb16c2a99f56c9ec88d.jpg', '这是一个很好的学校的哟', '0', '1610252507', '1614240646');
INSERT INTO `#@__member_company` VALUES ('11', '21', '1', '130000', '130300', '130303', '1', '成都零起飞网络11', '李大哥', '18717123213', '12324134124', '1971942134', '成都市河路100号', '20210110/563bd9bfa9487cb16c2a99f56c9ec88d.jpg', '这是一个很好的学校的哟', '0', '1610252507', '1610443349');
INSERT INTO `#@__member_company` VALUES ('13', '21', '1', '510000', '510100', '510105', '51', '成都零起飞网络科技有限公司2', '李大哥', '18717123213', '12324134124', '1971942134', '成都市河路100号', '20210110/563bd9bfa9487cb16c2a99f56c9ec88d.jpg', '这是一个很好的学校的哟', '0', '1610252507', '1612694899');
INSERT INTO `#@__member_company` VALUES ('14', '21', '1', '510000', '510100', '510105', '51', '成都零起飞网络科技有限公司2', '李大哥', '18717123213', '12324134124', '1971942134', '成都市河路100号', '20210110/563bd9bfa9487cb16c2a99f56c9ec88d.jpg', '这是一个很好的学校的哟', '0', '1610252507', '1612694899');
INSERT INTO `#@__member_company` VALUES ('15', '21', '1', '510000', '510100', '510105', '51', '成都零起飞网络科技有限公司2', '李大哥', '18717123213', '12324134124', '1971942134', '成都市河路100号', '20210110/563bd9bfa9487cb16c2a99f56c9ec88d.jpg', '这是一个很好的学校的哟', '0', '1610252507', '1612694899');
INSERT INTO `#@__member_company` VALUES ('16', '21', '1', '510000', '510100', '510105', '51', '成都零起飞网络科技有限公司2', '李大哥', '18717123213', '12324134124', '1971942134', '成都市河路100号', '20210110/563bd9bfa9487cb16c2a99f56c9ec88d.jpg', '这是一个很好的学校的哟', '0', '1610252507', '1612694899');
INSERT INTO `#@__member_company` VALUES ('18', '47', '0', '0', '0', '0', '1', '', '', '', '', '', '', '', '', '0', '1618541033', '0');

-- -----------------------------
-- Table structure for `#@__member_config`
-- -----------------------------
DROP TABLE IF EXISTS `#@__member_config`;
CREATE TABLE `#@__member_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '会员功能配置表ID',
  `name` varchar(50) DEFAULT '' COMMENT '配置的key键名',
  `value` text COMMENT '配置的value值',
  `desc` varchar(100) DEFAULT '' COMMENT '键名说明',
  `inc_type` varchar(64) DEFAULT '' COMMENT '配置分组',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='[会员]会员功能配置表';

-- -----------------------------
-- Records of `lqf_member_config`
-- -----------------------------
INSERT INTO `#@__member_config` VALUES ('1', 'member_reg', '30', '初始注册激活', 'member', '1563498415', '0');
INSERT INTO `#@__member_config` VALUES ('2', 'member_login', '1', '24小时登录一次', 'member', '1563498414', '0');
INSERT INTO `#@__member_config` VALUES ('3', 'info_pass', '2', '信息发布审核通过', 'info', '1547890773', '0');
INSERT INTO `#@__member_config` VALUES ('4', 'info_reject', '-2', '信息发布审核拒绝后', 'info', '1564555772', '0');
INSERT INTO `#@__member_config` VALUES ('5', 'member_realname', '20', '实名认证通过后', 'member', '1564555773', '0');
INSERT INTO `#@__member_config` VALUES ('6', 'info_refresh', '-1', '刷新信息扣出积分', 'info', '1588948593', '0');
INSERT INTO `#@__member_config` VALUES ('7', 'info_askfor_view', '-2', '查看报名信息', 'infoaskfor', '1588948593', '0');
INSERT INTO `#@__member_config` VALUES ('8', 'info_askfor_find', '-5', '找学员', 'infoaskfor', '1588948593', '0');

-- -----------------------------
-- Table structure for `#@__member_integral`
-- -----------------------------
DROP TABLE IF EXISTS `#@__member_integral`;
CREATE TABLE `#@__member_integral` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '明细表ID',
  `member_id` int(10) DEFAULT '0' COMMENT '会员表ID',
  `integral` decimal(10,0) DEFAULT '0' COMMENT '积分',
  `member_integral` decimal(10,0) DEFAULT '0' COMMENT '此条记录的账户积分',
  `cause` text COMMENT '事由，暂时在升级消费中使用到，以serialize序列化后存入，用于后续查询。',
  `cause_type` varchar(50) DEFAULT '' COMMENT '数据类型',
  `create_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=68 DEFAULT CHARSET=utf8 COMMENT='[会员]会员积分明细表';

-- -----------------------------
-- Records of `lqf_member_integral`
-- -----------------------------
INSERT INTO `#@__member_integral` VALUES ('1', '46', '30', '30', '初始注册激活', 'member_reg', '1611647991', '0');
INSERT INTO `#@__member_integral` VALUES ('2', '46', '1', '31', '24小时登录一次', 'member_login', '1611647993', '0');
INSERT INTO `#@__member_integral` VALUES ('3', '46', '1', '32', '24小时登录一次', 'member_login', '1611648020', '0');
INSERT INTO `#@__member_integral` VALUES ('4', '46', '1', '33', '24小时登录一次', 'member_login', '1611648034', '0');
INSERT INTO `#@__member_integral` VALUES ('5', '46', '1', '34', '24小时登录一次', 'member_login', '1611648034', '0');
INSERT INTO `#@__member_integral` VALUES ('6', '46', '1', '35', '24小时登录一次', 'member_login', '1611648037', '0');
INSERT INTO `#@__member_integral` VALUES ('7', '46', '1', '36', '24小时登录一次', 'member_login', '1611648040', '0');
INSERT INTO `#@__member_integral` VALUES ('8', '46', '1', '37', '24小时登录一次', 'member_login', '1611648041', '0');
INSERT INTO `#@__member_integral` VALUES ('9', '46', '1', '38', '24小时登录一次', 'member_login', '1611648043', '0');
INSERT INTO `#@__member_integral` VALUES ('10', '46', '1', '39', '24小时登录一次', 'member_login', '1611648076', '0');
INSERT INTO `#@__member_integral` VALUES ('11', '46', '1', '40', '24小时登录一次', 'member_login', '1611648122', '0');
INSERT INTO `#@__member_integral` VALUES ('12', '46', '1', '41', '24小时登录一次', 'member_login', '1611651801', '0');
INSERT INTO `#@__member_integral` VALUES ('13', '46', '110', '151', '110积分(赠送10分)实际到帐积分110', 'buy', '1611656263', '0');
INSERT INTO `#@__member_integral` VALUES ('14', '46', '110', '261', '110积分(赠送10分)实际到帐积分110', 'buy', '1611656759', '0');
INSERT INTO `#@__member_integral` VALUES ('15', '46', '110', '371', '110积分(赠送10分)实际到帐积分110', 'buy', '1611656772', '0');
INSERT INTO `#@__member_integral` VALUES ('16', '46', '110', '481', '110积分(赠送10分)实际到帐积分110', 'buy', '1611656828', '0');
INSERT INTO `#@__member_integral` VALUES ('17', '46', '110', '591', '110积分(赠送10分)实际到帐积分110', 'buy', '1611656854', '0');
INSERT INTO `#@__member_integral` VALUES ('18', '46', '110', '701', '110积分(赠送10分)实际到帐积分110', 'buy', '1611656855', '0');
INSERT INTO `#@__member_integral` VALUES ('19', '46', '110', '811', '110积分(赠送10分)实际到帐积分110', 'buy', '1611656856', '0');
INSERT INTO `#@__member_integral` VALUES ('20', '46', '110', '921', '110积分(赠送10分)实际到帐积分110', 'buy', '1611656892', '0');
INSERT INTO `#@__member_integral` VALUES ('21', '46', '240', '1161', '200积分(赠送40分)实际到帐积分240', 'buy', '1611657026', '0');
INSERT INTO `#@__member_integral` VALUES ('22', '46', '10', '1171', '10积分实际到帐积分10', 'buy', '1611657153', '0');
INSERT INTO `#@__member_integral` VALUES ('23', '46', '-1', '1170', '刷新信息扣出积分', 'info_refresh', '1611725511', '0');
INSERT INTO `#@__member_integral` VALUES ('24', '46', '-1', '1169', '刷新信息扣出积分', 'info_refresh', '1611725646', '0');
INSERT INTO `#@__member_integral` VALUES ('25', '46', '10', '10', '购买10积分实际到帐积分10', 'buy', '1611726315', '0');
INSERT INTO `#@__member_integral` VALUES ('26', '46', '-1', '9', '刷新信息扣出积分', 'info_refresh', '1611726323', '0');
INSERT INTO `#@__member_integral` VALUES ('27', '21', '1', '4', '24小时登录一次', 'member_login', '1612677018', '0');
INSERT INTO `#@__member_integral` VALUES ('28', '21', '-1', '3', '刷新信息扣出积分', 'info_refresh', '1612679644', '0');
INSERT INTO `#@__member_integral` VALUES ('29', '21', '-1', '2', '刷新信息扣出积分', 'info_refresh', '1612679645', '0');
INSERT INTO `#@__member_integral` VALUES ('30', '21', '-1', '1', '刷新信息扣出积分', 'info_refresh', '1612679647', '0');
INSERT INTO `#@__member_integral` VALUES ('31', '21', '-1', '0', '刷新信息扣出积分', 'info_refresh', '1612679648', '0');
INSERT INTO `#@__member_integral` VALUES ('32', '21', '1', '1', '24小时登录一次', 'member_login', '1613978527', '0');
INSERT INTO `#@__member_integral` VALUES ('33', '21', '-1', '0', '刷新信息扣出积分', 'info_refresh', '1613990247', '0');
INSERT INTO `#@__member_integral` VALUES ('34', '21', '1', '1', '24小时登录一次', 'member_login', '1614307676', '0');
INSERT INTO `#@__member_integral` VALUES ('35', '21', '1', '2', '24小时登录一次', 'member_login', '1614567682', '0');
INSERT INTO `#@__member_integral` VALUES ('36', '21', '-2', '0', '查看报名信息', 'info_askfor_view', '1614589914', '0');
INSERT INTO `#@__member_integral` VALUES ('37', '21', '1', '1', '24小时登录一次', 'member_login', '1614589943', '0');
INSERT INTO `#@__member_integral` VALUES ('38', '21', '-2', '8', '查看报名信息', 'info_askfor_view', '1614590162', '0');
INSERT INTO `#@__member_integral` VALUES ('39', '21', '-2', '6', '查看报名信息', 'info_askfor_view', '1614590834', '0');
INSERT INTO `#@__member_integral` VALUES ('40', '21', '-5', '1', '找学员', 'info_askfor_find', '1614591643', '0');
INSERT INTO `#@__member_integral` VALUES ('41', '21', '-5', '995', '找学员', 'info_askfor_find', '1614591702', '0');
INSERT INTO `#@__member_integral` VALUES ('42', '21', '-5', '990', '找学员', 'info_askfor_find', '1614591729', '0');
INSERT INTO `#@__member_integral` VALUES ('43', '21', '-5', '985', '找学员', 'info_askfor_find', '1614591760', '0');
INSERT INTO `#@__member_integral` VALUES ('44', '21', '-5', '980', '找学员', 'info_askfor_find', '1614591820', '0');
INSERT INTO `#@__member_integral` VALUES ('45', '21', '-5', '975', '找学员', 'info_askfor_find', '1614592848', '0');
INSERT INTO `#@__member_integral` VALUES ('46', '21', '-5', '970', '找学员', 'info_askfor_find', '1614592866', '0');
INSERT INTO `#@__member_integral` VALUES ('47', '21', '-5', '965', '找学员', 'info_askfor_find', '1614593005', '0');
INSERT INTO `#@__member_integral` VALUES ('48', '21', '-1', '964', '刷新信息扣出积分', 'info_refresh', '1615031987', '0');
INSERT INTO `#@__member_integral` VALUES ('49', '21', '-1', '963', '刷新信息扣出积分', 'info_refresh', '1615031993', '0');
INSERT INTO `#@__member_integral` VALUES ('50', '21', '-5', '958', '找学员', 'info_askfor_find', '1615034019', '0');
INSERT INTO `#@__member_integral` VALUES ('51', '21', '-2', '956', '查看报名信息', 'info_askfor_view', '1615104397', '0');
INSERT INTO `#@__member_integral` VALUES ('52', '21', '10', '966', '购买10积分实际到帐积分10', 'buy', '1615192983', '0');
INSERT INTO `#@__member_integral` VALUES ('53', '21', '10', '976', '购买10积分实际到帐积分10', 'buy', '1615192983', '0');
INSERT INTO `#@__member_integral` VALUES ('54', '21', '10', '986', '购买10积分实际到帐积分10', 'buy', '1615193232', '0');
INSERT INTO `#@__member_integral` VALUES ('55', '21', '10', '996', '购买10积分实际到帐积分10', 'buy', '1615193232', '0');
INSERT INTO `#@__member_integral` VALUES ('56', '21', '10', '1006', '购买10积分实际到帐积分10', 'buy', '1615193310', '0');
INSERT INTO `#@__member_integral` VALUES ('57', '21', '10', '1016', '购买10积分实际到帐积分10', 'buy', '1615193310', '0');
INSERT INTO `#@__member_integral` VALUES ('58', '21', '10', '1026', '购买10积分实际到帐积分10', 'buy', '1615193312', '0');
INSERT INTO `#@__member_integral` VALUES ('59', '21', '10', '1036', '购买10积分实际到帐积分10', 'buy', '1615193326', '0');
INSERT INTO `#@__member_integral` VALUES ('60', '47', '1', '1', '24小时登录一次', 'member_login', '1618534390', '0');
INSERT INTO `#@__member_integral` VALUES ('61', '47', '1', '2', '24小时登录一次', 'member_login', '1618537846', '0');
INSERT INTO `#@__member_integral` VALUES ('62', '47', '1', '3', '24小时登录一次', 'member_login', '1618729879', '0');
INSERT INTO `#@__member_integral` VALUES ('63', '47', '1', '4', '24小时登录一次', 'member_login', '1627114982', '0');
INSERT INTO `#@__member_integral` VALUES ('64', '47', '1', '5', '24小时登录一次', 'member_login', '1627441763', '0');
INSERT INTO `#@__member_integral` VALUES ('65', '47', '1', '6', '24小时登录一次', 'member_login', '1627442375', '0');
INSERT INTO `#@__member_integral` VALUES ('66', '47', '1', '7', '24小时登录一次', 'member_login', '1643090153', '0');
INSERT INTO `#@__member_integral` VALUES ('67', '47', '1', '8', '24小时登录一次', 'member_login', '1662190651', '0');

-- -----------------------------
-- Table structure for `#@__member_level`
-- -----------------------------
DROP TABLE IF EXISTS `#@__member_level`;
CREATE TABLE `#@__member_level` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `level_name` varchar(30) DEFAULT '' COMMENT '级别名称',
  `level_value` int(10) DEFAULT '0' COMMENT '会员等级值',
  `is_system` tinyint(1) DEFAULT '0' COMMENT '类型，1=系统，0=用户',
  `amount` decimal(10,2) DEFAULT '0.00' COMMENT '消费额度',
  `down_count` int(10) DEFAULT '0' COMMENT '每天下载次数限制',
  `upload_img` int(10) DEFAULT '0' COMMENT '上传图片数量',
  `discount` float(10,2) DEFAULT '100.00' COMMENT '折扣率，初始值为100即100%，无折扣',
  `posts_count` int(10) DEFAULT '5' COMMENT '会员投稿次数限制',
  `ask_is_release` tinyint(1) DEFAULT '1' COMMENT '允许在问答中发布问题，1=是，0=否',
  `ask_is_review` tinyint(1) DEFAULT '0' COMMENT '在问答中发布问题或回答是否需要审核，1=是，0=否',
  `remark` varchar(256) DEFAULT 'cn' COMMENT '备注说明',
  `create_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='[会员]会员级别表';

-- -----------------------------
-- Records of `lqf_member_level`
-- -----------------------------
INSERT INTO `#@__member_level` VALUES ('1', '注册会员', '10', '1', '0.00', '100', '100', '100', '5', '1', '0', 'cn', '0', '1609900542');
INSERT INTO `#@__member_level` VALUES ('2', '白银会员', '51', '0', '0.00', '100', '300', '100', '10', '1', '0', 'cn', '1564532901', '1618536831');
INSERT INTO `#@__member_level` VALUES ('3', '黄金会员', '100', '0', '0.00', '100', '500', '100', '20', '1', '0', 'cn', '1564532901', '1611725089');
INSERT INTO `#@__member_level` VALUES ('4', '钻石会员', '500', '0', '0.00', '0', '1000', '60', '5', '1', '0', '比较好的', '1609853985', '0');

-- -----------------------------
-- Table structure for `#@__member_list`
-- -----------------------------
DROP TABLE IF EXISTS `#@__member_list`;
CREATE TABLE `#@__member_list` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `member_id` int(10) NOT NULL DEFAULT '0' COMMENT '会员ID',
  `para_id` int(10) NOT NULL DEFAULT '0' COMMENT '属性ID',
  `info` text COMMENT '属性值',
  `lang` varchar(50) NOT NULL DEFAULT 'cn' COMMENT '语言标识',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='[会员]会员属性表(信息）';

-- -----------------------------
-- Records of `lqf_member_list`
-- -----------------------------
INSERT INTO `#@__member_list` VALUES ('1', '1', '1', '13644444444', 'cn', '1564475243', '0');
INSERT INTO `#@__member_list` VALUES ('2', '1', '2', '123@11.com', 'cn', '1564475243', '0');

-- -----------------------------
-- Table structure for `#@__member_menu`
-- -----------------------------
DROP TABLE IF EXISTS `#@__member_menu`;
CREATE TABLE `#@__member_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `title` varchar(30) DEFAULT '' COMMENT '导航名称',
  `mca` varchar(50) DEFAULT '' COMMENT '分组/控制器/操作名',
  `is_userpage` tinyint(1) DEFAULT '0' COMMENT '默认会员首页',
  `sort_order` int(10) DEFAULT '0' COMMENT '排序号',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态，1=显示，0=隐藏',
  `create_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='[会员]会员菜单表';

-- -----------------------------
-- Records of `lqf_member_menu`
-- -----------------------------
INSERT INTO `#@__member_menu` VALUES ('1', '个人信息', 'user/Users/index', '1', '100', '1', '1555904190', '1555917737');
INSERT INTO `#@__member_menu` VALUES ('2', '账户充值', 'user/Pay/pay_consumer_details', '0', '100', '1', '1555904190', '1563498414');
INSERT INTO `#@__member_menu` VALUES ('3', '商城中心', 'user/Shop/shop_centre', '0', '100', '1', '1555904190', '1563498415');
INSERT INTO `#@__member_menu` VALUES ('4', '会员升级', 'user/Level/level_centre', '0', '100', '1', '1555904190', '1564555772');
INSERT INTO `#@__member_menu` VALUES ('5', '会员投稿', 'user/UsersRelease/release_centre', '0', '100', '1', '1555904190', '1564555773');
INSERT INTO `#@__member_menu` VALUES ('6', '我的下载', 'user/Download/index', '0', '100', '1', '1590484667', '1609817872');

-- -----------------------------
-- Table structure for `#@__member_money`
-- -----------------------------
DROP TABLE IF EXISTS `#@__member_money`;
CREATE TABLE `#@__member_money` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '金额明细表ID',
  `member_id` int(10) DEFAULT '0' COMMENT '会员表ID',
  `money` decimal(10,2) DEFAULT '0.00' COMMENT '金额',
  `member_money` decimal(10,2) DEFAULT '0.00' COMMENT '此条记录的账户金额',
  `cause` text COMMENT '事由，暂时在升级消费中使用到，以serialize序列化后存入，用于后续查询。',
  `cause_type` tinyint(1) DEFAULT '0' COMMENT '数据类型，0为消费，1为充值。其余后续添加。',
  `status` tinyint(1) DEFAULT '1' COMMENT '是否成功，默认1，0失败，1未付款，2已付款，3已完成，4订单取消。',
  `pay_method` varchar(10) DEFAULT '' COMMENT '支付方式，wechat为微信支付，alipay为支付宝支付',
  `wechat_pay_type` varchar(20) NOT NULL DEFAULT '' COMMENT '微信支付时，标记使用的支付类型（扫码支付，微信内部，微信H5页面）',
  `pay_details` text COMMENT '支付时返回的数据，以serialize序列化后存入，用于后续查询。',
  `order_number` varchar(30) DEFAULT '' COMMENT '订单号',
  `lang` varchar(50) DEFAULT 'cn' COMMENT '语言标识',
  `create_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='[会员]会员金额明细表';


-- -----------------------------
-- Table structure for `#@__member_order`
-- -----------------------------
DROP TABLE IF EXISTS `#@__member_order`;
CREATE TABLE `#@__member_order` (
  `id` int(16) NOT NULL AUTO_INCREMENT COMMENT '关键id',
  `name` varchar(256) NOT NULL DEFAULT '' COMMENT '订单名称',
  `order_code` varchar(20) NOT NULL DEFAULT '' COMMENT '订单编号',
  `member_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '会员id',
  `payment_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '订单状态：0未付款(已下单)，1已付款(待发货)',
  `payment_method` tinyint(1) DEFAULT '0' COMMENT '订单支付方式，0为在线支付，1为线下付款，默认0',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `pay_name` varchar(20) NOT NULL DEFAULT '' COMMENT '支付方式名称',
  `pay_details` mediumtext COMMENT '支付时返回的数据，以serialize序列化后存入，用于后续查询。',
  `wechat_pay_type` varchar(20) NOT NULL DEFAULT '' COMMENT '微信支付时，标记使用的支付类型（扫码支付，微信内部，微信H5页面）',
  `order_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '应付款金额',
  `bus_type` varchar(50) DEFAULT NULL COMMENT '订单类型：level升级订单、integral、info',
  `bus_id` tinyint(1) unsigned DEFAULT '0' COMMENT '订单关联产品编号',
  `admin_remark` mediumtext COMMENT '管理员操作备注',
  `remark` mediumtext COMMENT '订单备注',
  `member_remark` mediumtext COMMENT '会员备注',
  `update_time` int(11) unsigned DEFAULT '0' COMMENT '更新时间',
  `create_time` int(11) unsigned DEFAULT '0' COMMENT '创建时间',
  `pay_transaction_no` varchar(256) NOT NULL DEFAULT '0' COMMENT '支付渠道单号',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='[会员]订单主表';

-- -----------------------------
-- Records of `lqf_member_order`
-- -----------------------------
INSERT INTO `#@__member_order` VALUES ('1', '升级为本站白银会员', 'SJ-1-220125140102', '47', '0', '0', '', '', '', '', '150.00', 'level', '1', '', '', '', '0', '1643090462', '0');
INSERT INTO `#@__member_order` VALUES ('2', '10积分实际到帐积分10', 'JF-3-220125140119', '47', '0', '0', '', '', '', '', '10.00', 'integral', '3', '', '', '', '0', '1643090479', '0');
INSERT INTO `#@__member_order` VALUES ('3', '购买广告：幻灯片广告，周期：7天', 'GG-17-220125151735', '47', '0', '0', '', '', '', '', '35.00', 'member_ad', '39', '', '', '', '0', '1643095055', '0');
INSERT INTO `#@__member_order` VALUES ('4', '升级为本站白银会员', 'SJ-1-220903154011', '47', '0', '0', '', '', '', '', '150.00', 'level', '1', '', '', '', '0', '1662190811', '0');

-- -----------------------------
-- Table structure for `#@__member_parameter`
-- -----------------------------
DROP TABLE IF EXISTS `#@__member_parameter`;
CREATE TABLE `#@__member_parameter` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '标题',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '名称',
  `dtype` varchar(32) NOT NULL DEFAULT '' COMMENT '字段类型',
  `dfvalue` varchar(1000) NOT NULL DEFAULT '' COMMENT '默认值',
  `is_system` tinyint(1) DEFAULT '0' COMMENT '是否为系统属性，系统属性不可删除，1为是，0为否，默认0。',
  `is_hidden` tinyint(1) DEFAULT '0' COMMENT '是否禁用属性，1为是，0为否',
  `is_required` tinyint(1) DEFAULT '0' COMMENT '是否为必填属性，1为是，0为否，默认0。',
  `is_reg` tinyint(1) DEFAULT '1' COMMENT '是否为注册表单，1为是，0为否',
  `sort_order` smallint(5) NOT NULL DEFAULT '0' COMMENT '排序',
  `lang` varchar(50) NOT NULL DEFAULT 'cn' COMMENT '语言标识',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='[会员]会员属性表(字段)';

-- -----------------------------
-- Records of `lqf_member_parameter`
-- -----------------------------
INSERT INTO `#@__member_parameter` VALUES ('1', '手机号码', 'mobile_1', 'mobile', '', '1', '0', '0', '1', '1', 'cn', '0', '1591947010');
INSERT INTO `#@__member_parameter` VALUES ('2', '邮箱地址', 'email_2', 'email', '', '1', '0', '1', '1', '1', 'cn', '0', '1591947010');

-- -----------------------------
-- Table structure for `#@__member_picture`
-- -----------------------------
DROP TABLE IF EXISTS `#@__member_picture`;
CREATE TABLE `#@__member_picture` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
  `member_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '会员id',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '图片名称',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '路径',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '图片链接',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `reply_remark` varchar(255) NOT NULL DEFAULT '' COMMENT '回复备注',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态0待审，1=审核，2=拒绝',
  `issave` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否保存',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='[会员]会员图片管理表';

-- -----------------------------
-- Records of `lqf_member_picture`
-- -----------------------------
INSERT INTO `#@__member_picture` VALUES ('1', '47', 'c1eb0186baf7d3c4bc0753cb3a30a410.jpg', '20220125/c1eb0186baf7d3c4bc0753cb3a30a410.jpg', '', 'a877a9a2cf0f2790380a6ae49e9d90339c3b91c4', '', '0', '0', '1643094118', '0');

-- -----------------------------
-- Table structure for `#@__member_product_integral`
-- -----------------------------
DROP TABLE IF EXISTS `#@__member_product_integral`;
CREATE TABLE `#@__member_product_integral` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `name` varchar(30) DEFAULT '' COMMENT '类型名称',
  `integral` int(10) DEFAULT '0' COMMENT '积分值',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '价格',
  `sort` smallint(5) NOT NULL DEFAULT '0' COMMENT '排序',
  `remark` varchar(30) DEFAULT '',
  `create_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='[会员]会员产品积表';

-- -----------------------------
-- Records of `lqf_member_product_integral`
-- -----------------------------
INSERT INTO `#@__member_product_integral` VALUES ('3', '10积分', '10', '10.00', '100', '', '1609902409', '1610367870');
INSERT INTO `#@__member_product_integral` VALUES ('4', '110积分(赠送10分)', '110', '100.00', '110', '', '1609903516', '0');
INSERT INTO `#@__member_product_integral` VALUES ('5', '200积分(赠送40分)', '240', '200.00', '240', '', '1609903516', '0');

-- -----------------------------
-- Table structure for `#@__member_product_level`
-- -----------------------------
DROP TABLE IF EXISTS `#@__member_product_level`;
CREATE TABLE `#@__member_product_level` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `name` varchar(30) DEFAULT '' COMMENT '类型名称',
  `level_id` int(10) DEFAULT '0' COMMENT '会员等级ID',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '价格',
  `period` int(10) DEFAULT '0' COMMENT '会员周期值，默认单位为月',
  `sort` smallint(5) NOT NULL DEFAULT '0' COMMENT '排序',
  `remark` varchar(30) DEFAULT '',
  `create_time` int(11) DEFAULT '0' COMMENT '新增时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='[会员]会员产品升级';

-- -----------------------------
-- Records of `lqf_member_product_level`
-- -----------------------------
INSERT INTO `#@__member_product_level` VALUES ('1', '升级为本站白银会员', '2', '150.00', '12', '88', '', '1564532901', '1611725131');
INSERT INTO `#@__member_product_level` VALUES ('2', '升级为本站黄金会员', '3', '200.00', '12', '100', '', '1564532901', '1611725148');
INSERT INTO `#@__member_product_level` VALUES ('3', '升级为本站钻石会员', '4', '100.00', '12', '100', '', '1609897320', '1611725292');

-- -----------------------------
-- Table structure for `#@__member_realname`
-- -----------------------------
DROP TABLE IF EXISTS `#@__member_realname`;
CREATE TABLE `#@__member_realname` (
  `id` int(16) unsigned NOT NULL AUTO_INCREMENT,
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '0=未审核，1=审核,2=拒绝',
  `name` varchar(256) NOT NULL DEFAULT '' COMMENT '真实名称',
  `real_type` varchar(256) NOT NULL DEFAULT '1' COMMENT '实名类型、1=个人，2=公司',
  `cert_type` varchar(256) NOT NULL DEFAULT '' COMMENT '证件类型、1=身份证、2=营业执照',
  `cert_code` varchar(256) NOT NULL DEFAULT '' COMMENT '证件号',
  `cert_pic` varchar(256) NOT NULL DEFAULT '' COMMENT '证件图片列',
  `cert_pic1` varchar(256) NOT NULL DEFAULT '' COMMENT '证件图片',
  `cert_pic2` varchar(256) NOT NULL DEFAULT '' COMMENT '证件图片2',
  `member_id` varchar(256) NOT NULL DEFAULT '' COMMENT '会员编号',
  `reply_remark` varchar(256) NOT NULL DEFAULT '' COMMENT '回复备注',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `org_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='[会员]会员实名认证';

-- -----------------------------
-- Records of `lqf_member_realname`
-- -----------------------------
INSERT INTO `#@__member_realname` VALUES ('1', '1', '李林', '1', '身份证', '11111', '64,60', '', '', '21', '', '1610345137', '1643094133', '0');
INSERT INTO `#@__member_realname` VALUES ('2', '2', '培训达人', '1', '营业执照', '49653416165153135023', '60', '', '', '46', 'v b', '1611652530', '1612669718', '0');
