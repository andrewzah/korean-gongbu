<script>
  import axios from 'axios';
  import { storeToRefs } from 'pinia';
  import { useAuthStore } from '../stores/auth.ts';

  const authStore = useAuthStore();

  export default {
    data() {
      return {
        query: '까',
        results: [],
      }
    },

    mounted() {
      this.getResults()
    },

    watch: {
      query(newQuery, oldQuery) {
        this.getResults()
      }
    },

    methods: {
      async getResults() {
        if (!authStore.token) {
          console.log('no token!!');
          return
        }
        try {
          const res = await axios.post(
            'http://localhost:3000/api/v1/grammar/search',
            { query: this.query },
            { headers: { "Authorization": "Bearer "+authStore.token } }
          );

          this.results = res.data;
        }
        catch (err) {
          this.results = [];
        }
      }
    }
  }
</script>

<template>
  <input type="text" v-model="query" placeholder="까" />

  <div class="about">
    <div
      v-for="grammar in results"
      class="grammar"
    >
      <p><i>
      {{ grammar.name }}
      </i></p>
      <p>
      {{ grammar.description_en }}
      </p>
      <br>
    </div>
  </div>
</template>

<style>
@media (min-width: 1024px) {
  .about {
    min-height: 100vh;
  }

  div p {
    flex-direction: column;
  }
}
</style>
