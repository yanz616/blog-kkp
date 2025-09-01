import { Context } from "hono";
import bcrypt from "bcryptjs";
import { sign } from "hono/jwt";
import { JWTPayload } from "hono/utils/jwt/types";
import { AuthModel } from "../model/auth.model.js";
import { ResFormmater } from "../lib/utils/response.js";
import { LoginRequest, LoginResponse, RegisterRequest, RegisterResponse } from "../lib/dto/auth.js";

const JWT_SECRET = process.env.JWT_SECRET;
export class AuthController {
    static async register(c: Context) {
        const { username, email, password } = await c.req.json<RegisterRequest>();
        if (!username || !email || !password) return c.json(ResFormmater.failed("Username, Email dan password wajib diisi", 400), 400);
        const hashPw = await bcrypt.hash(password, 10)
        const user = await AuthModel.register(username, email, hashPw);
        const response: RegisterResponse = {
            id: user.id,
            username: user.username,
            email: user.email,
            avatar: user.avatar ?? "",
            createdAt: String(user.createdAt)

        }
        return c.json(ResFormmater.success(response, "User registered", 201), 201);

    }

    static async login(c: Context) {
        const { email, password } = await c.req.json<LoginRequest>();
        if (!email || !password) return c.json(ResFormmater.failed("Email dan password wajib diisi", 400), 400);
        const user = await AuthModel.login(email);
        if (!user) return c.json(ResFormmater.failed("Tidak dapat menemukan akun dengan email tersebut. Silakan periksa kembali", 401), 401);
        const valid = await bcrypt.compare(password, user.password);
        if (!valid) return c.json(ResFormmater.failed("Kata sandi yang Anda masukkan tidak sesuai. Silakan coba lagi.", 401), 401);

        const payload: JWTPayload = {
            userId: user.id,
            username: user.username,
            email: user.email,
            exp: Math.floor(Date.now() / 1000) + 60 * 60 * 24
        }
        const token: string = await sign(
            payload,
            JWT_SECRET!,
            "HS256"
        );

        const response: LoginResponse = {
            id: user.id,
            username: user.username,
            avatar: user.avatar ?? "",
            email: user.email,
            token: token,
            createdAt: String(user.createdAt),
            updatedAt: String(user.updatedAt)
        }
        return c.json(ResFormmater.success(response, "Login berhasil"), 200);
    }
}
