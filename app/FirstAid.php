<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class FirstAid extends Model
{
    protected $guarded = [];

    public function disease() {
        return $this->belongsTo('App\Disease');
    }
}
