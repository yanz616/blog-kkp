<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    public function register(Request $request){
        $request->validate([
            'name'=>'required',
            'email'=>'required|email|unique:users',
            'password'=>'required|confirmed:min:6',
        ]);

        $user = User::Create([
            'name'=>$request->name,
            'email'=>$request->email,
            'password'=>bcrypt($request->password),
            'is_admin'=>false
        ]);

        return response()->json([
            'message' => 'Register Success',
            // 'token'=>$user->createToken('token')->plainTextToken,
            'user' => $user,
        ],201);
    }

    public function login(Request $request){
        $request->validate([
            'email'=>'required',
            'password'=>'required'
        ]);
        
        $user = User::where('email',$request->email)->first();
        if(!$user || !Hash::check($request->password, $user->password)){
            throw ValidationException::withMessages([
                'email'=>'Invalid Credentials'
            ]);
        }

        return response()->json([
            'message' => 'Login Success',
            'token'=>$user->createToken('token')->plainTextToken,
            'user' => $user,
        ],201);
    }

    public function logout(Request $request){
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'message' => 'Logout Success. Token Deleted',   
        ],200);
    }
}
