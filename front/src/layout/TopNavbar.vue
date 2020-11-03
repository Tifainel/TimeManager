<template>
  <nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
      <p class="navbar-brand">{{ routeName }}</p>
      <button
        type="button"
        class="navbar-toggler navbar-toggler-right"
        :class="{ toggled: $sidebar.showSidebar }"
        aria-controls="navigation-index"
        aria-expanded="false"
        aria-label="Toggle navigation"
        @click="toggleSidebar"
        v-if="!isMobile"
      >
        <span class="navbar-toggler-bar burger-lines"></span>
        <span class="navbar-toggler-bar burger-lines"></span>
        <span class="navbar-toggler-bar burger-lines"></span>
      </button>
      <div class="collapse navbar-collapse justify-content-end">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item" v-if="isLoggedIn">
            <span class="username">
              <i class="nc-icon nc-single-02 picto" />
              {{ username }}
            </span>
          </li>
          <li class="nav-item" v-if="isLoggedIn">
            <a href="#" class="nav-link" @click.prevent="handleLogout">
              Log out
            </a>
          </li>
          <li class="nav-item" v-if="!isLoggedIn">
            <a href="#" class="nav-link" @click.prevent="handleRedirect">
              Log in
            </a>
          </li>
        </ul>
      </div>
      <check-in-out-button
        class="check-in-out-butotn"
        v-if="isMobile && isLoggedIn"
      ></check-in-out-button>
    </div>
  </nav>
</template>
<script>
import Cookies from 'js-cookie';
import jwt_decode from 'jwt-decode';
import { getUserById } from '../api_wrapper/users/users';
import CheckInOutButton from '../components/ChekInOutButton';
import { getDeviceType } from '../helpers/getDeviceType'

export default {
  components: {
    CheckInOutButton,
  },
  computed: {
    routeName() {
      const { name } = this.$route;
      return this.capitalizeFirstLetter(name);
    },
    isLoggedIn() {
      return !!Cookies.get('token');
    },
    isMobile() {
      return getDeviceType() === 'mobile';
    },
  },
  data() {
    return {
      activeNotifications: false,
      username: '',
    };
  },
  methods: {
    capitalizeFirstLetter(string) {
      return string.charAt(0).toUpperCase() + string.slice(1);
    },
    toggleNotificationDropDown() {
      this.activeNotifications = !this.activeNotifications;
    },
    closeDropDown() {
      this.activeNotifications = false;
    },
    toggleSidebar() {
      this.$sidebar.displaySidebar(!this.$sidebar.showSidebar);
    },
    hideSidebar() {
      this.$sidebar.displaySidebar(false);
    },
    handleLogout() {
      Cookies.remove('token');
      window.localStorage.clear();
      this.$router.push('signup');
    },
    handleRedirect() {
      this.$router.push('signin');
    },
  },

  async beforeMount() {
    const token = Cookies.get('token');
    const userId = jwt_decode(token).id;
    const user = await getUserById(userId);
    this.username = this.capitalizeFirstLetter(user.username);
  },
};
</script>
<style>
.picto {
  margin-right: 5px;
}
.username {
  display: flex;
  align-items: center;
  color: #1dc7ea;
}
.check-in-out-button {
  width: 40%;
  margin-top: 0px;
}
</style>
