export const useUerStore = defineStore("user", () => {
  const id = ref(0);
  const name = ref("Eduardo");
  const score = ref(0);
  const doubleScore = computed(() => score.value * 2);
  function increment() {
    score.value++;
  }

  return { score, name, doubleScore, increment };
});
