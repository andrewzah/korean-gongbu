<script>
  import axios from 'axios';
  import { storeToRefs } from 'pinia';
  import { useAuthStore } from '../stores/auth.ts';

  const authStore = useAuthStore();

  export default {
    data() {
      return {
        grammar: null,
        err: null,
      }
    },

    mounted() {
      this.getResult()
    },

    methods: {
      async getResult() {
        if (!authStore.token) {
          console.log('no token!!');
          return;
        }

        try {
          const res = await axios.get(
            'http://localhost:3000/api/v1/grammar/' + this.$route.params.id,
            { headers: { "Authorization": "Bearer "+authStore.token } }
          );

          this.grammar = res.data.data.attributes;
        }
        catch (err) {
          this.err = err;
        }
      }
    }
  }
</script>

<template>
  <div v-if="this.grammar">
    <h1> {{ this.grammar.name }} </h1>

    <p><b> Description: </b></p>
    <p> {{ this.grammar.description_en}} </p>

    <p><b> Category: </b></p>
    <p> {{ this.grammar.category_en }} </p>

    <p><b> Additional Info: </b></p>
    <p> {{ this.grammar.additional_info }} </p>


    <hr>

    <router-link :to="{ name: 'grammar-edit', params: { id: this.$route.params.id }}" > Edit </router-link>
  </div>
</template>

<style>
b {
  font-weight: bold;
}
</style>
