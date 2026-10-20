<?php
$sha = trim(@file_get_contents(__DIR__ . '/BUILD') ?: 'dev');
?>
<!doctype html>
<html lang="en"><head><meta charset="utf-8"><title>Deployed from GitHub</title>
<style>body{font-family:system-ui;margin:0;min-height:100vh;display:grid;place-items:center;background:#080B14;color:#F7F9FC}h1{font-size:2.5rem}span{color:#FFB020}code{color:#7FC4FF}</style>
</head><body><div><h1>Deployed from <span>GitHub</span></h1><p>Build <code><?= htmlspecialchars($sha) ?></code> · PHP <?= PHP_VERSION ?></p></div></body></html>
