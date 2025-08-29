import { Context, Hono } from 'hono'
import { cors } from 'hono/cors'
import auth from './routes/auth.route.js'

const app = new Hono()
    .use(
        "*", cors({
            origin: "*",
            credentials: true,
            allowMethods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"],
            allowHeaders: ["Content-Type", "Authorization"],
        })
    )

    .get("/", (c: Context) => c.text("Hallo world"))
    .route("/api", auth)
export default app
