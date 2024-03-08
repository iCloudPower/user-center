SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------------------------------------------------- --
-- 1、app应用 表结构
-- ----------------------------
DROP TABLE IF EXISTS `t_app`;
CREATE TABLE `t_app` (
    `id`                INT(6)          NOT NULL AUTO_INCREMENT,
    `app_name`          VARCHAR(32)     NOT NULL                    COMMENT 'app名称',
    `secret`            VARCHAR(32)     NOT NULL                    COMMENT '密钥',
    `status`            CHAR(1)         DEFAULT '0'                 COMMENT '应用状态（0正常 1停用）',
    `deleted`           BIT             DEFAULT 0                   COMMENT '是否已删除，1 表示已经删除',
    `create_time`       TIMESTAMP                                   COMMENT '创建时间',
    `create_by`         VARCHAR(64)                                 COMMENT '创建人',
    `update_time`       TIMESTAMP                                   COMMENT '更新时间',
    `update_by`         VARCHAR(64)                                 COMMENT '更新人',
    `remark`            VARCHAR(200)                                COMMENT '备注',
    PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT = 1 CHARSET=utf8 COMMENT='app 表';
-- ----------------------------
-- 初始化: 插入默认app
-- ----------------------------
INSERT INTO t_app VALUES (100000, '用户中心', 'secret', '0', 0, sysdate(), 'system', sysdate(), 'system', '用户权限中心（不可删除）');


-- ----------------------------------------------------------------------- --
-- 2、用户 表结构
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
    `id`                BIGINT(16)      NOT NULL AUTO_INCREMENT,
    `user_name`         VARCHAR(32)     NOT NULL                    COMMENT '用户名（唯一）',
    `nick_name`         VARCHAR(32)                                 COMMENT '用户昵称',
    `phone`             VARCHAR(11)     NOT NULL                    COMMENT '手机号',
    `password`          VARCHAR(32)                                 COMMENT '密码',
    `email`             VARCHAR(48)                                 COMMENT '邮箱',
    `avatar`            VARCHAR(100)                                COMMENT '头像',
    `status`            CHAR(1)         DEFAULT '0'                 COMMENT '帐号状态（0正常 1停用）',
    `deleted`           BIT             DEFAULT 0                   COMMENT '是否已删除，1 表示已经删除',
    `create_time`       TIMESTAMP                                   COMMENT '创建时间',
    `create_by`         VARCHAR(64)                                 COMMENT '创建人',
    `update_time`       TIMESTAMP                                   COMMENT '更新时间',
    `update_by`         VARCHAR(64)                                 COMMENT '更新人',
    `remark`            VARCHAR(200)                                COMMENT '备注',
    PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT = 2 CHARSET=utf8 COMMENT='用户表';
-- ----------------------------
-- 初始化: 插入管理员用户 默认密码: 123456
-- ----------------------------
INSERT INTO t_user VALUES (100000, 'admin', '管理员', '00000000000', 'password', 'admin@example.com', null, '0', 0, sysdate(), 'system', sysdate(), 'system', null);


-- ----------------------------------------------------------------------- --
-- 3、角色 表结构
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role` (
    `id`                INT(6)          NOT NULL AUTO_INCREMENT,
    `role_name`         VARCHAR(32)     NOT NULL                    COMMENT '角色名称',
    `role_key`          VARCHAR(32)     DEFAULT 'ROLE_'             COMMENT '角色key（唯一）',
    `status`            CHAR(1)         DEFAULT '0'                 COMMENT '角色状态（0正常 1停用）',
    `deleted`           BIT             DEFAULT 0                   COMMENT '是否已删除，1 表示已经删除',
    `create_time`       TIMESTAMP                                   COMMENT '创建时间',
    `create_by`         VARCHAR(64)                                 COMMENT '创建人',
    `update_time`       TIMESTAMP                                   COMMENT '更新时间',
    `update_by`         VARCHAR(64)                                 COMMENT '更新人',
    `remark`            VARCHAR(200)                                COMMENT '备注',
    PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT = 1 CHARSET=utf8 COMMENT='角色表';
-- ----------------------------
-- 初始化: 插入超级管理员角色
-- ----------------------------
INSERT INTO t_role VALUES (100000, '超级管理员', 'ROLE_admin', '0', 0, sysdate(), 'system', sysdate(), 'system', '超级管理员');


-- ----------------------------------------------------------------------- --
-- 4、权限 表结构
-- ----------------------------
DROP TABLE IF EXISTS `t_permission`;
CREATE TABLE `t_permission` (
    `id`                INT(6)          NOT NULL AUTO_INCREMENT,
    `app_id`            INT(6)                                      COMMENT '权限所属应用appid',
    `permission_name`   VARCHAR(32)     NOT NULL                    COMMENT '权限名称',
    `permission_key`    VARCHAR(32)     NOT NULL                    COMMENT '权限key（唯一）',
    `parent_id`         INT(6)          DEFAULT 0                   COMMENT '父权限id',
    `sort`              INT(4)          DEFAULT 0                   COMMENT '排序',
    `path`              VARCHAR(128)    DEFAULT ''                  COMMENT '路由地址',
    `permission_type`   char(1)         default 'M'                 comment '菜单类型（D:目录Dir M:菜单Menu B:按钮Button ）',
    `create_time`       TIMESTAMP                                   COMMENT '创建时间',
    `create_by`         VARCHAR(64)                                 COMMENT '创建人',
    `update_time`       TIMESTAMP                                   COMMENT '更新时间',
    `update_by`         VARCHAR(64)                                 COMMENT '更新人',
    `remark`            VARCHAR(64)                                 COMMENT '备注',
    PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT = 1 CHARSET=utf8 COMMENT='菜单权限表';
-- ----------------------------
-- 初始化: 插入【用户中心】默认权限
-- ----------------------------
INSERT INTO t_permission VALUES (100000, 100000, 'dashboard', '工作台', 0, 1, '/dashboard', 'M', sysdate(), 'system', sysdate(), 'system', '系统创建菜单');
INSERT INTO t_permission VALUES (100001, 100000, 'user', '用户管理', 0, 2, '/user', 'M', sysdate(), 'system', sysdate(), 'system', '系统创建菜单');
INSERT INTO t_permission VALUES (100002, 100000, 'role', '角色管理', 0, 3, '/role', 'M', sysdate(), 'system', sysdate(), 'system', '系统创建菜单');
INSERT INTO t_permission VALUES (100003, 100000, 'permission', '权限管理', 0, 4, '/permission', 'M', sysdate(), 'system', sysdate(), 'system', '系统创建菜单');
INSERT INTO t_permission VALUES (100004, 100000, 'app', '应用管理', 0, 5, '/app', 'M', sysdate(), 'system', sysdate(), 'system', '系统创建菜单');


-- ----------------------------------------------------------------------- --
-- 5、用户和角色关联表  用户N-1角色
-- ----------------------------
DROP TABLE IF EXISTS `t_user_role`;
CREATE TABLE `t_user_role` (
    `user_id`         BIGINT(16)        NOT NULL                    COMMENT '用户ID',
    `role_id`         INT(6)            NOT NULL                    COMMENT '角色ID',
    primary key(user_id, role_id)
) ENGINE=INNODB CHARSET=utf8 COMMENT='用户和角色关联表';
-- ----------------------------
-- 初始化: 插入 管理员为超级管理员角色
-- ----------------------------
INSERT INTO t_user_role VALUES (100000, 100000);


-- ----------------------------------------------------------------------- --
-- 6、角色和权限关联表  角色1-N权限
-- ----------------------------
DROP TABLE IF EXISTS `t_role_permission`;
CREATE TABLE `t_role_permission` (
    `role_id`         INT(6)            NOT NULL                    COMMENT '角色ID',
    `permission_id`         INT(6)            NOT NULL                    COMMENT '菜单权限ID',
    primary key(role_id, permission_id)
) ENGINE=INNODB CHARSET=utf8 COMMENT='角色和权限关联表';
-- ----------------------------
-- 初始化: 插入超级管理员角色的所有菜单权限
-- ----------------------------
INSERT INTO t_role_permission VALUES (100000, 100000);
INSERT INTO t_role_permission VALUES (100000, 100001);
INSERT INTO t_role_permission VALUES (100000, 100002);
INSERT INTO t_role_permission VALUES (100000, 100003);
INSERT INTO t_role_permission VALUES (100000, 100004);


-- ----------------------------------------------------------------------- --
-- 7、用户和应用关联表  用户1-N应用
-- ----------------------------
DROP TABLE IF EXISTS `t_user_app`;
CREATE TABLE `t_user_app` (
    `user_id`         BIGINT(16)        NOT NULL                    COMMENT '用户ID',
    `app_id`          INT(6)            NOT NULL                    COMMENT '角色ID',
    primary key(user_id, app_id)
) ENGINE=INNODB CHARSET=utf8 COMMENT='用户和应用关联表';
-- ----------------------------
-- 初始化: 插入 管理员拥有100000平台
-- ----------------------------
INSERT INTO t_user_app VALUES (100000, 100000);
