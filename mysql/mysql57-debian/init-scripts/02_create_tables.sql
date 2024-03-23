DROP TABLE IF EXISTS `t_user`;

CREATE TABLE `t_user` (
    `id`              bigint(13)  NOT NULL AUTO_INCREMENT,
    `name`            varchar(32) NOT NULL DEFAULT '' COMMENT '用户名',
    `action`          tinyint(4)  NOT NULL DEFAULT 0 COMMENT '记录状态',
    `action_time`     bigint(13)  NOT NULL DEFAULT 0 COMMENT '更新时间',
    `create_time`     bigint(13)  NOT NULL DEFAULT 0 COMMENT '创建时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4_unicode_ci COMMENT ='用户表';
