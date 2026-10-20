<?php

use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Schedule;

Schedule::call(fn () => Cache::put('last_tick', now()->toDateTimeString()))->everyMinute()->name('heartbeat');
