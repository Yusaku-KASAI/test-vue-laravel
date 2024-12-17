<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/api/example/text', function () {
    return 'Hello World!';
});

Route::get('/api/example/json', function () {
    return response()->json([
        'message' => 'test',
        'path' => '/api/json'
    ]);
});
