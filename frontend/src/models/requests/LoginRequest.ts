export default class LoginRequest {
    email: string;
    raw_password: string;

    constructor(email: string, raw_password: string) {
        this.email = email;
        this.raw_password = raw_password;
    }
}