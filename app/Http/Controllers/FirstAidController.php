<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\FirstAid;

class FirstAidController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return response()->json(FirstAid::with('disease')->get());
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        FirstAid::create([
            'symptom' => $request->symptom,
            'description' => json_encode($request->description),
            'disease_id' => $request->disease_id
        ]);
        return response(['firstAid' => 'created']);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        FirstAid::find($id)->update([
            'symptom' => $request->symptom,
            'description' => json_encode($request->description),
            'disease_id' => $request->disease_id
        ]);
        return response(['firstAid' => 'updated']);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        FirstAid::find($id)->delete();
        return response()->json(['firstaid'=> 'deleted']);
    }
}
