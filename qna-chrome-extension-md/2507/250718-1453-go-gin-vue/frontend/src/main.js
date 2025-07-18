import { createApp } from 'vue'
import App from './App.vue'
import { createRouter, createWebHistory } from 'vue-router'

import TransactionList from './components/TransactionList.vue'
import TransactionForm from './components/TransactionForm.vue'

const routes = [
  { path: '/', component: TransactionList },
  { path: '/add', component: TransactionForm },
  { path: '/edit/:id', component: TransactionForm, props: true },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

const app = createApp(App)
app.use(router)
app.mount('#app')
