<!doctype html>
<html lang="en"><head><meta charset="utf-8"><title>Laravel on Litehost</title>
<style>body{font-family:system-ui;margin:0;min-height:100vh;display:grid;place-items:center;background:#080B14;color:#F7F9FC}h1{font-size:2.4rem;margin:0 0 1rem}span{color:#FFB020}table{border-collapse:collapse}td{padding:.4rem 1rem .4rem 0;color:#7FC4FF}td+td{color:#F7F9FC}a{color:#2F6BFF}</style>
</head><body><div>
<h1>Laravel {{ app()->version() }} deployed from <span>GitHub</span></h1>
<table>
<tr><td>Build</td><td>{{ $build }}</td></tr>
<tr><td>PHP</td><td>{{ PHP_VERSION }} ({{ $server }})</td></tr>
<tr><td>Queue worker</td><td>last job {{ $lastJob }}, {{ $jobsDone }} done</td></tr>
<tr><td>Scheduler</td><td>last tick {{ $lastTick }}</td></tr>
</table>
<p><a href="/ping">Dispatch a job</a> · <a href="/horizon">Horizon</a></p>
</div></body></html>
