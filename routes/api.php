<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::auth();

Route::group([
    'middleware' => 'api',
    'prefix' => 'auth'
], function ($router) {
    Route::post('login', 'AuthController@login');
    Route::post('logout', 'AuthController@logout');
    Route::post('refresh', 'AuthController@refresh');
    Route::post('me', 'AuthController@me');
});

Route::group([
    'middleware' => 'api'
], function ($router) {
    Route::get('user/{id}', 'UserController@show');
    Route::get('admin', 'UserController@getAdmins');
    Route::get('expert', 'UserController@getExperts');
    Route::get('customer', 'UserController@getCustomers');
    Route::get('users', 'UserController@users');
    Route::get('user/activate/{id}', 'UserController@activate');
    Route::get('user/deactivate/{id}', 'UserController@deactivate');

    Route::get('/diseases', 'DiseaseController@all');
    Route::post('/disease', 'DiseaseController@add');
    Route::patch('/disease/{id}', 'DiseaseController@update');
    Route::delete('/disease/{id}', 'DiseaseController@destroy');

    Route::get('/firstAid', 'FirstAidController@index');
    Route::post('/firstAid', 'FirstAidController@store');
    Route::patch('/firstAid/{id}', 'FirstAidController@update');
    Route::delete('/firstAid/{id}', 'FirstAidController@destroy');

    Route::get('/blog', 'BlogController@index');
    Route::post('/blog', 'BlogController@store');
    Route::get('/blog/{id}', 'BlogController@show');
    Route::delete('/blog/{id}', 'BlogController@destroy');
    Route::post('/comment', 'CommentController@store');
    Route::delete('/comment/{id}', 'CommentController@destroy');


    Route::get('/messages/{id}', 'MessageController@messages');
    Route::get('/conversation/{from}/{to}', 'MessageController@getConversation');
    Route::post('/message/send', 'MessageController@send');
});