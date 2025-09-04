import { and, eq } from "drizzle-orm";
import { db } from "../database/index.js";
import { comments } from "../database/schema.js";
import { CreateCommentsRequest, UpdateCommentsRequest } from "../lib/dto/comments.js";


export class CommentModel {
    static async create({ content, postId, authorId }: CreateCommentsRequest) {
        const result = await db.insert(comments).values({
            content,
            postId,
            authorId,
        }).returning();
        return result[0];
    }

    static async update({ id, authorId, content }: UpdateCommentsRequest) {
        const result = await db
            .update(comments)
            .set({ content, updatedAt: new Date() })
            .where(and(eq(comments.id, id), eq(comments.authorId, authorId)))
            .returning();
        return result[0] || null;
    }

    static async getByPost(postId: number) {
        return await db.select().from(comments).where(eq(comments.postId, postId));
    }


static async delete(id: number, authorId: number) {
    const result = await db
        .delete(comments)
        .where(and(eq(comments.id, id), eq(comments.authorId, authorId))) 
        .returning();
    return result[0] || null;
}

}
