<script setup>
import { useUserStore } from "@store/user";

fetch("http://localhost:3000/api/example/text")
  .then((response) => {
    if (!response.ok) {
      throw new Error(`HTTP error: ${response.status}`);
    }
    console.log("response");
    console.log(response);
    return response.text();
  })
  .then((text) => {
    console.log("response text:" + text);
  })
  .catch((error) => {
    console.log("response error:" + error);
  });

fetch("http://localhost:3000/api/example/text")
  .then((response) => {
    if (!response.ok) {
      throw new Error(`HTTP error: ${response.status}`);
    }
    console.log("response");
    console.log(response);
    return response.json();
  })
  .then((json) => {
    console.log("response json:" + json);
  })
  .catch((error) => {
    console.log("response error:" + error);
  });

fetch("http://localhost:3000/api/example/json")
  .then((response) => {
    if (!response.ok) {
      throw new Error(`HTTP error: ${response.status}`);
    }
    console.log("response");
    console.log(response);
    return response.text();
  })
  .then((text) => {
    console.log("response text:" + text);
  })
  .catch((error) => {
    console.log("response error:" + error);
  });

fetch("http://localhost:3000/api/example/json")
  .then((response) => {
    if (!response.ok) {
      throw new Error(`HTTP error: ${response.status}`);
    }
    console.log("response");
    console.log(response);
    return response.json();
  })
  .then((json) => {
    console.log(json);
    console.log("response json:" + json);
  })
  .catch((error) => {
    console.log("response error:" + error);
  });
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
