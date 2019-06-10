<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\User;

class UserController extends Controller
{

    public function __construct()
    {
        // $this->middleware('auth:api');
    }

    public function getAdmins()
    {
        return response()->json(User::where('role', 'admin')->get());
    }

    public function getExperts()
    {
        return response()->json(User::all());
    }

    public function getCustomers()
    {
        return response()->json(User::with('customer')->where('role', 'customer')->get());
    }

    public function show($id)
    {
        return response()->json(User::find($id));
    }

    public function users()
    {
        return response()->json(User::all());
    }

    public function activate($id) {
        User::find($id)->update(['active' => 1]);
        return response(['activate' => true]);
    }

    public function deactivate($id) {
        User::find($id)->update(['active' => 0]);
        return response(['activate' => true]);
    }
}
