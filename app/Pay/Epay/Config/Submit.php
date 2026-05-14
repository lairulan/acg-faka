<?php
declare(strict_types=1);

return [
    [
        'title' => '网关地址',
        'name' => 'gateway',
        'type' => 'input',
        'placeholder' => '例如：https://pay.example.com',
        'required' => true,
    ],
    [
        'title' => '商户ID',
        'name' => 'pid',
        'type' => 'input',
        'placeholder' => '易支付商户 PID',
        'required' => true,
    ],
    [
        'title' => '商户密钥',
        'name' => 'key',
        'type' => 'input',
        'placeholder' => '易支付商户 KEY',
        'required' => true,
    ],
    [
        'title' => '站点名称',
        'name' => 'sitename',
        'type' => 'input',
        'placeholder' => '悉檀AI',
    ],
];
