import { Hono } from "hono";
import { PostsController } from "../controllers/posts.controller.js";
import { AuthMiddleware } from "../middleware/auth.middleware.js";

const app = new Hono()
    .get("/posts", PostsController.getAll)
    .get("/posts/:id", PostsController.getById)
    .use("*", AuthMiddleware)
    .post("/posts", PostsController.create)
    .delete("/posts/:id", PostsController.delete)

const posts = new Hono().route("/v1", app)
export default posts
