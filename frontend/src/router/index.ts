import { createRouter, createWebHistory } from "vue-router";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "home",
      component: () => import("../views/LoginView.vue"),
    },
    {
      path: "/grammar-query",
      name: "grammar-query",
      component: () => import("../views/GrammarQuery.vue"),
    },
    {
      path: "/grammar/:id",
      name: "grammar",
      component: () => import("../views/GrammarShow.vue"),
    },
    {
      path: "/grammar/:id/edit",
      name: "grammar-edit",
      component: () => import("../views/GrammarEdit.vue"),
    },
    {
      path: "/login",
      name: "login",
      component: () => import("../views/LoginView.vue"),
    },
  ],
});

export default router;
