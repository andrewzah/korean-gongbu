<script setup lang="ts">
  import { ref, reactive, computed } from 'vue';
  import { useAuthStore } from '../stores/auth';
  import LoginRequest from '../models/requests/LoginRequest';

  const authStore = useAuthStore();
  const loginRequest = new LoginRequest('', '');

  const handleLogin = () => {
    try {
      authStore.login(loginRequest.email, loginRequest.raw_password);
    }
    catch (err) {
      console.log(err);
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
        v-model="loginRequest.email"
      />
    </div>

    <div>
      <label for="password">Password</label>
      <input
        type="text"
        name="password"
        v-model="loginRequest.raw_password"
      />
    </div>

    <div>
      <button><span>Submit</span></button>
    </div>
  </form>
</template>
