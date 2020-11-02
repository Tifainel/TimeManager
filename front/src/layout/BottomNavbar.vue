<template>
  <nav class="navbar navbar-expand-lg fix">
    <div class="container-fluid">
      <span @click.prevent="redirect('dashboard')">
        <i
          class="nc-icon nc-chart-pie-35 icon"
          v-bind:id="
            this.$route.path == '/dashboard' ? 'isActive' : 'notActive'
          "
        ></i>
      </span>
      <span @click.prevent="redirect('user')">
        <i
          class="nc-icon nc-circle-09 icon"
          v-bind:id="this.$route.path == '/user' ? 'isActive' : 'notActive'"
        ></i>
      </span>
      <span @click.prevent="redirect('workingtimes')">
        <i
          class="nc-icon nc-notes icon"
          v-bind:id="
            this.$route.path == '/workingtimes' ? 'isActive' : 'notActive'
          "
        ></i>
      </span>
      <span @click.prevent="redirect('teams')" v-if="role == 2 || role == 3">
        <i
          class="nc-icon nc-badge icon"
          v-bind:id="this.$route.path == '/teams' ? 'isActive' : 'notActive'"
        ></i>
      </span>
      <span @click.prevent="redirect('administration')" v-if="role == 3">
        <i
          class="nc-icon nc-settings-gear-64 icon"
          v-bind:id="
            this.$route.path == '/administration' ? 'isActive' : 'notActive'
          "
        ></i>
      </span>
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
    isMobile() {
      return getDeviceType() === 'mobile';
    },
  },
  data() {
    return {
      role: '',
    };
  },
  methods: {
    redirect(page) {
      this.$router.push(page);
    },
  },

  beforeMount() {
    const token = Cookies.get('token');
    this.role = jwt_decode(token).role;
  },
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
