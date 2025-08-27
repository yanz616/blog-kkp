<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\ValidationException;
use Illuminate\Support\Facades\Validator;
use App\Helpers\ApiResponse;

class AuthController extends Controller
{
    public function register(Request $request){
        $validator = Validator::make($request->all(),[
            'name'=>'required|min:3|max:10',
            'email'=>'required|email|unique:users',
            'password'=>'required|min:6|confirmed',
        ],
        [
            'name.required' => 'Name Tidak Boleh Kosong',
            'name.min' => 'Nama Minimal 3 Karakter',
            'name.max' => 'Nama Maksimal 10 Karakter',

            'email.required' => 'Email Tidak Boleh Kosong',
            'email.email' => 'Format Email Tidak Valid',
            'email.unique' => 'Email Sudah Terdaftar',

            'password.required' => 'Password Tidak Boleh Kosong',
            'password.min' => 'Password Minimal 6 Karakter',
            'password.confirmed' => 'Konfirmasi Password Tidak Cocok'
        ]);

        if($validator->fails()){
            return ApiResponse::error(
                "Validasi Gagal",// message
                $validator->errors(),// error
                422 //status code
            );
        }

        $user = User::Create([
            'name'=>$request->name,
            'email'=>$request->email,
            'password'=>bcrypt($request->password),
            'is_admin'=>false
        ]);

        return ApiResponse::success(
            "Registerasi Berhasil",
            $user,
            201
        );
    }

    public function login(Request $request){
        $validator = Validator::make($request->all(),[
            'email'=>'required|email',
            'password'=>'required|min:6',
        ],
        [
            'email.required' => 'Email Tidak Boleh Kosong',
            'email.email' => 'Format Email Tidak Valid',
            'password.required' => 'Password Tidak Boleh Kosong',
            'password.min' => 'Password Minimal 6 Karakter',
        ]);

        if($validator->fails()){
            return ApiResponse::error(
                "Validasi Gagal",
                $validator->errors(),
                422
            );
        }
        
        $user = User::where('email',$request->email)->first();
        if(!$user || !Hash::check($request->password, $user->password)){
            return ApiResponse::error(
                "Login Gagal",
                ['email'=>['Email atau Password Salah']],
                401
            );
        }

        $token = $user->createToken('token')->plainTextToken;
        

        return ApiResponse::success(
            "Login Berhasil",
            [
                'token' => $token,
                'user' => $user,
            ],
            200
            );
    }

    public function logout(Request $request){ 
        $request->user()->currentAccessToken()->delete();

        return ApiResponse::success(
            "Logout Berhasil",
            "",
            200
        );
    }

    public function me(Request $request){
        return ApiResponse::success(
            "Profile Loaded", // message
            $request->user(), // data
            200 // status code
        );
    }

    public function update(Request $request){
        $user = Auth::user();

        $validator = Validator::make($request->all(),[
            'name'     => 'sometimes|string|min:3|max:50',
            'email'    => 'sometimes|email|unique:users,email,' . $user->id,
            'password' => 'sometimes|string|min:6|confirmed',
            'avatar'   => 'sometimes|file|image|max:2048',
        ], 
        [
            'name.min'         => 'Nama Minimal 3 Karakter',
            'name.max'         => 'Nama Maksimal 50 Karakter',
            'email.unique'     => 'Email Sudah Ada',
            'email.email'      => 'Format Email Tidak Valid',
            'password.min'     => 'Password Minimal 6 Karakter',
            'password.confirmed' => 'Konfirmasi Password Tidak Cocok',
            'avatar.image'     => 'Avatar harus berupa gambar',
            'avatar.max'       => 'Avatar maksimal 2MB',
        ]);

        if($validator->fails()){
            return ApiResponse::error(
                "Validasi gagal",   
                $validator->errors(),
                422
            );
        }
        
        $data = $validator->validated();
        
        // error jika field tidak terbaca
        if (empty($data)) {
            return ApiResponse::error("Tidak ada field yang valid", [], 422);
        }

        // Hash password jika ada
        if (isset($data['password'])) {
            $data['password'] = Hash::make($data['password']);
        }
        
        // Upload avatar jika ada
        if ($request->hasFile('avatar')) {
            $path = $request->file('avatar')->store('images', 'public');
            $data['avatar'] = $path;
        }
        

        // Update user langsung
        $user->update($data);

        return ApiResponse::success(
            "Update Berhasil",
            $user,
            202
        );
    }
}