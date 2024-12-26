<script setup>
import { useUserStore } from "@store/user";

fetch("http://localhost:3333/api/example/text")
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

fetch("http://localhost:3333/api/example/text")
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

fetch("http://localhost:3333/api/example/json")
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

fetch("http://localhost:3333/api/example/json")
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

const send = async () => {
  const response1 = await fetch("http://localhost:3333/api/users", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      Accept: "application/json",
    },
    body: JSON.stringify({ name: "example", email: "example16@example.com", password: "password" }),
  });
  console.log(response1);
  const userId = (await response1.json()).id;
  console.log(userId);
  const response2 = await fetch("http://localhost:3333/api/tokens", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      Accept: "application/json",
    },
    body: JSON.stringify({ id: userId, password: "password" }),
  });
  fetch("http://localhost:3333/api/users/" + userId, {
    method: "GET",
    headers: {
      Accept: "application/json", // これがないとroute [login] not defined がでる
      "Content-Type": "application/json",
    },
  });
  const token = (await response2.json()).token;
  const response3 = await fetch("http://localhost:3333/api/users/" + userId, {
    method: "GET",
    headers: {
      Authorization: "Bearer " + token,
      Accept: "application/json",
      "Content-Type": "application/json",
    },
  });
  console.log(await response3.json());
  const response4 = await fetch("http://localhost:3333/api/me", {
    method: "GET",
    headers: {
      Authorization: "Bearer " + token,
      Accept: "application/json",
      "Content-Type": "application/json",
    },
  });
  console.log(await response4.json());
  const response5 = await fetch("http://localhost:3333/api/users/" + 1, {
    method: "GET",
    headers: {
      Authorization: "Bearer " + token,
      Accept: "application/json",
      "Content-Type": "application/json",
    },
  });
  console.log(await response5.json());
};

const userStore = useUserStore();
</script>

<template>
  <p>{{ userStore.id }}</p>
  <p>{{ userStore.name }}</p>
  <div>
    <button @click="userStore.increment()">{{ userStore.score }}</button>
  </div>
  <div>
    <button @click="send">FETCH API</button>
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
