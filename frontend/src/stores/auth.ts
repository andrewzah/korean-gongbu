import { defineStore } from "pinia";
import axios from 'axios';

export const useAuthStore = defineStore({
  id: "auth",
  state: () => ({
    token: JSON.parse(localStorage.getItem('gongbu-token')),
    returnUrl: null,
  }),
  actions: {
    async login(email, password) {
      const res = await axios.post(
        'http://localhost:3000/api/v1/auth/login',
        { email: email, password: password }
      );

      this.token = res.data.token;
      localStorage.setItem('gongbu-token', JSON.stringify(this.token));

      //this.$router.push(this.returnUrl || '/');
    },

    logout() {
      this.token = null;
      localStorage.removeItem('gongbu-token');
      //this.$router.push('/');
    }
  }
});

// export const useCounterStore = defineStore({
//   id: "counter",
//   state: () => ({
//     counter: 0,
//   }),
//   getters: {
//     doubleCount: (state) => state.counter * 2,
//   },
//   actions: {
//     increment() {
//       this.counter++;
//     },
//   },
// });
