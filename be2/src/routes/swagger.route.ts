import { swaggerUI } from '@hono/swagger-ui'
import { Hono } from 'hono'

const openApiDoc = {
    openapi: "3.0.0",
    info: {
        title: "API Documentation",
        version: "1.0.0",
        description: "API documentation for your service",
    },
    components: {
        securitySchemes: {
            bearerAuth: {
                type: "http",
                scheme: "bearer",
                bearerFormat: "JWT",
            },
        },
    },
    paths: {
        "/posts": {
            post: {
                summary: "Create post",
                description: "Buat post baru (hanya user login yang bisa)",
                security: [{ bearerAuth: [] }],
                requestBody: {
                    required: true,
                    content: {
                        "multipart/form-data": {
                            schema: {
                                type: "object",
                                properties: {
                                    title: { type: "string", example: "My First Post" },
                                    content: { type: "string", example: "This is the content of the post." },
                                    image: {
                                        type: "string",
                                        format: "binary",
                                        description: "Image file untuk post",
                                    },
                                },
                                required: ["title", "content", "image"],
                            },
                        },
                    },
                },
                responses: {
                    "201": {
                        description: "Post berhasil dibuat",
                        content: {
                            "application/json": {
                                schema: {
                                    type: "object",
                                    properties: {
                                        status: { type: "string", example: "success" },
                                        message: { type: "string", example: "Create posts successfully" },
                                        data: {
                                            type: "object",
                                            properties: {
                                                id: { type: "string" },
                                                title: { type: "string" },
                                                content: { type: "string" },
                                                image: { type: "string" },
                                                imageId: { type: "string" },
                                                authorId: { type: "string" },
                                                createdAt: { type: "string" },
                                            },
                                        },
                                    },
                                },
                            },
                        },
                    },
                    "400": { description: "Field required tidak lengkap" },
                    "401": { description: "Unauthorized (token tidak valid)" },
                    "500": { description: "Server error" },
                },
            },
        },
        "/register": {
            post: {
                summary: "Register user",
                description: "Buat akun baru dengan username, email, dan password",
                requestBody: {
                    required: true,
                    content: {
                        "application/json": {
                            schema: {
                                type: "object",
                                properties: {
                                    username: { type: "string", example: "johndoe" },
                                    email: { type: "string", example: "john@example.com" },
                                    password: { type: "string", example: "123456" },
                                },
                                required: ["username", "email", "password"],
                            },
                        },
                    },
                },
                responses: {
                    "201": {
                        description: "Registrasi berhasil",
                        content: {
                            "application/json": {
                                schema: {
                                    type: "object",
                                    properties: {
                                        success: { type: "boolean", example: "true" },
                                        statusCode: { type: "number", example: "201" },
                                        message: { type: "string", example: "Registrasi berhasil" },
                                        data: {
                                            type: "object",
                                            properties: {
                                                id: { type: "string" },
                                                username: { type: "string" },
                                                email: { type: "string" },
                                                avatar: { type: "string" },
                                                createdAt: { type: "string" },
                                            },
                                        },
                                    },
                                },
                            },
                        },
                    },
                    "400": { description: "Data tidak valid / email sudah digunakan" },
                    "500": { description: "Server error" },
                },
            },
        },
        "/login": {
            post: {
                summary: "Login user",
                description: "Login dengan email dan password untuk mendapatkan JWT token",
                requestBody: {
                    required: true,
                    content: {
                        "application/json": {
                            schema: {
                                type: "object",
                                properties: {
                                    email: { type: "string", example: "user@example.com" },
                                    password: { type: "string", example: "123456" },
                                },
                                required: ["email", "password"],
                            },
                        },
                    },
                },
                responses: {
                    "200": {
                        description: "Login berhasil",
                        content: {
                            "application/json": {
                                schema: {
                                    type: "object",
                                    properties: {
                                        success: { type: "boolean", example: "true" },
                                        statusCode: { type: "number", example: "200" },
                                        message: { type: "string", example: "Login berhasil" },
                                        data: {
                                            type: "object",
                                            properties: {
                                                id: { type: "string" },
                                                username: { type: "string" },
                                                avatar: { type: "string" },
                                                email: { type: "string" },
                                                token: { type: "string" },
                                                createdAt: { type: "string" },
                                            },
                                        },
                                    },
                                },
                            },
                        },
                    },
                    "400": { description: "Email atau password tidak valid" },
                    "401": { description: "Unauthorized" },
                    "500": { description: "Server error" },
                },
            },
        },
    },
};

const app = new Hono()

app.get('/doc', (c) => c.json(openApiDoc))

app.get('/ui', swaggerUI({ url: '/swagger/doc' }))

app.get('/health', (c) => c.text('Hallo world'))

export default app
