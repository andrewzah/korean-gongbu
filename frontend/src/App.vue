<script setup lang="ts">
  import { RouterLink, RouterView } from "vue-router";

  import { useAuthStore } from './stores/auth';

  const authStore = useAuthStore();
</script>

<template>
  <header>
    <div class="wrapper">
      <nav>
        <RouterLink to="/">Home</RouterLink>
        <RouterLink to="/grammar-query">GrammarQuery</RouterLink>
        <RouterLink v-if="authStore.token" v-on:click.native="authStore.logout()" replace to="/login">Logout</RouterLink>
        <RouterLink v-else to="/login">Login</RouterLink>
      </nav>
    </div>
  </header>

  <div id="app">
    <RouterView />
  </div>
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
