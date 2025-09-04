import { Hono } from "hono";
import { AuthMiddleware } from "../middleware/auth.middleware.js";
import { CommentsController } from "../controllers/comments.controller.js";

const app = new Hono()
    // .get("/comments", PostsController.getAll)
    .get("/comments/:id", CommentsController.getByPost)
    .use("*", AuthMiddleware)
    .post("/comments", CommentsController.create)
// .put("/posts/:id", PostsController.update)
// .delete("/posts/:id", PostsController.delete)

const comments = new Hono().route("/v1", app)
export default comments
