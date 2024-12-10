import { fileURLToPath, URL } from "node:url";

import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";
import vueDevTools from "vite-plugin-vue-devtools";

// https://vite.dev/config/
export default defineConfig({
  plugins: [vue(), vueDevTools()],
  resolve: {
    alias: {
      "@": fileURLToPath(new URL("./src", import.meta.url)),
      "@assets": fileURLToPath(new URL("./src/assets", import.meta.url)),
      "@components": fileURLToPath(
        new URL("./src/components", import.meta.url)
      ),
      "@pages": fileURLToPath(new URL("./src/pages", import.meta.url)),
    },
  },
  server: {
    // cors: {
    //   origin: "https://example.com",
    //   methods: ["GET"],
    //   allowedHeaders: ["Content-Type"],
    // },
    host: true,
    port: 3000,
    proxy: {
      "/api": {
        target: "http://nginx:80",
        changeOrigin: true,
        // rewrite: (path) => path.replace(/^\/api/, ""),
        secure: false,
      },
    },
  },
});
