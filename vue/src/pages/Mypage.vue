<script setup>
import { useUserStore } from "@store/user";

const userStore = useUserStore();
</script>

<template>
  <p>{{ userStore.id }}</p>
  <p>{{ userStore.name }}</p>
  <div>
    <button @click="userStore.increment()">{{ userStore.score }}</button>
  </div>
  <RouterLink to="/test">Go to Test!!</RouterLink>
</template>

<style scoped>
p {
  background-color: #f4f4f4;
}
button {
  background-color: #d3e3fd;
  width: 100px;
  height: 40px;
  border: 0;
}
</style>
