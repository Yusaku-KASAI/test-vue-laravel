<?php

use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Log;

Route::get('/users/{id}', function (string $id) {
    $user = User::find($id);
    return ['id' => $user->id, 'name' => $user->name, 'email' => $user->email];
})->middleware('auth:sanctum');
Route::get('/me', function () {
    $user = Auth::user();
    return ['id' => $user->id, 'name' => $user->name, 'email' => $user->email];
})->middleware('auth:sanctum');

Route::post('/users', function (Request $request) {
    $user = User::create([
        'name' => $request->input('name'),
        'email' => $request->input('email'),
        'password' => Hash::make($request->input('password')),
    ]);
    return ['id' => $user->id, 'name' => $user->name, 'email' => $user->email];
});

Route::post('/tokens', function (Request $request) {
    $user = User::find($request->input('id'));
    Log::info(print_r($user, true));
    if (!Hash::check($request->input('password'), $user->password)) {
        return response()->json([], 403);
    }
    $token = $user->createToken('auth-default');
    return response()->json(['token' => $token->plainTextToken], 201);
});
