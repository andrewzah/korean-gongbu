import { ref } from 'vue';
import { defineStore } from "pinia";
import axios from 'axios';

export type AuthState =
{
  token: String,
  returnUrl: String,
};

export const useAuthStore = defineStore('auth', () => {
  let tokenString = localStorage.getItem('gongbu-token');
  let token: string | null = JSON.parse(tokenString || '');
  //const returnUrl = ref<string>();

  async function login(email: string, password: string): Promise<void> {
    try {
      const res = await axios.post(
        'http://localhost:3000/api/v1/auth/login',
        { email: email, password: password }
      );

      token = res.data.token;
      localStorage.setItem('gongbu-token', JSON.stringify(token));

      //todo
      //this.$router.push(this.returnUrl || '/');

      return Promise.resolve();
    } catch (err) {
      return Promise.reject(err);
    }
  };

  async function logout() {
    token = null;
    localStorage.removeItem('gongbu-token');
    //this.$router.push('/');
  }

  return {
    token,
    login,
    logout
  }
})