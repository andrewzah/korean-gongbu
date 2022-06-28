<script setup lang="ts">
  import { RouterLink, RouterView } from "vue-router";

  import { storeToRefs } from 'pinia';
  import { useAuthStore } from './stores/auth.ts';

  const authStore = useAuthStore();
</script>

<template>
  <header>
    <div class="wrapper">
      <nav>
        <RouterLink to="/">Home</RouterLink>
        <RouterLink to="/grammar-query">GrammarQuery</RouterLink>
        <RouterLink v-if="authStore.token" v-on:click.native="authStore.logout()" replace to="/login">Logout</RouterLink>
        <RouterLink v-else="authenticated" to="/login">Login</RouterLink>
      </nav>
    </div>
  </header>

  <RouterView />
</template>

<style>
@import "@/assets/base.css";

#app {
  max-width: 1280px;
  margin: 0 auto;
  padding: 2rem;

  font-weight: normal;
}

nav a {
  margin: 10px;
}
</style>
