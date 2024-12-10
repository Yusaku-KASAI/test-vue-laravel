import { createWebHistory, createRouter } from "vue-router";

import Home from "@pages/Home.vue";
import Test from "@pages/Test.vue";
import About from "@pages/About.vue";

const routes = [
  { path: "/", component: Home },
  { path: "/test", component: Test },
  { path: "/about", component: About },
];

export const router = createRouter({
  history: createWebHistory(),
  routes,
});
