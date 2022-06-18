<script setup lang="ts">
  import { RouterLink, RouterView } from "vue-router";
  import HelloWorld from "@/components/HelloWorld.vue";
</script>

<script lang="ts">
  export default {
    data() {
      return {
        authenticated: false,
      }
    },

    methods: {
      setAuthenticated(status) {
        this.authenticated = status;
      },

      logout() {
        this.authenticated = false;
      }
    }
  }
</script>

<template>
  <header>
    <div class="wrapper">
      <nav>
        <RouterLink to="/">Home</RouterLink>
        <RouterLink to="/about">About</RouterLink>
        <RouterLink v-if="authenticated" v-on:click.native="logout()" replace to="/login">Logout</RouterLink>
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
</style>
