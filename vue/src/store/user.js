import { ref, computed } from "vue";
import { defineStore } from "pinia";

export const useUserStore = defineStore("user", () => {
  const id = ref(0);
  const name = ref("Eduardo");
  const score = ref(0);
  const doubleScore = computed(() => score.value * 2);
  function increment() {
    score.value++;
  }

  return { id, name, score, doubleScore, increment };
});
