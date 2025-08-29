import { boolean, pgTable, serial, text, timestamp, varchar } from "drizzle-orm/pg-core";


export const users = pgTable("users", {
    id: serial("id").primaryKey(),
    username: varchar("username", { length: 50 }).notNull(),
    avatar: text("avatar"),
    email: varchar("email", { length: 100 }).notNull().unique(),
    password: varchar("password", { length: 255 }).notNull(),
    isAdmin: boolean().default(false),
    createdAt: timestamp("created_at").defaultNow(),
    updatedAt: timestamp("updated_at").defaultNow(),
});
