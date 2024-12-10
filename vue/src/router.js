import { createWebHistory, createRouter } from "vue-router";

import About from "@pages/About.vue";
import Home from "@pages/Home.vue";
import Mypage from "@pages/Mypage.vue";
import Test from "@pages/Test.vue";

const routes = [
  { path: "/", component: Home },
  { path: "/about", component: About },
  { path: "/test", component: Test },
  { path: "/mypage", component: Mypage },
];

export const router = createRouter({
  history: createWebHistory(),
  routes,
});
