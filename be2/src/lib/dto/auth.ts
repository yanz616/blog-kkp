interface LoginResponse {
    id: number;
    username: string;
    email: string;
    token: string;
    createdAt: string;
    updatedAt: string;
}

interface LoginRequest {
    email: string;
    password: string;
}




export { LoginResponse, LoginRequest }
