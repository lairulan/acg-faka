SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `__PREFIX__bill`;
CREATE TABLE `__PREFIX__bill`  (
                                   `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
                                   `owner` int UNSIGNED NOT NULL COMMENT '用户id',
                                   `amount` decimal(10, 2) UNSIGNED NOT NULL COMMENT '金额',
                                   `balance` decimal(14, 2) UNSIGNED NOT NULL COMMENT '余额',
                                   `type` tinyint NOT NULL COMMENT '类型：0=支出，1=收入',
                                   `currency` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '货币：0=余额，1=硬币',
                                   `log` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '日志',
                                   `create_time` datetime NOT NULL COMMENT '创建时间',
                                   PRIMARY KEY (`id`) USING BTREE,
                                   INDEX `owner`(`owner` ASC) USING BTREE,
                                   INDEX `type`(`type` ASC) USING BTREE,
                                   CONSTRAINT `__PREFIX__bill_ibfk_1` FOREIGN KEY (`owner`) REFERENCES `__PREFIX__user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

DROP TABLE IF EXISTS `__PREFIX__business`;
CREATE TABLE `__PREFIX__business`  (
                                       `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
                                       `user_id` int UNSIGNED NOT NULL COMMENT '用户id',
                                       `shop_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '店铺名称',
                                       `title` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '浏览器标题',
                                       `notice` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '店铺公告',
                                       `service_qq` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客服QQ',
                                       `service_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '网页客服链接',
                                       `subdomain` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子域名',
                                       `topdomain` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '顶级域名',
                                       `master_display` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '主站显示：0=否，1=是',
                                       `create_time` datetime NOT NULL COMMENT '创建时间',
                                       PRIMARY KEY (`id`) USING BTREE,
                                       UNIQUE INDEX `user_id`(`user_id` ASC) USING BTREE,
                                       UNIQUE INDEX `subdomain`(`subdomain` ASC) USING BTREE,
                                       UNIQUE INDEX `topdomain`(`topdomain` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;


DROP TABLE IF EXISTS `__PREFIX__business_level`;
CREATE TABLE `__PREFIX__business_level`  (
                                             `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
                                             `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '等级名称',
                                             `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图标',
                                             `cost` decimal(4, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '商家自己的商品，抽成百分比',
                                             `accrual` decimal(4, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '主站商品，分给商家的收益百分比',
                                             `substation` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '分站：0=关闭，1=启用',
                                             `top_domain` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '顶级域名：0=关闭，1=启用',
                                             `price` decimal(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '购买价格',
                                             `supplier` tinyint UNSIGNED NOT NULL DEFAULT 1 COMMENT '供货商权限：0=关闭，1=启用',
                                             PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;


INSERT INTO `__PREFIX__business_level` VALUES (1, '体验版', '/assets/static/images/business/v1.png', 0.30, 0.10, 1, 0, 188.00, 1);
INSERT INTO `__PREFIX__business_level` VALUES (3, '普通版', '/assets/static/images/business/v2.png', 0.25, 0.15, 1, 0, 288.00, 1);
INSERT INTO `__PREFIX__business_level` VALUES (4, '专业版', '/assets/static/images/business/v3.png', 0.20, 0.20, 1, 1, 388.00, 1);

DROP TABLE IF EXISTS `__PREFIX__card`;
CREATE TABLE `__PREFIX__card`  (
                                   `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
                                   `owner` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '所属会员：0=系统，其他等于会员UID',
                                   `commodity_id` int UNSIGNED NOT NULL COMMENT '商品id',
                                   `draft` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '预选信息',
                                   `secret` varchar(760) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '卡密信息',
                                   `create_time` datetime NOT NULL COMMENT '添加时间',
                                   `purchase_time` datetime NULL DEFAULT NULL COMMENT '购买时间',
                                   `order_id` int UNSIGNED NULL DEFAULT NULL COMMENT '订单id',
                                   `status` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态：0=未出售，1=已出售，2=已锁定',
                                   `note` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注信息',
                                   `race` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品种类',
                                   `sku` json DEFAULT NULL COMMENT 'SKU',
                                   `draft_premium` decimal(10,2) unsigned DEFAULT NULL COMMENT '预选加价',
                                   `cost` decimal(10,2) unsigned DEFAULT 0 COMMENT '预选成本',
                                   PRIMARY KEY (`id`) USING BTREE,
                                   INDEX `owner`(`owner` ASC) USING BTREE,
                                   INDEX `commodity_id`(`commodity_id` ASC) USING BTREE,
                                   INDEX `order_id`(`order_id` ASC) USING BTREE,
                                   INDEX `secret`(`secret` ASC) USING BTREE,
                                   INDEX `status`(`status` ASC) USING BTREE,
                                   INDEX `note`(`note` ASC) USING BTREE,
                                   INDEX `race`(`race` ASC) USING BTREE,
                                   CONSTRAINT `__PREFIX__card_ibfk_1` FOREIGN KEY (`commodity_id`) REFERENCES `__PREFIX__commodity` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;


DROP TABLE IF EXISTS `__PREFIX__cash`;
CREATE TABLE `__PREFIX__cash`  (
                                   `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
                                   `user_id` int UNSIGNED NOT NULL COMMENT '用户id',
                                   `amount` decimal(14, 2) UNSIGNED NOT NULL COMMENT '提现金额',
                                   `type` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '类型：0=自动提现，1=手动提现',
                                   `card` tinyint UNSIGNED NOT NULL COMMENT '收款：0=支付宝，1=微信',
                                   `create_time` datetime NOT NULL COMMENT '提现时间',
                                   `arrive_time` datetime NULL DEFAULT NULL COMMENT '到账时间',
                                   `cost` decimal(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '手续费',
                                   `status` tinyint UNSIGNED NOT NULL COMMENT '状态：0=处理中，1=成功，2=失败，3=冻结期',
                                   `message` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '消息',
                                   PRIMARY KEY (`id`) USING BTREE,
                                   INDEX `user_id`(`user_id` ASC) USING BTREE,
                                   INDEX `type`(`type` ASC) USING BTREE,
                                   INDEX `message`(`message` ASC) USING BTREE,
                                   CONSTRAINT `__PREFIX__cash_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `__PREFIX__user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;


DROP TABLE IF EXISTS `__PREFIX__category`;
CREATE TABLE `__PREFIX__category`  (
                                       `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
                                       `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商品分类名称',
                                       `sort` smallint UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序',
                                       `create_time` datetime NOT NULL COMMENT '创建时间',
                                       `owner` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '所属会员：0=系统，其他等于会员UID',
                                       `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类图标',
                                       `status` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态：0=停用，1=启用',
                                       `hide` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '隐藏：1=隐藏，0=不隐藏',
                                       `user_level_config` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '会员配置',
                                       `pid` int UNSIGNED DEFAULT NULL COMMENT '上级ID',
                                       PRIMARY KEY (`id`) USING BTREE,
                                       INDEX `owner`(`owner` ASC) USING BTREE,
                                       INDEX `idx_category_pid`(`pid`) USING BTREE,
                                       INDEX `sort`(`sort` ASC) USING BTREE,
                                       CONSTRAINT `ibfk_category_pid_in_id` FOREIGN KEY (`pid`) REFERENCES `__PREFIX__category`(`id`) ON DELETE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;


INSERT INTO `__PREFIX__category` VALUES (1, 'ChatGPT业务', 1, '2026-05-14 00:00:00', 0, '/assets/brand/xitan-logo.svg', 1, 0, NULL , NULL);
INSERT INTO `__PREFIX__category` VALUES (2, 'Claude业务', 2, '2026-05-14 00:00:00', 0, '/assets/brand/xitan-logo.svg', 1, 0, NULL , NULL);
INSERT INTO `__PREFIX__category` VALUES (3, 'Cursor业务', 3, '2026-05-14 00:00:00', 0, '/assets/brand/xitan-logo.svg', 1, 0, NULL , NULL);
INSERT INTO `__PREFIX__category` VALUES (4, 'Google业务', 4, '2026-05-14 00:00:00', 0, '/assets/brand/xitan-logo.svg', 1, 0, NULL , NULL);
INSERT INTO `__PREFIX__category` VALUES (5, 'AI工具服务', 5, '2026-05-14 00:00:00', 0, '/assets/brand/xitan-logo.svg', 1, 0, NULL , NULL);


DROP TABLE IF EXISTS `__PREFIX__commodity`;
CREATE TABLE `__PREFIX__commodity`  (
                                        `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
                                        `category_id` int UNSIGNED NOT NULL COMMENT '商品分类ID',
                                        `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商品名称',
                                        `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '商品说明',
                                        `cover` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品封面图片',
                                        `factory_price` decimal(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '成本单价',
                                        `price` decimal(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '商品单价(未登录)',
                                        `user_price` decimal(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '商品单价(会员价)',
                                        `status` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态：0=下架，1=上架',
                                        `owner` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '所属会员：0=系统，其他等于会员UID',
                                        `create_time` datetime NOT NULL COMMENT '创建时间',
                                        `api_status` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT 'API对接：0=关闭，1=启用',
                                        `code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品代码(API对接)',
                                        `delivery_way` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '发货方式：0=自动发货，1=手动发货/插件发货',
                                        `delivery_auto_mode` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '自动发卡模式：0=旧卡先发，1=随机发卡，2=新卡先发',
                                        `delivery_message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手动发货显示信息',
                                        `contact_type` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '联系方式：0=任意，1=手机，2=邮箱，3=QQ',
                                        `password_status` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '订单密码：0=关闭，1=启用',
                                        `sort` smallint UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序',
                                        `coupon` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '优惠卷：0=关闭，1=启用',
                                        `shared_id` int UNSIGNED NULL DEFAULT NULL COMMENT '共享平台ID',
                                        `shared_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '共享平台-商品代码',
                                        `shared_premium` float(10, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '商品加价',
                                        `shared_stock` json DEFAULT NULL COMMENT '库存信息',
                                        `stock` int(11) DEFAULT NULL COMMENT '库存',
                                        `shared_premium_type` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '加价模式',
                                        `seckill_status` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '商品秒杀：0=关闭，1=开启',
                                        `seckill_start_time` datetime NULL DEFAULT NULL COMMENT '秒杀开始时间',
                                        `seckill_end_time` datetime NULL DEFAULT NULL COMMENT '秒杀结束时间',
                                        `draft_status` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '指定卡密购买：0=关闭，1=启用',
                                        `draft_premium` decimal(10, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '指定卡密购买时溢价',
                                        `inventory_hidden` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '隐藏库存：0=否，1=是',
                                        `leave_message` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发货留言',
                                        `recommend` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '推荐商品：0=否，1=是',
                                        `send_email` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '发送邮件：0=否，1=是',
                                        `only_user` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '限制登录购买：0=否，1=是',
                                        `purchase_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '限制购买数量：0=无限制',
                                        `widget` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '控件',
                                        `level_price` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '会员等级-定制价格',
                                        `level_disable` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '禁用会员等级折扣，0=关闭，1=启用',
                                        `minimum` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '最低购买数量，0=无限制',
                                        `maximum` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大购买数量，0=无限制',
                                        `shared_sync` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '同步平台价格：0=关，1=开',
                                        `config` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '配置文件',
                                        `hide` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '隐藏：1=隐藏，0=不隐藏',
                                        `inventory_sync` tinyint NOT NULL DEFAULT 0 COMMENT '同步库存数量: 0=关，1=开',
                                        `shared_amount_sync` tinyint UNSIGNED DEFAULT 0 COMMENT '同步金额',
                                        `shared_config_sync` tinyint UNSIGNED DEFAULT 0 COMMENT '同步配置参数',
                                        PRIMARY KEY (`id`) USING BTREE,
                                        UNIQUE INDEX `code`(`code` ASC) USING BTREE,
                                        INDEX `owner`(`owner` ASC) USING BTREE,
                                        INDEX `status`(`status` ASC) USING BTREE,
                                        INDEX `sort`(`sort` ASC) USING BTREE,
                                        INDEX `category_id`(`category_id` ASC) USING BTREE,
                                        INDEX `shared_id`(`shared_id` ASC) USING BTREE,
                                        INDEX `seckill_status`(`seckill_status` ASC) USING BTREE,
                                        INDEX `api_status`(`api_status` ASC) USING BTREE,
                                        INDEX `recommend`(`recommend` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

INSERT INTO `__PREFIX__commodity`
(`id`, `category_id`, `name`, `description`, `cover`, `factory_price`, `price`, `user_price`, `status`, `owner`, `create_time`, `api_status`, `code`, `delivery_way`, `delivery_auto_mode`, `delivery_message`, `contact_type`, `password_status`, `sort`, `coupon`, `shared_id`, `shared_code`, `shared_premium`, `shared_stock`, `stock`, `shared_premium_type`, `seckill_status`, `seckill_start_time`, `seckill_end_time`, `draft_status`, `draft_premium`, `inventory_hidden`, `leave_message`, `recommend`, `send_email`, `only_user`, `purchase_count`, `widget`, `level_price`, `level_disable`, `minimum`, `maximum`, `shared_sync`, `config`, `hide`, `inventory_sync`, `shared_amount_sync`, `shared_config_sync`)
VALUES
(1, 1, 'ChatGPT Plus 开通/续费服务（人工确认）', '<p><strong>服务说明：</strong>用于 ChatGPT Plus 账号开通、续费或订阅协助。下单前请确认账号邮箱、订阅状态和可登录情况。</p><p><strong>交付方式：</strong>人工确认后处理，具体时效以客服确认为准。</p><p><strong>售后边界：</strong>虚拟服务交付后，不支持因账号自身风控、地区限制、用户操作失误导致的无理由退款。</p>', '/assets/brand/xitan-cover-ai.svg', 0.00, 1.00, 1.00, 1, 0, '2026-05-14 00:00:00', 0, 'XITAN_CHATGPT_SERVICE', 1, 0, '订单已提交，请等待人工确认；如需加急，请联系页面客服。', 2, 1, 1, 0, NULL, '', 0.00, NULL, 999, 0, 0, NULL, NULL, 0, 0.00, 0, NULL, 1, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, NULL, 0, 0, 0, 0),
(2, 2, 'Claude Pro 开通/续费服务（人工确认）', '<p><strong>服务说明：</strong>用于 Claude Pro 账号开通、续费或订阅协助。请先准备可接收消息的邮箱和账号登录信息。</p><p><strong>交付方式：</strong>人工确认后处理，实际可用性以账号状态和平台规则为准。</p><p><strong>售后边界：</strong>平台风控、地区限制、违规使用等非服务交付问题不属于质保范围。</p>', '/assets/brand/xitan-cover-ai.svg', 0.00, 1.00, 1.00, 1, 0, '2026-05-14 00:00:00', 0, 'XITAN_CLAUDE_SERVICE', 1, 0, '订单已提交，请等待人工确认；如需加急，请联系页面客服。', 2, 1, 2, 0, NULL, '', 0.00, NULL, 999, 0, 0, NULL, NULL, 0, 0.00, 0, NULL, 1, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, NULL, 0, 0, 0, 0),
(3, 3, 'Cursor Pro 开通/续费服务（人工确认）', '<p><strong>服务说明：</strong>用于 Cursor Pro、团队或开发工具订阅协助。下单前请确认邮箱、账号区域和需要的方案。</p><p><strong>交付方式：</strong>人工确认后处理，适合个人开发者和小团队。</p><p><strong>售后边界：</strong>服务完成后请及时检查权益状态；账号后续违规使用导致的限制不属于售后范围。</p>', '/assets/brand/xitan-cover-ai.svg', 0.00, 1.00, 1.00, 1, 0, '2026-05-14 00:00:00', 0, 'XITAN_CURSOR_SERVICE', 1, 0, '订单已提交，请等待人工确认；如需加急，请联系页面客服。', 2, 1, 3, 0, NULL, '', 0.00, NULL, 999, 0, 0, NULL, NULL, 0, 0.00, 0, NULL, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, NULL, 0, 0, 0, 0),
(4, 4, 'Google / Gemini Advanced 开通服务（人工确认）', '<p><strong>服务说明：</strong>用于 Google、Gemini Advanced 等相关服务的开通咨询与人工协助。</p><p><strong>交付方式：</strong>请先通过联系方式确认账号状态，再按客服指引下单。</p><p><strong>售后边界：</strong>地区政策、平台审核、账号安全限制会影响最终处理方式，请下单前确认。</p>', '/assets/brand/xitan-cover-ai.svg', 0.00, 1.00, 1.00, 1, 0, '2026-05-14 00:00:00', 0, 'XITAN_GOOGLE_SERVICE', 1, 0, '订单已提交，请等待人工确认；如需加急，请联系页面客服。', 2, 1, 4, 0, NULL, '', 0.00, NULL, 999, 0, 0, NULL, NULL, 0, 0.00, 0, NULL, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, NULL, 0, 0, 0, 0),
(5, 5, 'AI工具账号与批量开通咨询', '<p><strong>服务说明：</strong>适合需要多账号、团队订阅、API 中转额度或其他 AI 工具开通的用户。</p><p><strong>交付方式：</strong>请先提交联系方式和需求说明，确认方案后再处理。</p><p><strong>提示：</strong>批量或大额订单建议先联系人工客服确认价格、时效和售后范围。</p>', '/assets/brand/xitan-cover-ai.svg', 0.00, 1.00, 1.00, 1, 0, '2026-05-14 00:00:00', 0, 'XITAN_AI_SERVICE', 1, 0, '订单已提交，请等待人工确认；如需加急，请联系页面客服。', 2, 1, 5, 0, NULL, '', 0.00, NULL, 999, 0, 0, NULL, NULL, 0, 0.00, 0, NULL, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, NULL, 0, 0, 0, 0);



DROP TABLE IF EXISTS `__PREFIX__config`;
CREATE TABLE `__PREFIX__config`  (
                                     `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
                                     `key` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '配置键名称',
                                     `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '配置内容',
                                     PRIMARY KEY (`id`) USING BTREE,
                                     UNIQUE INDEX `key`(`key`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 45 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;


INSERT INTO `__PREFIX__config` VALUES (1, 'shop_name', '悉檀AI自助下单开通系统');
INSERT INTO `__PREFIX__config` VALUES (2, 'title', '悉檀AI自助下单开通系统 - AI会员与工具服务');
INSERT INTO `__PREFIX__config` VALUES (3, 'description', '悉檀AI提供AI会员、工具账号、订阅续费与人工开通服务');
INSERT INTO `__PREFIX__config` VALUES (4, 'keywords', '悉檀AI,AI开通,ChatGPT,Claude,Cursor,Gemini,自助下单');
INSERT INTO `__PREFIX__config` VALUES (14, 'user_theme', 'Cartoon');
INSERT INTO `__PREFIX__config` VALUES (5, 'registered_state', '1');
INSERT INTO `__PREFIX__config` VALUES (6, 'registered_type', '0');
INSERT INTO `__PREFIX__config` VALUES (7, 'registered_verification', '1');
INSERT INTO `__PREFIX__config` VALUES (8, 'registered_phone_verification', '0');
INSERT INTO `__PREFIX__config` VALUES (9, 'registered_email_verification', '0');
INSERT INTO `__PREFIX__config` VALUES (10, 'sms_config', '{\"accessKeyId\":\"\",\"accessKeySecret\":\"\",\"signName\":\"\",\"templateCode\":\"\"}');
INSERT INTO `__PREFIX__config` VALUES (11, 'email_config', '{\"smtp\":\"\",\"port\":\"\",\"username\":\"\",\"password\":\"\"}');
INSERT INTO `__PREFIX__config` VALUES (12, 'login_verification', '1');
INSERT INTO `__PREFIX__config` VALUES (13, 'forget_type', '0');
INSERT INTO `__PREFIX__config` VALUES (15, 'notice', '<div style="line-height:1.8;color:#1f2937"><div style="background:#0f172a;color:#fff;padding:22px;margin-bottom:16px;border:1px solid #0f766e"><div style="font-size:12px;letter-spacing:2px;color:#a7f3d0;margin-bottom:8px;font-weight:700">SERVICE NOTICE</div><div style="font-size:22px;font-weight:800">悉檀AI自助下单开通系统</div><div style="font-size:13px;color:#cbd5e1;margin-top:6px">下单前请先阅读服务规则，提交订单即视为同意以下说明。</div></div><div style="background:#ecfdf5;border:2px solid #10b981;padding:16px;margin-bottom:14px"><strong style="color:#065f46">下单规则</strong><p style="margin:8px 0 0">建议注册账号后下单，方便查看订单、保存记录和享受后续会员价格。请填写可联系邮箱，并为订单设置查询密码，避免订单信息被他人查询。</p></div><div style="background:#eff6ff;border:2px solid #3b82f6;padding:16px;margin-bottom:14px"><strong style="color:#1d4ed8">交付说明</strong><p style="margin:8px 0 0">本站以 AI 会员、工具账号、订阅续费和人工开通服务为主。不同平台的处理时效、账号要求和售后范围不同，请以商品详情和客服确认为准。</p></div><div style="background:#fffbeb;border:2px solid #f59e0b;padding:16px;margin-bottom:14px"><strong style="color:#92400e">重要提醒</strong><p style="margin:8px 0 0">虚拟服务交付后，请第一时间检查权益状态并妥善保存订单信息。因账号自身风控、地区限制、违规使用或个人操作失误产生的问题，不属于无理由退款范围。</p></div><div style="background:#f8fafc;border:1px solid #cbd5e1;padding:14px"><strong>批量与大额需求</strong><p style="margin:8px 0 0">企业、团队、多账号或大额开通需求，请先联系人工确认方案、价格和交付周期。</p></div></div>');
INSERT INTO `__PREFIX__config` VALUES (16, 'trade_verification', '1');
INSERT INTO `__PREFIX__config` VALUES (17, 'recharge_welfare', '0');
INSERT INTO `__PREFIX__config` VALUES (18, 'recharge_welfare_config', '');
INSERT INTO `__PREFIX__config` VALUES (19, 'promote_rebate_v1', '0.1');
INSERT INTO `__PREFIX__config` VALUES (20, 'promote_rebate_v2', '0.2');
INSERT INTO `__PREFIX__config` VALUES (21, 'promote_rebate_v3', '0.3');
INSERT INTO `__PREFIX__config` VALUES (22, 'substation_display', '1');
INSERT INTO `__PREFIX__config` VALUES (24, 'domain', '');
INSERT INTO `__PREFIX__config` VALUES (25, 'service_qq', '');
INSERT INTO `__PREFIX__config` VALUES (26, 'service_url', '');
INSERT INTO `__PREFIX__config` VALUES (27, 'cash_type_alipay', '1');
INSERT INTO `__PREFIX__config` VALUES (28, 'cash_type_wechat', '1');
INSERT INTO `__PREFIX__config` VALUES (29, 'cash_cost', '5');
INSERT INTO `__PREFIX__config` VALUES (30, 'cash_min', '100');
INSERT INTO `__PREFIX__config` VALUES (31, 'cname', '');
INSERT INTO `__PREFIX__config` VALUES (32, 'background_url', '/assets/brand/xitan-bg.svg');
INSERT INTO `__PREFIX__config` VALUES (33, 'default_category', '0');
INSERT INTO `__PREFIX__config` VALUES (34, 'substation_display_list', '[]');
INSERT INTO `__PREFIX__config` VALUES (35, 'closed', '0');
INSERT INTO `__PREFIX__config` VALUES (36, 'closed_message', '我们正在升级，请耐心等待完成。');
INSERT INTO `__PREFIX__config` VALUES (37, 'recharge_min', '10');
INSERT INTO `__PREFIX__config` VALUES (38, 'recharge_max', '1000');
INSERT INTO `__PREFIX__config` VALUES (39, 'user_mobile_theme', '0');
INSERT INTO `__PREFIX__config` VALUES (40, 'commodity_recommend', '0');
INSERT INTO `__PREFIX__config` VALUES (41, 'commodity_name', '推荐');
INSERT INTO `__PREFIX__config` VALUES (42, 'background_mobile_url', '');
INSERT INTO `__PREFIX__config` VALUES (43, 'username_len', '6');
INSERT INTO `__PREFIX__config` VALUES (44, 'cash_type_balance', '0');
INSERT INTO `__PREFIX__config` VALUES (45, 'callback_domain', '');
INSERT INTO `__PREFIX__config` VALUES (46, 'session_expire', '0');
INSERT INTO `__PREFIX__config` VALUES (47, 'cash_type_usdt', '1');
INSERT INTO `__PREFIX__config` VALUES (48, 'user_center_theme', 'MountFuji');


DROP TABLE IF EXISTS `__PREFIX__coupon`;
CREATE TABLE `__PREFIX__coupon`  (
                                     `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
                                     `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '优惠卷代码',
                                     `commodity_id` int UNSIGNED NOT NULL COMMENT '商品id',
                                     `owner` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '所属会员：0=系统，其他等于会员UID',
                                     `create_time` datetime NOT NULL COMMENT '创建时间',
                                     `expire_time` datetime NULL DEFAULT NULL COMMENT '过期时间',
                                     `service_time` datetime NULL DEFAULT NULL COMMENT '使用时间',
                                     `money` decimal(10, 2) UNSIGNED NOT NULL COMMENT '抵扣金额',
                                     `status` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态：0=未使用，1=已使用，2=锁定',
                                     `trade_no` char(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单号',
                                     `note` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注信息',
                                     `mode` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '抵扣模式',
                                     `category_id` int UNSIGNED NULL DEFAULT 0 COMMENT '商品分类ID',
                                     `life` int UNSIGNED NOT NULL DEFAULT 1 COMMENT '卡密使用寿命',
                                     `use_life` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '已使用次数',
                                     `race` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品类别',
                                     `sku` json DEFAULT NULL COMMENT 'SKU',
                                     PRIMARY KEY (`id`) USING BTREE,
                                     UNIQUE INDEX `code`(`code` ASC) USING BTREE,
                                     INDEX `commodity_id`(`commodity_id` ASC) USING BTREE,
                                     INDEX `owner`(`owner` ASC) USING BTREE,
                                     INDEX `create_time`(`create_time` ASC) USING BTREE,
                                     INDEX `money`(`money` ASC) USING BTREE,
                                     INDEX `status`(`status` ASC) USING BTREE,
                                     INDEX `order_id`(`trade_no` ASC) USING BTREE,
                                     INDEX `note`(`note` ASC) USING BTREE,
                                     INDEX `race`(`race` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;


DROP TABLE IF EXISTS `__PREFIX__manage`;
CREATE TABLE `__PREFIX__manage`  (
                                     `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
                                     `email` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '邮箱',
                                     `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
                                     `security_password` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '安全密码',
                                     `nickname` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '昵称',
                                     `salt` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '盐',
                                     `avatar` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
                                     `status` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态：0=冻结，1=正常',
                                     `type` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '类型：0=系统账号，1=普通账号(全天)，2=日间账号，3=夜间账号',
                                     `create_time` datetime NOT NULL COMMENT '创建时间',
                                     `login_time` datetime NULL DEFAULT NULL COMMENT '登录时间',
                                     `last_login_time` datetime NULL DEFAULT NULL COMMENT '上一次登录时间',
                                     `login_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登录IP',
                                     `last_login_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上一次登录IP',
                                     `note` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
                                     PRIMARY KEY (`id`) USING BTREE,
                                     UNIQUE INDEX `username`(`email` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;


INSERT INTO `__PREFIX__manage` VALUES (1, '__MANAGE_EMAIL__', '__MANAGE_PASSWORD__', NULL, '__MANAGE_NICKNAME__', '__MANAGE_SALT__', '/favicon.ico', 1, 0, '1997-01-01 00:00:00', NULL , NULL, NULL, NULL, NULL);


DROP TABLE IF EXISTS `__PREFIX__order`;
CREATE TABLE `__PREFIX__order`  (
                                    `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
                                    `owner` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '所属会员：0=游客，其他等于会员UID',
                                    `user_id` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '商户ID：0=系统，其他等于会员ID',
                                    `trade_no` char(19) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单号',
                                    `amount` decimal(10, 2) UNSIGNED NOT NULL COMMENT '订单金额',
                                    `commodity_id` int UNSIGNED NOT NULL COMMENT '商品id',
                                    `card_id` int UNSIGNED NULL DEFAULT NULL COMMENT '预选卡密id',
                                    `card_num` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '卡密数量',
                                    `pay_id` int UNSIGNED NOT NULL COMMENT '支付方式id',
                                    `create_time` datetime NOT NULL COMMENT '下单时间',
                                    `create_ip` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '下单IP',
                                    `create_device` tinyint UNSIGNED NOT NULL COMMENT '下单设备：0=电脑,1=安卓,2=IOS,3=IPAD',
                                    `pay_time` datetime NULL DEFAULT NULL COMMENT '支付时间',
                                    `status` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '订单状态：0=未支付，1=已支付',
                                    `secret` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '卡密信息',
                                    `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '查询密码',
                                    `contact` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系方式',
                                    `delivery_status` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '发货状态：0=未发货，1=已发货',
                                    `pay_url` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                    `coupon_id` int UNSIGNED NULL DEFAULT NULL COMMENT '优惠卷id',
                                    `cost` decimal(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '手续费',
                                    `from` int UNSIGNED NULL DEFAULT NULL COMMENT '推广人id',
                                    `premium` decimal(10, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '加价',
                                    `widget` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '控件内容',
                                    `rent` decimal(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '成本价',
                                    `race` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品种类',
                                    `rebate` decimal(10, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '返利金额',
                                    `pay_cost` decimal(10, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '支付接口手续费',
                                    `sku` json DEFAULT NULL COMMENT 'SKU',
                                    `divide_amount` decimal(10,2) unsigned DEFAULT NULL COMMENT '推广者分成金额',
                                    `substation_user_id` int(10) unsigned DEFAULT NULL COMMENT '子站ID',
                                    `request_no` char(19) COMMENT '请求id',
                                    PRIMARY KEY (`id`) USING BTREE,
                                    UNIQUE INDEX `trade_no`(`trade_no` ASC) USING BTREE,
                                    UNIQUE INDEX `request_no`(`request_no` ASC) USING BTREE,
                                    INDEX `commodity_id`(`commodity_id` ASC) USING BTREE,
                                    INDEX `pay_id`(`pay_id` ASC) USING BTREE,
                                    INDEX `contact`(`contact` ASC) USING BTREE,
                                    INDEX `create_ip`(`create_ip` ASC) USING BTREE,
                                    INDEX `owner`(`owner` ASC) USING BTREE,
                                    INDEX `from`(`from` ASC) USING BTREE,
                                    INDEX `user_id`(`user_id` ASC) USING BTREE,
                                    INDEX `card_id`(`card_id` ASC) USING BTREE,
                                    INDEX `create_time`(`create_time` ASC) USING BTREE,
                                    INDEX `delivery_status`(`delivery_status` ASC) USING BTREE,
                                    INDEX `substation_user_id`(`substation_user_id`) USING BTREE,
                                    INDEX `coupon_id`(`coupon_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;


DROP TABLE IF EXISTS `__PREFIX__order_option`;
CREATE TABLE `__PREFIX__order_option`  (
                                           `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
                                           `order_id` int UNSIGNED NOT NULL COMMENT '订单id',
                                           `option` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '配置数据',
                                           PRIMARY KEY (`id`) USING BTREE,
                                           UNIQUE INDEX `order_id`(`order_id` ASC) USING BTREE,
                                           CONSTRAINT `__PREFIX__order_option_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `__PREFIX__order` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;


DROP TABLE IF EXISTS `__PREFIX__pay`;
CREATE TABLE `__PREFIX__pay`  (
                                  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
                                  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付名称',
                                  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图标',
                                  `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付代码',
                                  `commodity` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '前台状态：0=停用，1=启用',
                                  `recharge` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '充值状态：0=停用，1=启用',
                                  `create_time` datetime NOT NULL COMMENT '添加时间',
                                  `handle` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付平台',
                                  `sort` smallint UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序',
                                  `equipment` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '设备：0=通用，1=手机，2=电脑',
                                  `cost` decimal(10, 3) UNSIGNED NULL DEFAULT 0.000 COMMENT '手续费',
                                  `cost_type` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '手续费模式：0=单笔固定，1=百分比',
                                  PRIMARY KEY (`id`) USING BTREE,
                                  INDEX `commodity`(`commodity` ASC) USING BTREE,
                                  INDEX `recharge`(`recharge` ASC) USING BTREE,
                                  INDEX `sort`(`sort` ASC) USING BTREE,
                                  INDEX `equipment`(`equipment` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;


INSERT INTO `__PREFIX__pay` VALUES (1, '余额', '/assets/static/images/wallet.png', '#system', 1, 0, '1997-01-01 00:00:00', '#system', 999, 0, 0.000, 0);
INSERT INTO `__PREFIX__pay` VALUES (2, '支付宝', '/assets/user/images/cash/alipay.png', 'alipay', 1, 1, '1997-01-01 00:00:00', 'Epay', 1, 0, 0.000, 0);


DROP TABLE IF EXISTS `__PREFIX__shared`;
CREATE TABLE `__PREFIX__shared`  (
                                     `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
                                     `type` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '对接类型：0=内置，其他待扩展',
                                     `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '店铺名称',
                                     `domain` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '店铺地址',
                                     `app_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户ID',
                                     `app_key` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密钥',
                                     `create_time` datetime NOT NULL COMMENT '创建时间',
                                     `balance` decimal(14, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '余额(缓存)',
                                     PRIMARY KEY (`id`) USING BTREE,
                                     UNIQUE INDEX `domain`(`domain` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;


DROP TABLE IF EXISTS `__PREFIX__user`;
CREATE TABLE `__PREFIX__user`  (
                                   `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
                                   `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '会员名',
                                   `email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
                                   `phone` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机',
                                   `qq` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'QQ号',
                                   `password` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录密码',
                                   `salt` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '盐',
                                   `app_key` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '对接密钥',
                                   `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '头像',
                                   `balance` decimal(14, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '余额',
                                   `coin` decimal(14, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '硬币，可提现的币',
                                   `integral` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '积分',
                                   `create_time` datetime NOT NULL COMMENT '注册时间',
                                   `login_time` datetime NULL DEFAULT NULL COMMENT '登录时间',
                                   `last_login_time` datetime NULL DEFAULT NULL COMMENT '上一次登录时间',
                                   `login_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登录IP',
                                   `last_login_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上一次登录IP',
                                   `pid` int UNSIGNED NULL DEFAULT 0 COMMENT '上级ID',
                                   `recharge` decimal(14, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '累计充值',
                                   `total_coin` decimal(14, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '累计获得的硬币',
                                   `status` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态：0=封禁，1=正常',
                                   `business_level` int UNSIGNED NULL DEFAULT NULL COMMENT '商户等级id',
                                   `nicename` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
                                   `alipay` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付宝账号',
                                   `wechat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '微信收款二维码',
                                   `wallet_address` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '钱包地址',
                                   `settlement` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '自动结算：0=支付宝，1=微信',
                                   PRIMARY KEY (`id`) USING BTREE,
                                   UNIQUE INDEX `username`(`username` ASC) USING BTREE,
                                   UNIQUE INDEX `email`(`email` ASC) USING BTREE,
                                   UNIQUE INDEX `phone`(`phone` ASC) USING BTREE,
                                   INDEX `pid`(`pid` ASC) USING BTREE,
                                   INDEX `business_level`(`business_level` ASC) USING BTREE,
                                   INDEX `coin`(`coin` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1000 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;


DROP TABLE IF EXISTS `__PREFIX__user_category`;
CREATE TABLE `__PREFIX__user_category`  (
                                            `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
                                            `user_id` int UNSIGNED NOT NULL COMMENT '商家id',
                                            `category_id` int UNSIGNED NOT NULL COMMENT '分类id',
                                            `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '自定义分类名称',
                                            `status` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态：0=屏蔽，1=显示',
                                            PRIMARY KEY (`id`) USING BTREE,
                                            UNIQUE INDEX `user_id`(`user_id` ASC, `category_id` ASC) USING BTREE,
                                            INDEX `status`(`status` ASC) USING BTREE,
                                            INDEX `__PREFIX__user_category_ibfk_2`(`category_id` ASC) USING BTREE,
                                            INDEX `user_id_2`(`user_id` ASC) USING BTREE,
                                            CONSTRAINT `__PREFIX__user_category_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `__PREFIX__user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
                                            CONSTRAINT `__PREFIX__user_category_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `__PREFIX__category` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;


DROP TABLE IF EXISTS `__PREFIX__user_commodity`;
CREATE TABLE `__PREFIX__user_commodity`  (
                                             `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
                                             `user_id` int UNSIGNED NOT NULL COMMENT '商家id',
                                             `commodity_id` int UNSIGNED NOT NULL COMMENT '商品id',
                                             `premium` float(10, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '商品加价',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '自定义名称',
  `status` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态：0=隐藏，1=显示',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_id`(`user_id` ASC, `commodity_id` ASC) USING BTREE,
  INDEX `commodity_id`(`commodity_id` ASC) USING BTREE,
  INDEX `user_id_2`(`user_id` ASC) USING BTREE,
  INDEX `status`(`status` ASC) USING BTREE,
  CONSTRAINT `__PREFIX__user_commodity_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `__PREFIX__user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `__PREFIX__user_commodity_ibfk_2` FOREIGN KEY (`commodity_id`) REFERENCES `__PREFIX__commodity` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;


DROP TABLE IF EXISTS `__PREFIX__user_group`;
CREATE TABLE `__PREFIX__user_group`  (
                                         `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
                                         `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '等级名称',
                                         `icon` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '等级图标',
                                         `discount_config` TEXT DEFAULT NULL COMMENT '折扣配置',
                                         `cost` decimal(4, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '抽成比例',
                                         `recharge` decimal(14, 2) UNSIGNED NOT NULL COMMENT '累计充值(达到该等级)',
                                         PRIMARY KEY (`id`) USING BTREE,
                                         UNIQUE INDEX `recharge`(`recharge` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;


INSERT INTO `__PREFIX__user_group` VALUES (1, '一贫如洗', '/assets/static/images/group/ic_user level_1.png', null, 0.30, 0.00);
INSERT INTO `__PREFIX__user_group` VALUES (2, '小康之家', '/assets/static/images/group/ic_user level_2.png', null, 0.25, 50.00);
INSERT INTO `__PREFIX__user_group` VALUES (3, '腰缠万贯', '/assets/static/images/group/ic_user level_3.png', null, 0.20, 100.00);
INSERT INTO `__PREFIX__user_group` VALUES (4, '富甲一方', '/assets/static/images/group/ic_user level_4.png', null, 0.15, 200.00);
INSERT INTO `__PREFIX__user_group` VALUES (5, '富可敌国', '/assets/static/images/group/ic_user level_5.png', null, 0.10, 300.00);
INSERT INTO `__PREFIX__user_group` VALUES (6, '至尊', '/assets/static/images/group/ic_user level_6.png', null, 0.05, 500.00);

DROP TABLE IF EXISTS `__PREFIX__user_recharge`;
CREATE TABLE `__PREFIX__user_recharge`  (
                                            `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
                                            `trade_no` char(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单号',
                                            `user_id` int UNSIGNED NOT NULL COMMENT '用户id',
                                            `amount` decimal(10, 2) UNSIGNED NOT NULL COMMENT '充值金额',
                                            `pay_id` int UNSIGNED NOT NULL COMMENT '支付id',
                                            `status` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态：0=未支付，1=已支付',
                                            `create_time` datetime NOT NULL COMMENT '创建时间',
                                            `create_ip` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '下单IP',
                                            `pay_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付地址',
                                            `pay_time` datetime NULL DEFAULT NULL COMMENT '支付时间',
                                            `option` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '配置参数',
                                            PRIMARY KEY (`id`) USING BTREE,
                                            UNIQUE INDEX `trade_no`(`trade_no` ASC) USING BTREE,
                                            INDEX `user_id`(`user_id` ASC) USING BTREE,
                                            INDEX `pay_id`(`pay_id` ASC) USING BTREE,
                                            INDEX `status`(`status` ASC) USING BTREE,
                                            CONSTRAINT `__PREFIX__user_recharge_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `__PREFIX__user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;


DROP TABLE IF EXISTS `__PREFIX__manage_log`;
CREATE TABLE `__PREFIX__manage_log`  (
                                         `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
                                         `email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '管理员邮箱',
                                         `nickname` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '管理员呢称',
                                         `content` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '日志内容',
                                         `create_time` datetime NOT NULL COMMENT '创建时间',
                                         `create_ip` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'IP地址',
                                         `ua` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '浏览器UA',
                                         `risk` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '风险：0=正常，1=异常',
                                         PRIMARY KEY (`id`) USING BTREE,
                                         INDEX `create_ip`(`create_ip`) USING BTREE,
                                         INDEX `create_time`(`create_time`) USING BTREE,
                                         INDEX `risk`(`risk`) USING BTREE,
                                         INDEX `email`(`email`) USING BTREE,
                                         INDEX `nickname`(`nickname`) USING BTREE,
                                         INDEX `content`(`content`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

DROP TABLE IF EXISTS `__PREFIX__commodity_group`;
CREATE TABLE IF NOT EXISTS `__PREFIX__commodity_group` (
                                                           `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
    `name` varchar(32) NOT NULL COMMENT '组名称',
    `commodity_list` json DEFAULT NULL COMMENT '商品列表',
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `__PREFIX__upload`;
CREATE TABLE `__PREFIX__upload` (
                                    `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
                                    `user_id` int(11) unsigned DEFAULT NULL COMMENT 'null=后台',
                                    `hash` varchar(32) NOT NULL COMMENT '文件MD5',
                                    `type` varchar(8) NOT NULL COMMENT '文件类型',
                                    `path` varchar(255) NOT NULL COMMENT '文件路径',
                                    `create_time` datetime NOT NULL COMMENT '上传时间',
                                    `note` varchar(32) DEFAULT NULL COMMENT '文件备注',
                                    PRIMARY KEY (`id`) USING BTREE,
                                    UNIQUE KEY `hash` (`hash`) USING BTREE,
                                    KEY `user_id` (`user_id`) USING BTREE,
                                    KEY `type` (`type`) USING BTREE,
                                    KEY `create_time` (`create_time`) USING BTREE,
                                    KEY `note` (`note`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4;

SET FOREIGN_KEY_CHECKS = 1;
