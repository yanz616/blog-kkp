import { Context, Hono } from 'hono'
import { cors } from 'hono/cors'
import auth from './routes/auth.route.js'
import posts from './routes/posts.route.js';
import comments from './routes/comments.route.js';
import users from './routes/users.route.js';

const app = new Hono()
    .use(
        "*", cors({
            origin: "*",
            credentials: true,
            allowMethods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"],
            allowHeaders: ["Content-Type", "Authorization"],
        })
    )
    .get("/", (c: Context) => c.text("Blog KKP Backend, Dibuat dengan Hono + Typscript + DrizleORM"))
    .route("/api", auth)
    .route("/api", posts)
    .route("/api", comments)
    .route("/api", users)

export default {
    port: 3000,
    hostname: "0.0.0.0",
    fetch: app.fetch,
};
