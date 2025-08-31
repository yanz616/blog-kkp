import { eq } from "drizzle-orm";
import { db } from "../database/index.js";
import { users } from "../database/schema.js";

export class UserModel {
    static async create(username: string, email: string, password: string, avatar?: string) {
        const result = await db.insert(users).values({
            username,
            email,
            password,
            avatar,
        }).returning();
        return result[0];
    }

    static async findByEmail(email: string) {
        const result = await db.select().from(users).where(eq(users.email, email));
        return result[0] || null;
    }

    static async findById(id: number) {
        const result = await db.select().from(users).where(eq(users.id, id));
        return result[0] || null;
    }
}
