<script setup lang="ts">
  import { ref, onMounted, computed } from 'vue';
  import axios from 'axios';
  import type Grammar from '@/models/grammar';
  import { useAuthStore } from '../stores/auth';

  const authStore = useAuthStore();
  let token = authStore.token;

  // vars
  let error = ref();
  let grammar = ref();
  let grammarId = computed(() => {
    return 378
  });

  async function getGrammar(id: number, token: string) {
    try {
      const result = await axios.get(
        'http://localhost:3000/api/v1/grammar/' + grammarId.value,
        { headers: { "Authorization": "Bearer " + authStore.token } }
      );

      grammar.value = result.data.data.attributes;
    }
    catch (err) {
      console.log(err);
      //error = err;
    }
  }

  async function handleEdit() {
    if (!authStore.token) {
      console.log('no token!!');
      return;
    }

    try {
      const res = await axios.put(
        'http://localhost:3000/api/v1/grammar/' + grammarId,
        { grammar: grammar.value, },
        { headers: { "Authorization": "Bearer "+authStore.token } }
      );

      grammar.value = res.data.data.attributes;
    }
    catch (err) {
      // error = err;
    }
  }

  onMounted(async () => {
    try {
      let grammar = await getGrammar(grammarId.value, token!);
    } catch (err) {
      console.log(err);
    }
  });
</script>

<template>
  <form v-if="grammar" @submit.prevent="handleEdit">
    <h1> {{ grammar.name }} </h1>

    <div>
      <label for="description_en">description_en</label>
      <br>
      <input
        type="text"
        name="description_en"
        v-model="grammar.description_en"
      />
    </div>

    <br>

    <div>
      <label for="category_en">category_en</label>
      <br>
      <input
        type="text"
        name="category_en"
        v-model="grammar.category_en"
      />
    </div>
    <br>

    <div>
      <label for="additional_info">additional_info</label>
      <br>
      <input
        type="text"
        name="additional_info"
        v-model="grammar.additional_info"
      />
    </div>

    <div>
      <button><span>Save Changes</span></button>
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
