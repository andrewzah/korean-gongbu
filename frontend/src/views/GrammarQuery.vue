<script setup lang="ts">
  import axios from 'axios';
  import { onMounted, ref, watch } from 'vue';
  import { useAuthStore } from '../stores/auth';
  import type Grammar from '@/models/grammar';

  const authStore = useAuthStore();
  const token: string = authStore.token || '';
  const query = ref('');
  const results = ref([]);

  onMounted(() => {
    getGrammars()
  });

  async function getGrammars() {
    if (!authStore.token) {
      console.log('no token!!');
      return
    }

    try {
      const res = await axios.post(
        'http://localhost:3000/api/v1/grammar/search',
        { query: query.value },
        { headers: { 'Authorization': `Bearer ${token}` } }
      );

      results.value = res.data;
    }
    catch (err) {
      console.log(err);
      results.value = [];
    }
  }

  watch(query, (_oldQuery: string, _newQuery: string) => {
    getGrammars();
  });
</script>

<template>
  <input type="text" v-model="query" placeholder="까" />

  <div class="about">
    <div
      v-for="grammar in results"
      class="grammar"
    >
      <p><i>
        <router-link :to="{ name: 'grammar', params: { id: grammar.id }}" >
          {{ grammar.name }}
        </router-link>
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
