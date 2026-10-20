<?php

namespace App\Jobs;

use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Queue\Queueable;
use Illuminate\Support\Facades\Cache;

class Ping implements ShouldQueue
{
    use Queueable;

    public function handle(): void
    {
        Cache::put('last_job', now()->toDateTimeString());
        Cache::increment('jobs_done');
    }
}
