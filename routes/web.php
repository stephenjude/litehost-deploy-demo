<?php

use App\Jobs\Ping;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('status', [
        'build' => trim(@file_get_contents(base_path('BUILD')) ?: 'dev'),
        'lastJob' => Cache::get('last_job', 'never'),
        'jobsDone' => Cache::get('jobs_done', 0),
        'lastTick' => Cache::get('last_tick', 'never'),
        'server' => php_sapi_name(),
    ]);
});

Route::get('/ping', function () {
    Ping::dispatch();
    return redirect('/');
});
