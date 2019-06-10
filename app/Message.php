<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Message extends Model
{
    protected $guarded = [];

    public function sender()
    {
        return $this->belongsTo('\App\User', 'from');
    }

    public function recipient()
    {
        return $this->belongsTo('\App\User', 'to');
    }
}
