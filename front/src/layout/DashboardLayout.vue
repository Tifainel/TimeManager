<template>
  <div class="wrapper">
    <side-bar>
      <mobile-menu slot="content"></mobile-menu>
      <sidebar-link to="/overview">
        <i class="nc-icon nc-chart-pie-35"></i>
        <p>Example</p>
      </sidebar-link>
      <sidebar-link to="/dashboard">
        <i class="nc-icon nc-chart-pie-35"></i>
        <p>Dashboard</p>
      </sidebar-link>
      <sidebar-link to="/user">
        <i class="nc-icon nc-circle-09"></i>
        <p>User Profile</p>
      </sidebar-link>
      <sidebar-link to="/workingtimes">
        <i class="nc-icon nc-notes"></i>
        <p>My working time</p>
      </sidebar-link>
      <sidebar-link to="/teams" v-if="role != 1">
        <i class="nc-icon nc-badge"></i>
        <p>My teams</p>
      </sidebar-link>
      <check-in-out-button></check-in-out-button>
    </side-bar>
    <div class="main-panel">
      <top-navbar></top-navbar>

      <dashboard-content @click="toggleSidebar"> </dashboard-content>

      <content-footer></content-footer>
    </div>
  </div>
</template>

<script>
import TopNavbar from './TopNavbar.vue';
import ContentFooter from './ContentFooter.vue';
import DashboardContent from './Content.vue';
import MobileMenu from './MobileMenu.vue';
import CheckInOutButton from '../components/ChekInOutButton';
import Cookies from "js-cookie";
import jwt_decode from "jwt-decode";

export default {
  components: {
    TopNavbar,
    ContentFooter,
    DashboardContent,
    MobileMenu,
    CheckInOutButton,
  },
  data() {
    return {
      role: ""
    }
  },
  methods: {
    toggleSidebar() {
      if (this.$sidebar.showSidebar) {
        this.$sidebar.displaySidebar(false);
      }
    },
  },

  mounted() {
    const token = Cookies.get("token");
    this.role = jwt_decode(token).role;
  }
};
</script>

<style lang="scss"></style>
