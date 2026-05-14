<?php
declare(strict_types=1);

namespace App\Pay\Epay\Impl;

use App\Entity\PayEntity;
use App\Pay\Base;

class Pay extends Base implements \App\Pay\Pay
{
    public function trade(): PayEntity
    {
        $gateway = rtrim((string)($this->config['gateway'] ?? ''), '/');
        $pid = trim((string)($this->config['pid'] ?? ''));
        $key = trim((string)($this->config['key'] ?? ''));

        if ($gateway === '' || $pid === '' || $key === '') {
            throw new \RuntimeException('易支付插件未配置网关、商户ID或商户密钥');
        }

        $params = [
            'pid' => $pid,
            'type' => $this->code,
            'out_trade_no' => $this->tradeNo,
            'notify_url' => $this->callbackUrl,
            'return_url' => $this->returnUrl,
            'name' => '悉檀AI订单-' . $this->tradeNo,
            'money' => number_format($this->amount, 2, '.', ''),
            'sitename' => (string)($this->config['sitename'] ?? '悉檀AI'),
        ];

        $params['sign'] = self::sign($params, $key);
        $params['sign_type'] = 'MD5';

        $entity = new PayEntity();
        $entity->setType(\App\Pay\Pay::TYPE_SUBMIT);
        $entity->setUrl($gateway . '/submit.php');
        $entity->setOption($params);

        $this->log('创建易支付订单：' . $this->tradeNo);

        return $entity;
    }

    public static function sign(array $params, string $key): string
    {
        unset($params['sign'], $params['sign_type']);
        foreach ($params as $name => $value) {
            if ($value === '' || $value === null) {
                unset($params[$name]);
            }
        }
        ksort($params);

        $pairs = [];
        foreach ($params as $name => $value) {
            $pairs[] = $name . '=' . $value;
        }

        return md5(implode('&', $pairs) . $key);
    }
}
