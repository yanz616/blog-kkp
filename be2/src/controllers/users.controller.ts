import { Context } from "hono";
import { ResFormmater } from "../lib/utils/response.js";
import { UserModel } from "../model/users.model.js";
import { UploadResponse } from "../database/supabase/type.js";
import { SupabaseDelete } from "../database/supabase/index.js";
import { AssetActions } from "../database/supabase/upload.js";
import { UpdateUsersRequest } from "../lib/dto/users.js";
import { UserPayloadData } from "../lib/dto/auth.js";

export class UserController {
    static async update(c: Context) {
        try {
            const id = Number(c.req.param("id"));
            const formData = await c.req.formData();
            const username = formData.get("username") as string;
            const avatar = formData.get("avatar") as File;

            if (!id) return c.json(ResFormmater.failed("User id harus ada", 400), 400);
            if (!username && !avatar) return c.json(ResFormmater.failed("Harus update setidaknya 1 data"), 400);

            const record = await UserModel.findById(id);
            if (!record) return c.json(ResFormmater.failed("User tidak ditemukan", 404), 404);

            let imageUrl: UploadResponse | undefined;
            if (avatar) {
                await SupabaseDelete(record.avatarId!)
                const imageBuffer = Buffer.from(await avatar.arrayBuffer());
                imageUrl = await AssetActions.UploadUserAvatar(imageBuffer);
            }

            const data: UpdateUsersRequest = {
                id,
                username: username || record.username,
                avatar: imageUrl?.url || record.avatar!,
                avatarId: imageUrl?.assetId || record.avatarId!,
            }

            const user = await UserModel.update(data);
            if (!user) return c.json(ResFormmater.failed("User tidak ditemukan"), 404);

            return c.json(ResFormmater.success(user, "Berhasil Mengupdate User", 200), 200);
        } catch (err) {
            return c.json(ResFormmater.failed("Server Error" + err, 500), 500);
        }
    }

    static async getById(c: Context) {
        try {
            const id = Number(c.req.param("id"));
            const response = await UserModel.findById(id);
            if (!response) return c.json(ResFormmater.failed("User tidak ditemukan", 404), 404);
            return c.json(ResFormmater.success(response, "Berhasil mendapatkan user berdasarkan id"), 200);
        } catch (err) {
            return c.json(ResFormmater.failed("Server Error" + err, 500), 500);
        }
    }

    static async delete(c: Context) {
        try {
            const userRole = c.get("user") as UserPayloadData
            if (!userRole.isAdmin) return c.json(ResFormmater.failed("Hanya admin yang bisa hapus", 400), 400)
            const id = Number(c.req.param("id"));
            if (!id) return c.json(ResFormmater.failed("id tidak ditemukan"))

            const response = await UserModel.delete(id)
            if (!response) return c.json(ResFormmater.failed("user tidak ditemukan", 404), 404)

            return c.json(ResFormmater.success(response, "Berhasil menghapus data user", 200), 200)
        } catch (err) {
            return c.json(ResFormmater.failed("Server Error" + err, 500), 500);
        }
    }
}
