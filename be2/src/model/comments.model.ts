import { eq } from "drizzle-orm";
import { db } from "../database/index.js";
import { comments } from "../database/schema.js";


export class CommentModel {
    static async create(content: string, postId: number, userId: number) {
        const result = await db.insert(comments).values({
            content,
            postId,
            userId,
        }).returning();
        return result[0];
    }

    static async getByPost(postId: number) {
        return await db.select().from(comments).where(eq(comments.postId, postId));
    }

    static async delete(id: number) {
        const result = await db.delete(comments).where(eq(comments.id, id)).returning();
        return result[0] || null;
    }
}
