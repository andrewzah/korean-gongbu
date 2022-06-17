<script>
  import axios from 'axios';

  export default {
    data() {
      return {
        query: '까',
        results: []
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
        try {
          const res = await axios.post(
            'http://localhost:3000/api/v1/grammar/search',
            { query: this.query }
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
      {{ grammar.translation_en }}
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
