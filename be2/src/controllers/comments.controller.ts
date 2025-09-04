import { Context } from "hono";
import { UserPayloadData } from "../lib/dto/auth.js";
import { ResFormmater } from "../lib/utils/response.js";
import { CreateCommentsRequest } from "../lib/dto/comments.js";
import { CommentModel } from "../model/comments.model.js";

export class CommentsController {
    static async create(c: Context) {
        try {
            const userAuth = c.get("user") as UserPayloadData
            if (!userAuth) return c.json(ResFormmater.failed("Uanuthorization"), 404)
            const formData = await c.req.formData();
            const content = formData.get("content") as string;
            const postId = formData.get("post_id") as string;
            if (!content || !postId) return c.json(ResFormmater.failed("content dan post id harus diisi"), 400);
            const data: CreateCommentsRequest = {
                content,
                postId: Number(postId),
                authorId: userAuth.userId,
            };
            const response = await CommentModel.create(data)
            return c.json(ResFormmater.success(response, "Create posts successfully", 201), 201);
        } catch (err) {
            return c.json(ResFormmater.failed("Server Error" + err, 500), 500);
        }
    }
    static async getByPost(c: Context) {
        try {
            const postId = Number(c.req.param("id"));
            if (!postId) return c.json(ResFormmater.failed("Komentar tidak ditemukan"), 404)
            const response = await CommentModel.getByPost(Number(postId))
            return c.json(ResFormmater.success(response, "Berhasil mendapatkan komentar", 200), 200)
        } catch (err) {
            return c.json(ResFormmater.failed("Server Error" + err, 500), 500);
        }
    }
}
