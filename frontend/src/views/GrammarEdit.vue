<script>
  import axios from 'axios';
  import { storeToRefs } from 'pinia';
  import { useAuthStore } from '../stores/auth.ts';

  const authStore = useAuthStore();

  export default {
    data() {
      return {
        err: null,
        input: {
          grammar: null,
        }
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

          this.input.grammar = res.data.data.attributes;
        }
        catch (err) {
          this.err = err;
        }
      },

      async handleEdit() {
        if (!authStore.token) {
          console.log('no token!!');
          return;
        }

        try {
          const res = await axios.put(
            'http://localhost:3000/api/v1/grammar/' + this.$route.params.id,
            { grammar: this.input.grammar, },
            { headers: { "Authorization": "Bearer "+authStore.token } }
          );

          this.input.grammar = res.data.data.attributes;
        }
        catch (err) {
          this.err = err;
        }
      }
    }
  }
</script>

<template>
  <form v-if="this.input.grammar" @submit.prevent="handleEdit">
    <h1> {{ this.input.grammar.name }} </h1>

    <div>
      <label for="description_en">description_en</label>
      <br>
      <input
        type="text"
        name="description_en"
        v-model="input.grammar.description_en"
      />
    </div>

    <br>

    <div>
      <label for="category_en">category_en</label>
      <br>
      <input
        type="text"
        name="category_en"
        v-model="input.grammar.category_en"
      />
    </div>
    <br>

    <div>
      <label for="additional_info">additional_info</label>
      <br>
      <input
        type="text"
        name="additional_info"
        v-model="input.grammar.additional_info"
      />
    </div>

    <div>
      <button><span>Save Changes</span></button>
    </div>

    <div class="form-group">
      <div role="alert" v-if="message">{{message}}</div>
    </div>
  </form>
</template>

<style>
b {
  font-weight: bold;
}

input {
  width: 100%;
}
</style>
