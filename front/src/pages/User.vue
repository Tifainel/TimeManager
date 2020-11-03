<template>
  <div class="content">
    <div class="container-fluid">
      <div class="row">
        <div class="col-md-9">
          <edit-profile-form
            :username="username"
            :email="email"
            :updateUser="updateUser"
          >
          </edit-profile-form>
        </div>
        <div class="col-md-3" v-if="!isMobile">
          <delete-profile :deleteUser="deleteUser"> </delete-profile>
        </div>
        <div class="col-md-3 text-center" v-if="isMobile">
          <button  class="btn btn-info" @click.prevent="handleLogout">
            <span class="no-icon">Log out</span>
          </button>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import EditProfileForm from '../components/UserProfile/EditProfileForm';
import DeleteProfile from 'src/components/UserProfile/DeleteProfile';
import Cookies from 'js-cookie';
import jwt_decode from 'jwt-decode';
import {
  getUserById,
  updateUserById,
  deleteUserById,
} from '../api_wrapper/users/users';
import { getDeviceType } from "../helpers/getDeviceType";

export default {
  name: 'User',
  components: {
    EditProfileForm,
    DeleteProfile,
  },
  computed: {
    isMobile() {
      return getDeviceType() === 'mobile';
    },
  },
  data() {
    return {
      email: '',
      username: '',
      userId: '',
      role: '',
    };
  },
  methods: {
    createUser() {},
    async updateUser(userId, user) {
      return await updateUserById(userId, user);
    },
    async getUser() {
      const token = Cookies.get('token');
      this.role = jwt_decode(token).role;
      const user = await getUserById(jwt_decode(token).id);
      this.email = user.email;
      this.username = user.username;
      this.userId = user.id.toString();
    },
    async deleteUser(userId) {
      await deleteUserById(userId);
    },
    handleLogout() {
      Cookies.remove('token');
      window.localStorage.clear();
      this.$router.push('signin');
    },
  },

  async mounted() {
    await this.getUser();
  },
};
</script>
<style>
.row {
  display: flex;
  justify-content: center;
}
</style>
