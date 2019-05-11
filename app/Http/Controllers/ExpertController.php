<?php

namespace App\Http\Controllers;
use App\Expert;

use Illuminate\Http\Request;

class ExpertController extends Controller
{
    public function get()
    {
        return response()->json(Expert::all());
    }
}
