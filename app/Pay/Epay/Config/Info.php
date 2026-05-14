<?php
declare(strict_types=1);

use App\Consts\Pay;

return [
    'name' => '易支付',
    'version' => '1.0.0',
    'author' => '悉檀AI',
    'description' => '兼容易支付 V1 submit.php 页面跳转接口，支持 MD5 签名回调。',
    'options' => [
        'alipay' => '支付宝',
        'wxpay' => '微信支付',
        'qqpay' => 'QQ钱包',
    ],
    'callback' => [
        Pay::IS_SIGN => true,
        Pay::IS_STATUS => true,
        Pay::FIELD_STATUS_KEY => 'trade_status',
        Pay::FIELD_STATUS_VALUE => 'TRADE_SUCCESS',
        Pay::FIELD_ORDER_KEY => 'out_trade_no',
        Pay::FIELD_AMOUNT_KEY => 'money',
        Pay::FIELD_RESPONSE => 'success',
    ],
];
