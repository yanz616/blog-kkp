import { Hono } from "hono";
import { AuthController } from "../controllers/auth.controller.js";

const app = new Hono()
    .post("/register", AuthController.register)
    .post("/login", AuthController.login)

const auth = new Hono().route("/v1", app)
export default auth
