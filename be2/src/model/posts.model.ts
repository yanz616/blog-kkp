import { desc, eq } from "drizzle-orm";
import { db } from "../database/index.js";
import { posts, users } from "../database/schema.js";
import { CreatePostsRequest, UpdatePostsRequest } from "../lib/dto/posts.js";

export class PostsModel {
    static async create({ title, content, authorId, image, imageId }: CreatePostsRequest) {
        const result = await db.insert(posts).values({
            title,
            content,
            image,
            imageId,
            authorId,
        }).returning();
        return result[0];
    }

    static async update({ id, title, authorId, content, image, imageId, }: UpdatePostsRequest) {
        const result = await db.update(posts).set({
            title,
            image,
            authorId,
            content,
            imageId,
            updatedAt: new Date(),
        }).where(eq(posts.id, id)).returning();
        return result[0] || null;
    }

    static async getAll() {
        return await db.select().from(posts).orderBy(desc(posts.createdAt));
    }
    static async getById(id: number) {
        const result = await db
            .select({
                id: posts.id,
                title: posts.title,
                content: posts.content,
                image: posts.image,
                imageId: posts.imageId,
                createdAt: posts.createdAt,
                author: {
                    id: users.id,
                    username: users.username,
                    email: users.email,
                },
            })
            .from(posts)
            .leftJoin(users, eq(posts.authorId, users.id))
            .where(eq(posts.id, id));
        return result[0] || null;
    }


    static async getByAuthorId(authorId: number) {
        const result = await db
            .select({
                id: posts.id,
                title: posts.title,
                content: posts.content,
                image: posts.image,
                imageId: posts.imageId,
                createdAt: posts.createdAt,
                author: {
                    id: users.id,
                    username: users.username,
                    email: users.email,
                },
            })
            .from(posts)
            .leftJoin(users, eq(posts.authorId, users.id))
            .where(eq(posts.authorId, authorId));
        return result;
    }

    static async delete(id: number) {
        const result = await db.delete(posts).where(eq(posts.id, id)).returning();
        return result[0] || null
    }
}
