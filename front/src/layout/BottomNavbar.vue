<template>
  <nav class="navbar navbar-expand-lg fix">
    <div class="container-fluid">
      <a href="#/dashboard">
        <i
          class="nc-icon nc-chart-pie-35 icon"
          v-bind:id="
            this.$route.path == '/dashboard' ? 'isActive' : 'notActive'
          "
        ></i>
      </a>
      <a href="#/user">
        <i
          class="nc-icon nc-circle-09 icon"
          v-bind:id="
            this.$route.path == '/user' ? 'isActive' : 'notActive'
          "
        ></i>
      </a>
      <a href="#/workingtimes">
        <i
          class="nc-icon nc-notes icon"
          v-bind:id="
            this.$route.path == '/workingtimes' ? 'isActive' : 'notActive'
          "
        ></i>
      </a>
      <a href="#/teams" v-if="role == 2 || role == 3">
        <i
          class="nc-icon nc-badge icon"
          v-bind:id="
            this.$route.path == '/teams' ? 'isActive' : 'notActive'
          "
        ></i>
      </a>
      <a href="#/administration" v-if="role == 3">
        <i
          class="nc-icon nc-settings-gear-64 icon"
          v-bind:id="
            this.$route.path == '/administration' ? 'isActive' : 'notActive'
          "
        ></i>
      </a>
    </div>
  </nav>
</template>
<script>
import Cookies from "js-cookie";
import jwt_decode from "jwt-decode";
import { getUserById } from "../api_wrapper/users/users";
import CheckInOutButton from "../components/ChekInOutButton";

export default {
  components: {
    CheckInOutButton
  },
  data() {
    return {
      role: ""
    };
  },
  methods: {},

  beforeMount() {
    const token = Cookies.get("token");
    this.role = jwt_decode(token).role;
  }
};
</script>
<style>
.fix {
  position: sticky;
  bottom: 0;
  width: 100%;
  background-color: #212529;
}
#notActive {
  color: white;
}
#isActive {
  color: #42d0ed;
}
.icon:hover {
  color: #42d0ed;
}
</style>
