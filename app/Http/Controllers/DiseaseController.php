<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Disease;

class DiseaseController extends Controller
{
    public function all()
    {
        return response()->json(Disease::all());
    }

    public function add(Request $request)
    {
        // dd($request);
        Disease::create([
            'name' => $request->name,
            'symptom' => $request->symptom,
            'description' => json_encode($request->description)
        ]);
        return response(['disease' => 'created']);
    }

    public function update(Request $request, $id)
    {
        Disease::find($id)->update([
            'name' => $request->name,
            'symptom' => $request->symptom,
            'description' => json_encode($request->description)
        ]);
        return response(['disease' => 'updated']);
    }
}
