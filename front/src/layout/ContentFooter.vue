<template>
  <footer class="footer">
    <div class="container-fluid">
      <nav>
        <ul class="footer-menu">
          <li>
            <router-link :to="{ path: '/dashboard' }">Dashboard</router-link>
          </li>
          <li>
            <router-link :to="{ path: '/help' }" target="_blank"
              >FAQ</router-link
            >
          </li>
          <li>
            <a href="/tutorial.pdf" target="_blank">How to use ?</a>
          </li>
        </ul>
      </nav>
    </div>
  </footer>
</template>
<script>
export default {};
</script>
<style></style>
