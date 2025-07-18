<script setup>
import { RouterView } from 'vue-router'
</script>

<template>
  <div id="app">
    <header>
      <h1>간단 금전출납부</h1>
      <nav>
        <RouterLink to="/">내역 관리</RouterLink> | 
        </nav>
    </header>
    <main>
      <RouterView />
    </main>
  </div>
</template>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
header {
  margin-bottom: 20px;
}
nav {
  margin-top: 10px;
}
nav a {
  font-weight: bold;
  color: #2c3e50;
  text-decoration: none;
  padding: 5px 10px;
}
nav a.router-link-exact-active {
  color: #42b983;
}
main {
  max-width: 900px;
  margin: 0 auto;
  padding: 20px;
  border: 1px solid #eee;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}
</style>
