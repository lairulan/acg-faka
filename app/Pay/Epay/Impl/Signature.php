<?php
declare(strict_types=1);

namespace App\Pay\Epay\Impl;

class Signature implements \App\Pay\Signature
{
    public function verification(array $data, array $config): bool
    {
        $key = trim((string)($config['key'] ?? ''));
        $sign = strtolower(trim((string)($data['sign'] ?? '')));

        if ($key === '' || $sign === '') {
            return false;
        }

        return hash_equals($sign, Pay::sign($data, $key));
    }
}
