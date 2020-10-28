<template>
  <ul class="nav nav-mobile-menu">
    <li class="nav-item">
      <a class="nav-link" @click.prevent="handleLogout">
        <span class="no-icon">Log out</span>
      </a>
    </li>
  </ul>
</template>
<script>
export default {
  name: 'mobile-menu',
  methods: {
    handleLogout() {
      Cookies.remove('token');
      this.$router.push('signup');
    },
  },
};
</script>
<style></style>
