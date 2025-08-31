import { eq } from "drizzle-orm";
import { db } from "../database/index.js";
import { posts } from "../database/schema.js";


export class PostModel {
    static async create(title: string, content: string, authorId: number, image?: string) {
        const result = await db.insert(posts).values({
            title,
            content,
            image,
            authorId,
        }).returning();
        return result[0];
    }

    static async getAll() {
        return await db.select().from(posts);
    }

    static async getById(id: number) {
        const result = await db.select().from(posts).where(eq(posts.id, id));
        return result[0] || null;
    }

    static async delete(id: number) {
        const result = await db.delete(posts).where(eq(posts.id, id)).returning();
        return result[0] || null
}
