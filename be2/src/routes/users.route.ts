import { Hono } from "hono";
import { AuthMiddleware } from "../middleware/auth.middleware.js";
import { UserController } from "../controllers/users.controller.js";

const app = new Hono()
    // .get("/posts", PostsController.getAll)
    .get("/users/:id", UserController.getById)
    .use("*", AuthMiddleware)
    .put("/users/:id", UserController.update)
    .delete("/users/:id", UserController.delete)

const users = new Hono().route("/v1", app)
export default users
