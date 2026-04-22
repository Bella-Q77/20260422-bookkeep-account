<?php
// +----------------------------------------------------------------------
// | 07FLY系统 [基于ThinkPHP5.0开发]
// +----------------------------------------------------------------------
// | Copyright (c) 2016-2021 http://www.07fly.xyz
// +----------------------------------------------------------------------
// | 07FLY承诺基础框架永久免费开源，您可用于学习和商用，但必须保留软件版权信息。
// +----------------------------------------------------------------------
// | Author: 开发人生 <574249366@qq.com>
// +----------------------------------------------------------------------
/**
 * 表结构基本信息
 */
/**
 * type 类型
 * length 类型长度
 * unsigned 是否无符号
 * autoincrement 是否自动增长
 * required  是否必填
 * default  默认值
 * comment  注释
 */
return [
    'tables' => [

        //会员表
        'member' => [
            'table_name' => 'member',
            'comment' => '[会员]注册会员列表',
            'engine' => 'MyISAM',
            'charset' => 'utf8mb4',
            'collate' => 'utf8mb4_general_ci',
            'columns' => [
                'id' => ['type' => 'int', 'length' => 16, 'unsigned' => false, 'autoincrement' => true, 'comment' => '关键id',],
                'is_recharge' => ['type' => 'int', 'length' => 2, 'required' => true, 'default' => 0, 'comment' => '0=未充值，1=充值过',],
                'expire_level_time' => ['type' => 'datetime', 'required' => false, 'comment' => 'vip会员到期时间',],
            ],
            //主键 多个主键['user_id','name']
            'primary' => ['id'],
            'index' => [],
        ],

        //会员表
        'member_order' => [
            'table_name' => 'member_order',
            'comment' => '[会员]会员订单表',
            'engine' => 'MyISAM',
            'charset' => 'utf8mb4',
            'collate' => 'utf8mb4_general_ci',
            'columns' => [
                'id' => ['type' => 'int', 'length' => 16, 'unsigned' => false, 'autoincrement' => true, 'comment' => '关键id',],
                'pay_transaction_no' => ['type' => 'varchar', 'length' => 256, 'required' => true, 'default' => 0, 'comment' => '支付渠道单号',],
            ],
            //主键 多个主键['user_id','name']
            'primary' => ['id'],
            'index' => [],
        ],

        //点评记录  2023-03-01
        'ask_type' => [
            'table_name' => 'ask_type',
            'comment' => '[会员]问题类型',
            'engine' => 'InnoDB',
            'charset' => 'utf8mb4',
            'collate' => 'utf8mb4_general_ci',
            'columns' => [
                'id' => ['type' => 'int', 'length' => 16, 'unsigned' => false, 'autoincrement' => true, 'comment' => '关键id',],
                'name' => ['type' => 'varchar', 'length' => 256, 'required' => true, 'default' => '', 'comment' => '名称',],
                'remark' => ['type' => 'varchar', 'length' => 512, 'required' => true, 'default' => '', 'comment' => '备注说明',],
                'pid' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '父级id',],
                'create_time' => ['type' => 'int', 'length' => 16, 'required' => false, 'default' => 0, 'comment' => '创建时间',],
                'update_time' => ['type' => 'int', 'length' => 16, 'required' => false, 'default' => 0, 'comment' => '更新时间',],
                'create_user_id' => ['type' => 'int', 'length' => 16, 'required' => false, 'default' => 0, 'comment' => '创建人员',],
                'org_id' => ['type' => 'int', 'length' => 16, 'required' => false, 'default' => 1, 'comment' => '企业编号',],
            ],
            //主键 多个主键['user_id','name']
            'primary' => ['id'],
            'index' => [],
        ],
        'ask_faq' => [
            'table_name' => 'ask_faq',
            'comment' => '[会员]问题列表',
            'engine' => 'InnoDB',
            'charset' => 'utf8mb4',
            'collate' => 'utf8mb4_general_ci',
            'columns' => [
                'id' => ['type' => 'int', 'length' => 16, 'unsigned' => false, 'autoincrement' => true, 'comment' => '关键id',],
                'type_id' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '分类id',],
                'name' => ['type' => 'varchar', 'length' => 256, 'required' => true, 'default' => '', 'comment' => '标题',],
                'content' => ['type' => 'text', 'required' => false, 'comment' => '内容',],
                'attachment' => ['type' => 'text', 'required' => false, 'comment' => '附件',],
                'member_id' => ['type' => 'int', 'length' => 16, 'required' => false, 'default' => 0, 'comment' => '会员id',],
                'status' => ['type' => 'int', 'length' => 2, 'required' => false, 'default' => 0, 'comment' => '0=待处理，1=处理中，2=已经回复，3=已完成，4=关闭',],
                'create_time' => ['type' => 'int', 'length' => 16, 'required' => false, 'default' => 0, 'comment' => '创建时间',],
                'update_time' => ['type' => 'int', 'length' => 16, 'required' => false, 'default' => 0, 'comment' => '更新时间',],
                'create_user_id' => ['type' => 'int', 'length' => 16, 'required' => false, 'default' => 0, 'comment' => '创建人员',],
                'org_id' => ['type' => 'int', 'length' => 16, 'required' => false, 'default' => 1, 'comment' => '企业编号',],
            ],
            //主键 多个主键['user_id','name']
            'primary' => ['id'],
            'index' => [],
        ],

        'ask_comment' => [
            'table_name' => 'ask_comment',
            'comment' => '[会员]问题点评记录',
            'engine' => 'InnoDB',
            'charset' => 'utf8mb4',
            'collate' => 'utf8mb4_general_ci',
            'columns' => [
                'id' => ['type' => 'int', 'length' => 16, 'unsigned' => false, 'autoincrement' => true, 'comment' => '关键id',],
                'bus_id' => ['type' => 'int', 'length' => 11, 'required' => true, 'default' => 0, 'comment' => '业务id',],
                'bus_type' => ['type' => 'varchar', 'length' => 128, 'required' => true, 'default' => '', 'comment' => '业务类型',],
                'comment_user_id' => ['type' => 'int', 'length' => 11, 'required' => true, 'default' => 0, 'comment' => '点评人员id',],
                'receive_user_id' => ['type' => 'int', 'length' => 11, 'required' => true, 'default' => 0, 'comment' => '被点评人员id',],
                'content' => ['type' => 'text', 'required' => false, 'comment' => '点评内容',],
                'attachment' => ['type' => 'text', 'required' => false, 'comment' => '附件内容',],

                'create_time' => ['type' => 'int', 'length' => 16, 'required' => false, 'default' => 0, 'comment' => '创建时间',],
                'update_time' => ['type' => 'int', 'length' => 16, 'required' => false, 'default' => 0, 'comment' => '更新时间',],
                'create_user_id' => ['type' => 'int', 'length' => 16, 'required' => false, 'default' => 0, 'comment' => '创建人员',],
                'org_id' => ['type' => 'int', 'length' => 16, 'required' => false, 'default' => 1, 'comment' => '企业编号',],
            ],
            //主键 多个主键['user_id','name']
            'primary' => ['id'],
            'index' => [],
        ],

        //点评记录回复
        'ask_comment_reply' => [
            'table_name' => 'ask_comment_reply',
            'comment' => '[会员]点评记录回复',
            'engine' => 'InnoDB',
            'charset' => 'utf8mb4',
            'collate' => 'utf8mb4_general_ci',
            'columns' => [
                'id' => ['type' => 'int', 'length' => 16, 'unsigned' => false, 'autoincrement' => true, 'comment' => '关键id',],
                'comment_id' => ['type' => 'int', 'length' => 11, 'required' => true, 'default' => 0, 'comment' => '点评id',],
                'bus_id' => ['type' => 'int', 'length' => 11, 'required' => true, 'default' => 0, 'comment' => '业务id',],
                'bus_type' => ['type' => 'varchar', 'length' => 128, 'required' => true, 'default' => '', 'comment' => '业务类型',],
                'reply_user_id' => ['type' => 'int', 'length' => 11, 'required' => true, 'default' => 0, 'comment' => '回复人员id',],
                'receive_user_id' => ['type' => 'int', 'length' => 11, 'required' => true, 'default' => 0, 'comment' => '被点评人员id',],
                'content' => ['type' => 'text', 'required' => false, 'comment' => '点评内容',],
                'attachment' => ['type' => 'text', 'required' => false, 'comment' => '附件内容',],

                'create_time' => ['type' => 'int', 'length' => 16, 'required' => false, 'default' => 0, 'comment' => '创建时间',],
                'update_time' => ['type' => 'int', 'length' => 16, 'required' => false, 'default' => 0, 'comment' => '更新时间',],
                'create_user_id' => ['type' => 'int', 'length' => 16, 'required' => false, 'default' => 0, 'comment' => '创建人员',],
                'org_id' => ['type' => 'int', 'length' => 16, 'required' => false, 'default' => 1, 'comment' => '企业编号',],
            ],
            //主键 多个主键['user_id','name']
            'primary' => ['id'],
            'index' => [],
        ],
        //表结构结束 ********************************************************************************************************
    ],//end tables;

];