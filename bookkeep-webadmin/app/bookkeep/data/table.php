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

        /* 2. 账本表 */
        'bk_books' => [
            'table_name' => 'bk_book',
            'comment' => '[记账]账本主表',
            'engine' => 'InnoDB',
            'charset' => 'utf8mb4',
            'collate' => 'utf8mb4_general_ci',
            'columns' => [
                'id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'autoincrement' => true, 'comment' => '账本ID'],
                'name' => ['type' => 'varchar', 'length' => 100, 'required' => true, 'default' => '', 'comment' => '账本名称'],
                'remark' => ['type' => 'text', 'required' => false, 'comment' => '账本描述'],
                'currency' => ['type' => 'char', 'length' => 10, 'required' => false, 'default' => 'CNY', 'comment' => '默认币种'],
                'is_template' => ['type' => 'tinyint', 'length' => 1, 'unsigned' => true, 'required' => true, 'default' => 0, 'comment' => '是否模板账本'],

                'visible' => ['type' => 'tinyint', 'length' => 1, 'unsigned' => true, 'required' => false, 'default' => 0, 'comment' => '1=隐藏'],
                'sort' => ['type' => 'tinyint', 'length' => 1, 'unsigned' => true, 'required' => false, 'default' => 0, 'comment' => '排序'],
                'is_default' => ['type' => 'tinyint', 'length' => 1, 'unsigned' => true, 'required' => false, 'default' => 0, 'comment' => '是否默认账户，0=否、1=是'],

                'member_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => 0, 'comment' => '用户ID'],
                'create_time' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '创建日期',],
                'update_time' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '更新日期',],
                'org_id' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 1, 'comment' => '企业编号',],
                'ten_tenant_id' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '租户id',],
                'is_delete' => ['type' => 'TINYINT', 'length' => 4, 'required' => true, 'default' => 0, 'comment' => '是否删除',],
            ],
            'primary' => ['id'],
            'index' => [],
        ],

        /* 3. 账本-用户中间表 */
        'bk_book_users' => [
            'table_name' => 'bk_book_users',
            'comment' => '账本与用户多对多关系',
            'engine' => 'InnoDB',
            'charset' => 'utf8mb4',
            'collate' => 'utf8mb4_general_ci',
            'columns' => [
                'id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'autoincrement' => true, 'comment' => 'ID'],
                'book_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => 0, 'comment' => '账本ID'],
                'member_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => 0, 'comment' => '用户ID'],
                'role' => ['type' => 'TINYINT', 'length' => 4, 'required' => true, 'default' => '0', 'comment' => '角色,默认为成员,0=成员、1=创建人员、2=管理人员'],

                'create_time' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '创建日期',],
                'update_time' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '更新日期',],
            ],
            'primary' => ['id'],
            'index' => [
                'idx_book_member_id' => ['unique' => true, 'columns' => ['book_id', 'member_id']],
            ],
        ],

        /* 4. 账户表 */
        'bk_account' => [
            'table_name' => 'bk_account',
            'comment' => '账户（现金、银行卡等）',
            'engine' => 'InnoDB',
            'charset' => 'utf8mb4',
            'collate' => 'utf8mb4_general_ci',
            'columns' => [
                'id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'autoincrement' => true, 'comment' => '账户ID'],
                'book_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => 0, 'comment' => '所属账本'],
                'name' => ['type' => 'varchar', 'length' => 100, 'required' => true, 'default' => '', 'comment' => '账户名称'],
                'type' => ['type' => 'TINYINT', 'length' => 4, 'required' => true, 'default' => 0, 'comment' => '账户类型，0=现金、1=银行卡、2=信用卡、3=支付宝、4=微信、5=投资、6=债务、7=礼金'],
                'currency' => ['type' => 'char', 'length' => 3, 'required' => true, 'default' => 'CNY', 'comment' => '币种'],
                'balance' => ['type' => 'decimal', 'length' => '15,2', 'required' => true, 'default' => 0, 'comment' => '当前余额'],

                'visible' => ['type' => 'tinyint', 'length' => 1, 'unsigned' => true, 'required' => false, 'default' => 0, 'comment' => '1=隐藏'],
                'sort' => ['type' => 'tinyint', 'length' => 1, 'unsigned' => true, 'required' => false, 'default' => 0, 'comment' => '排序'],
                'is_default' => ['type' => 'tinyint', 'length' => 1, 'unsigned' => true, 'required' => false, 'default' => 0, 'comment' => '是否默认账户，0=否、1=是'],

                'member_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => 0, 'comment' => '用户ID'],
                'create_time' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '创建日期',],
                'update_time' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '更新日期',],
                'org_id' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 1, 'comment' => '企业编号',],
                'ten_tenant_id' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '租户id',],
                'is_delete' => ['type' => 'TINYINT', 'length' => 4, 'required' => true, 'default' => 0, 'comment' => '是否删除',],
            ],
            'primary' => ['id'],
            'index' => [
                'idx_book_id' => ['columns' => ['book_id']],
            ],

        ],

        /* 5. 分类表 */
        'bk_category' => [
            'table_name' => 'bk_category',
            'comment' => '收支分类（支持多级）',
            'engine' => 'InnoDB',
            'charset' => 'utf8mb4',
            'collate' => 'utf8mb4_general_ci',
            'columns' => [
                'id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'autoincrement' => true, 'comment' => '分类ID'],
                'book_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => '0', 'comment' => '所属账本'],
                'parent_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => '0', 'comment' => '父级ID'],
                'name' => ['type' => 'varchar', 'length' => 100, 'required' => true, 'default' => '', 'comment' => '分类名称'],
                'icon' => ['type' => 'varchar', 'length' => 100, 'required' => true, 'default' => '', 'comment' => '图标'],
                'type' => ['type' => 'TINYINT', 'length' => 4, 'required' => true, 'default' => 1, 'comment' => '收支类型,1=收入，-1=支出'],
                'sort' => ['type' => 'int', 'length' => 11, 'required' => false, 'default' => 0, 'comment' => '排序'],
                'template_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => '0', 'comment' => '模板来源ID'],

                'member_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => 0, 'comment' => '用户ID'],
                'create_time' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '创建日期',],
                'update_time' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '更新日期',],
                'org_id' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 1, 'comment' => '企业编号',],
                'ten_tenant_id' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '租户id',],
                'is_delete' => ['type' => 'TINYINT', 'length' => 4, 'required' => true, 'default' => 0, 'comment' => '是否删除',],
            ],
            'primary' => ['id'],
            'index' => [
                'idx_book_id' => ['columns' => ['book_id']],
                'idx_parent_id' => ['columns' => ['parent_id']],
            ],
        ],

        /* 6. 交易记录表 */
        'bk_transaction' => [
            'table_name' => 'bk_transaction',
            'comment' => '收入/支出/转账（transfer类型时关联transfers表）',
            'engine' => 'InnoDB',
            'charset' => 'utf8mb4',
            'collate' => 'utf8mb4_general_ci',
            'columns' => [
                'id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'autoincrement' => true, 'comment' => '交易ID'],
                'book_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => '0', 'comment' => '账本ID'],
                'account_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => '0', 'comment' => '账户ID'],
                'category_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => '0', 'comment' => '分类ID'],
                'type' => ['type' => 'TINYINT', 'length' => 4, 'required' => true, 'default' => 1, 'comment' => '交易类型，1=收入，-1=支出，0=转账'],
                'amount' => ['type' => 'decimal', 'length' => '15,2', 'required' => true, 'default' => '0', 'comment' => '金额（正收入负支出）'],
                'currency' => ['type' => 'char', 'length' => 3, 'required' => false, 'default' => 'CNY', 'comment' => '币种'],
                'description' => ['type' => 'text', 'required' => false, 'comment' => '备注'],
                'transaction_date' => ['type' => 'date', 'required' => false, 'comment' => '交易时间'],
                'is_refund' => ['type' => 'tinyint', 'length' => 1, 'unsigned' => true, 'required' => true, 'default' => 0, 'comment' => '1=退款'],
                'is_reimbursable' => ['type' => 'tinyint', 'length' => 1, 'unsigned' => true, 'required' => false, 'default' => 0, 'comment' => '1=可报销'],
                'receipt_image' => ['type' => 'varchar', 'length' => 500, 'required' => true, 'default' => '', 'comment' => '小票图片URL'],

                'shop_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => 0, 'comment' => '商品ID'],
                'person_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => 0, 'comment' => '成员 ID'],
                'project_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => 0, 'comment' => '项目 ID'],

                'shop_name' => ['type' => 'varchar', 'length' => 128, 'required' => true, 'default' => '', 'comment' => '商家名称'],
                'person_name' => ['type' => 'varchar', 'length' => 128, 'required' => true, 'default' => '', 'comment' => '成员名称'],
                'project_name' => ['type' => 'varchar', 'length' => 128, 'required' => true, 'default' => '', 'comment' => '项目名称'],

                'member_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => 0, 'comment' => '用户ID'],
                'create_time' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '创建日期',],
                'update_time' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '更新日期',],
                'org_id' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 1, 'comment' => '企业编号',],
                'ten_tenant_id' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '租户id',],
                'is_delete' => ['type' => 'TINYINT', 'length' => 4, 'required' => true, 'default' => 0, 'comment' => '是否删除',],
            ],
            'primary' => ['id'],
            'index' => [
                'idx_book_id' => ['columns' => ['book_id']],
                'idx_account_id' => ['columns' => ['account_id']],
                'idx_transaction_time' => ['columns' => ['transaction_date']],
            ],
        ],

        /* 7. 转账记录表 */
        'bk_transfer' => [
            'table_name' => 'bk_transfer',
            'comment' => '账户间转账（不重复记收支）',
            'engine' => 'InnoDB',
            'charset' => 'utf8mb4',
            'collate' => 'utf8mb4_general_ci',
            'columns' => [
                'id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'autoincrement' => true, 'comment' => '转账ID'],
                'book_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => '0', 'comment' => '账本ID'],
                'from_account_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => '0', 'comment' => '转出账户'],
                'to_account_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => '0', 'comment' => '转入账户'],
                'amount' => ['type' => 'decimal', 'length' => '15,2', 'required' => true, 'default' => '0', 'comment' => '转账金额'],
                'currency' => ['type' => 'char', 'length' => 3, 'required' => true, 'default' => 'CNY', 'comment' => '币种'],
                'fee' => ['type' => 'decimal', 'length' => '10,2', 'required' => true, 'default' => 0, 'comment' => '手续费'],
                'description' => ['type' => 'text', 'required' => false, 'comment' => '备注'],
                'transfer_date' => ['type' => 'date', 'required' => false, 'comment' => '转账时间'],

                'member_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => 0, 'comment' => '用户ID'],
                'create_time' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '创建日期',],
                'update_time' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '更新日期',],
                'org_id' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 1, 'comment' => '企业编号',],
                'ten_tenant_id' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '租户id',],
                'is_delete' => ['type' => 'TINYINT', 'length' => 4, 'required' => true, 'default' => 0, 'comment' => '是否删除',],
            ],
            'primary' => ['id'],
            'index' => [
                'idx_book_id' => ['columns' => ['book_id']],
            ],
        ],

        /* 8. 周期账单 */
        'bk_recurring_bill' => [
            'table_name' => 'bk_recurring_bill',
            'comment' => '分期/定期收入或支出',
            'engine' => 'InnoDB',
            'charset' => 'utf8mb4',
            'collate' => 'utf8mb4_general_ci',
            'columns' => [
                'id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'autoincrement' => true, 'comment' => 'ID'],
                'book_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => '0', 'comment' => '账本ID'],
                'name' => ['type' => 'varchar', 'length' => 100, 'required' => true, 'default' => '', 'comment' => '名称'],
                'type' => ['type' => 'TINYINT', 'length' => 4, 'required' => true, 'default' => 1, 'comment' => '交易类型，1=收入，-1=支出，0=转账'],
                'amount' => ['type' => 'decimal', 'length' => '15,2', 'required' => true, 'default' => '0', 'comment' => '金额'],
                'category_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => '0', 'comment' => '分类ID'],
                'account_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => '0', 'comment' => '账户ID'],
                'frequency' => ['type' => 'TINYINT', 'length' => 4, 'required' => true, 'default' => 0, 'comment' => '频率,1=daily,2=weekly,3=monthly,4=quarterly,5=yearly'],
                'start_date' => ['type' => 'date', 'required' => false, 'comment' => '开始日期'],
                'end_date' => ['type' => 'date', 'required' => false, 'comment' => '结束日期'],
                'next_due_date' => ['type' => 'date', 'required' => false, 'comment' => '下次生成日期'],

                'member_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => 0, 'comment' => '用户ID'],
                'create_time' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '创建日期',],
                'update_time' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '更新日期',],
                'org_id' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 1, 'comment' => '企业编号',],
                'ten_tenant_id' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '租户id',],
                'is_delete' => ['type' => 'TINYINT', 'length' => 4, 'required' => true, 'default' => 0, 'comment' => '是否删除',],

            ],
            'primary' => ['id'],
            'index' => [
                'idx_book_id' => ['columns' => ['book_id']],
            ],
        ],

        /* 9. 债务表 */
        'bk_debt' => [
            'table_name' => 'bk_debt',
            'comment' => '借入/借出债务',
            'engine' => 'InnoDB',
            'charset' => 'utf8mb4',
            'collate' => 'utf8mb4_general_ci',
            'columns' => [
                'id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'autoincrement' => true, 'comment' => 'ID'],
                'book_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => '0', 'comment' => '账本ID'],
                'type' => ['type' => 'TINYINT', 'length' => 4, 'required' => true, 'default' => 0, 'comment' => '借出/借入,1=借入，-1=借出'],
                'contact_name' => ['type' => 'varchar', 'length' => 100, 'required' => true, 'default' => '', 'comment' => '对方姓名'],
                'amount' => ['type' => 'decimal', 'length' => '15,2', 'required' => true, 'default' => '0', 'comment' => '总金额'],
                'repaid_amount' => ['type' => 'decimal', 'length' => '15,2', 'required' => true, 'default' => 0, 'comment' => '已还金额'],
                'interest_rate' => ['type' => 'decimal', 'length' => '5,2', 'required' => true, 'default' => 0, 'comment' => '年利率%'],
                'due_date' => ['type' => 'date', 'required' => false, 'comment' => '约定还款日'],
                'status' => ['type' => 'TINYINT', 'length' => 4, 'required' => true, 'default' => 0, 'comment' => '状态,0=pending,1=partial,2=completed,3=overdue'],

                'member_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => 0, 'comment' => '用户ID'],
                'create_time' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '创建日期',],
                'update_time' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '更新日期',],
                'org_id' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 1, 'comment' => '企业编号',],
                'ten_tenant_id' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '租户id',],
                'is_delete' => ['type' => 'TINYINT', 'length' => 4, 'required' => true, 'default' => 0, 'comment' => '是否删除',],
            ],
            'primary' => ['id'],
            'index' => [
                'idx_book_id' => ['columns' => ['book_id']],
            ],
        ],

        /* 10. 报销记录 */
        'bk_reimb' => [
            'table_name' => 'bk_reimb',
            'comment' => '报销状态跟踪',
            'engine' => 'InnoDB',
            'charset' => 'utf8mb4',
            'collate' => 'utf8mb4_general_ci',
            'columns' => [
                'id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'autoincrement' => true, 'comment' => 'ID'],
                'transaction_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => '0', 'comment' => '关联交易ID'],
                'status' => ['type' => 'TINYINT', 'length' => 4, 'required' => true, 'default' => 0, 'comment' => '报销状态，0=待处理，1=处理中，2=报销完成'],
                'reimbursed_time' => ['type' => 'datetime', 'required' => false, 'comment' => '报销完成时间'],
                'amount' => ['type' => 'decimal', 'length' => '15,2', 'required' => true, 'default' => '0', 'comment' => '报销金额'],

                'member_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => 0, 'comment' => '用户ID'],
                'create_time' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '创建日期',],
                'update_time' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '更新日期',],
                'org_id' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 1, 'comment' => '企业编号',],
                'ten_tenant_id' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '租户id',],
                'is_delete' => ['type' => 'TINYINT', 'length' => 4, 'required' => true, 'default' => 0, 'comment' => '是否删除',],
            ],
            'primary' => ['id'],
            'index' => [
                'idx_memeber_id' => ['columns' => ['member_id']],
                'idx_transaction_id' => ['columns' => ['transaction_id']],
            ],
        ],

        /* 11. 预算表 */
        'bk_budget' => [
            'table_name' => 'bk_budget',
            'comment' => '分类/总预算',
            'engine' => 'InnoDB',
            'charset' => 'utf8mb4',
            'collate' => 'utf8mb4_general_ci',
            'columns' => [
                'id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'autoincrement' => true, 'comment' => 'ID'],
                'book_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => '0', 'comment' => '账本ID'],
                'amount' => ['type' => 'decimal', 'length' => '15,2', 'required' => true, 'default' => '0', 'comment' => '预算金额'],
                'budget_type' => ['type' => 'TINYINT', 'length' => 4, 'required' => true, 'default' => 0, 'comment' => '预算类型,0=总预算,1=分类预算'],
                'category_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => '0', 'comment' => '分类ID(NULL=总预算)'],
                'period_type' => ['type' => 'ENUM', 'length' => "'week','year','qutar','month'", 'required' => true, 'default' => 'month', 'comment' => '预算周期,1=月,2=年'],
                'start_date' => ['type' => 'date', 'required' => false, 'comment' => '开始日期'],
                'end_date' => ['type' => 'date', 'required' => false, 'comment' => '结束日期'],

                'member_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => 0, 'comment' => '用户ID'],
                'create_time' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '创建日期',],
                'update_time' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '更新日期',],
                'org_id' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 1, 'comment' => '企业编号',],
                'ten_tenant_id' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '租户id',],
                'is_delete' => ['type' => 'TINYINT', 'length' => 4, 'required' => true, 'default' => 0, 'comment' => '是否删除',],
            ],
            'primary' => ['id'],
            'index' => [
                'idx_book_id' => ['columns' => ['book_id']],
            ],
        ],

        /* 12. 汇率表 */
        'bk_exchange_rate' => [
            'table_name' => 'bk_exchange_rate',
            'comment' => '每日汇率（对基准币）',
            'engine' => 'InnoDB',
            'charset' => 'utf8mb4',
            'collate' => 'utf8mb4_general_ci',
            'columns' => [
                'id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'autoincrement' => true, 'comment' => 'ID'],
                'currency' => ['type' => 'char', 'length' => 16, 'required' => true, 'default' => '', 'comment' => '币种'],
                'exchange_rate' => ['type' => 'decimal', 'length' => '12,6', 'required' => true, 'default' => '0', 'comment' => '汇率'],
                'date' => ['type' => 'date', 'required' => false, 'comment' => '日期'],

                'member_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => 0, 'comment' => '用户ID'],
                'create_time' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '创建日期',],
                'update_time' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '更新日期',],
                'org_id' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 1, 'comment' => '企业编号',],
                'ten_tenant_id' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '租户id',],
                'is_delete' => ['type' => 'TINYINT', 'length' => 4, 'required' => true, 'default' => 0, 'comment' => '是否删除',],
            ],
            'primary' => ['id'],
            'index' => [
                'idx_currency' => ['columns' => ['currency']],
            ],
        ],

        /* 13. 账本邀请表（可选） */
        'bk_book_invite' => [
            'table_name' => 'bk_book_invite',
            'comment' => '账本邀请链接',
            'engine' => 'InnoDB',
            'charset' => 'utf8mb4',
            'collate' => 'utf8mb4_general_ci',
            'columns' => [
                'id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'autoincrement' => true, 'comment' => 'ID'],
                'book_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => '0', 'comment' => '账本ID'],
                'inviter_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => '0', 'comment' => '邀请人'],
                'invitee_email' => ['type' => 'varchar', 'length' => 100, 'required' => true, 'default' => '0', 'comment' => '被邀请邮箱'],
                'role' => ['type' => 'TINYINT', 'length' => 4, 'required' => true, 'default' => '0', 'comment' => '角色,默认为成员,0=成员、1=创建人员、2=管理人员'],
                'token' => ['type' => 'char', 'length' => 32, 'required' => true, 'default' => '', 'comment' => '邀请令牌'],
                'expired_at' => ['type' => 'datetime', 'required' => false, 'comment' => '过期时间'],
                'used' => ['type' => 'tinyint', 'length' => 1, 'unsigned' => true, 'required' => false, 'default' => 0, 'comment' => '已使用'],

                'member_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => 0, 'comment' => '用户ID'],
                'create_time' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '创建日期',],
                'update_time' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '更新日期',],
                'org_id' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 1, 'comment' => '企业编号',],
                'ten_tenant_id' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '租户id',],
                'is_delete' => ['type' => 'TINYINT', 'length' => 4, 'required' => true, 'default' => 0, 'comment' => '是否删除',],
            ],
            'primary' => ['id'],
            'index' => [
                'idx_book_id' => ['columns' => ['book_id']],
                'idx_token' => ['unique' => true, 'columns' => ['token']],
            ],
        ],


        /* 14. 商家表 */
        'bk_shop' => [
            'table_name' => 'bk_shop',
            'comment' => '[记账]商家表',
            'engine' => 'InnoDB',
            'charset' => 'utf8mb4',
            'collate' => 'utf8mb4_general_ci',
            'columns' => [
                'id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'autoincrement' => true, 'comment' => '主键ID'],
                'book_id' => ['type' => 'bigint', 'length' => 20, 'required' => true, 'default' => '0', 'comment' => '账本ID'],
                'name' => ['type' => 'varchar', 'length' => 100, 'required' => true, 'default' => '', 'comment' => '商家名称'],
                'remark' => ['type' => 'text', 'required' => false, 'comment' => '账本描述'],

                'visible' => ['type' => 'tinyint', 'length' => 1, 'unsigned' => true, 'required' => false, 'default' => 0, 'comment' => '1=隐藏'],
                'sort' => ['type' => 'tinyint', 'length' => 1, 'unsigned' => true, 'required' => false, 'default' => 0, 'comment' => '排序'],
                'is_default' => ['type' => 'tinyint', 'length' => 1, 'unsigned' => true, 'required' => false, 'default' => 0, 'comment' => '是否默认，0=否、1=是'],

                'member_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => 0, 'comment' => '用户ID'],
                'create_time' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '创建日期',],
                'update_time' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '更新日期',],
                'org_id' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 1, 'comment' => '企业编号',],
                'ten_tenant_id' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '租户id',],
                'is_delete' => ['type' => 'TINYINT', 'length' => 4, 'required' => true, 'default' => 0, 'comment' => '是否删除',],
            ],
            'primary' => ['id'],
            'index' => [],
        ],

        /* 14. 项目表 */
        'bk_project' => [
            'table_name' => 'bk_project',
            'comment' => '[记账]项目表',
            'engine' => 'InnoDB',
            'charset' => 'utf8mb4',
            'collate' => 'utf8mb4_general_ci',
            'columns' => [
                'id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'autoincrement' => true, 'comment' => '主键ID'],
                'book_id' => ['type' => 'bigint', 'length' => 20, 'required' => true, 'default' => '0', 'comment' => '账本ID'],
                'name' => ['type' => 'varchar', 'length' => 100, 'required' => true, 'default' => '', 'comment' => '商家名称'],
                'remark' => ['type' => 'text', 'required' => false, 'comment' => '描述'],

                'visible' => ['type' => 'tinyint', 'length' => 1, 'unsigned' => true, 'required' => false, 'default' => 0, 'comment' => '1=隐藏'],
                'sort' => ['type' => 'tinyint', 'length' => 1, 'unsigned' => true, 'required' => false, 'default' => 0, 'comment' => '排序'],
                'is_default' => ['type' => 'tinyint', 'length' => 1, 'unsigned' => true, 'required' => false, 'default' => 0, 'comment' => '是否默认，0=否、1=是'],

                'member_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => 0, 'comment' => '用户ID'],
                'create_time' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '创建日期',],
                'update_time' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '更新日期',],
                'org_id' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 1, 'comment' => '企业编号',],
                'ten_tenant_id' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '租户id',],
                'is_delete' => ['type' => 'TINYINT', 'length' => 4, 'required' => true, 'default' => 0, 'comment' => '是否删除',],
            ],
            'primary' => ['id'],
            'index' => [],
        ],

        /* 14. 项目表 */
        'bk_person' => [
            'table_name' => 'bk_person',
            'comment' => '[记账]人员表',
            'engine' => 'InnoDB',
            'charset' => 'utf8mb4',
            'collate' => 'utf8mb4_general_ci',
            'columns' => [
                'id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'autoincrement' => true, 'comment' => '主键ID'],
                'book_id' => ['type' => 'bigint', 'length' => 20, 'required' => true, 'default' => '0', 'comment' => '账本ID'],
                'member_id' => ['type' => 'bigint', 'length' => 20, 'unsigned' => true, 'required' => true, 'default' => 0, 'comment' => '绑定的用户ID'],
                'name' => ['type' => 'varchar', 'length' => 100, 'required' => true, 'default' => '', 'comment' => '人员名称'],
                'phone' => ['type' => 'varchar', 'length' => 100, 'required' => true, 'default' => '', 'comment' => '电话'],
                'email' => ['type' => 'varchar', 'length' => 100, 'required' => true, 'default' => '', 'comment' => '邮箱'],
                'remark' => ['type' => 'text', 'required' => false, 'comment' => '描述'],
                'sort' => ['type' => 'tinyint', 'length' => 1, 'unsigned' => true, 'required' => false, 'default' => 0, 'comment' => '排序'],
                'create_time' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '创建日期',],
                'update_time' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '更新日期',],
                'org_id' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 1, 'comment' => '企业编号',],
                'ten_tenant_id' => ['type' => 'int', 'length' => 16, 'required' => true, 'default' => 0, 'comment' => '租户id',],
                'is_delete' => ['type' => 'TINYINT', 'length' => 4, 'required' => true, 'default' => 0, 'comment' => '是否删除',],
            ],
            'primary' => ['id'],
            'index' => [],
        ],

        //表结构结束 ********************************************************************************************************

    ],//end tables;

];