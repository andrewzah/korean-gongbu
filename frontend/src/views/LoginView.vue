<script>
  import axios from 'axios';
  import { useAuthStore } from '../stores/auth.ts';

  export default {
    data() {
      return {
        input: {
          email: '',
          password: ''
        }
      }
    },

    computed: {
      loggedIn() {
        return this.$store.state.auth.status.loggedIn
      }
    },

    mounted() { },
    methods: {
      async handleLogin() {
        const authStore = useAuthStore();

        try {
          authStore.login(this.input.email, this.input.password);
        }
        catch (err) {
          console.log(err);
        }
      }
    }
  }
</script>

<template>
  <form @submit.prevent="handleLogin">
    <div>
      <label for="email">Email</label>
      <input
        type="text"
        name="email"
        v-model="input.email"
      />
    </div>

    <div>
      <label for="password">Password</label>
      <input
        type="text"
        name="password"
        v-model="input.password"
      />
    </div>

    <div>
      <button><span>Submit</span></button>
    </div>

    <div class="form-group">
      <div role="alert" v-if="message">{{message}}</div>
    </div>
  </form>
</template>
