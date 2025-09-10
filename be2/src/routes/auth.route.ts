import { Hono } from "hono";
import { AuthController } from "../controllers/auth.controller";

const auth = new Hono().basePath("/v1")
auth.post("/register", AuthController.register)
auth.post("/login", AuthController.login)

export default auth
