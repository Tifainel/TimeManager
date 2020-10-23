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
        <div class="col-md-3">
          <delete-profile :deleteUser="deleteUser"> </delete-profile>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import EditProfileForm from '../components/UserProfile/EditProfileForm';
import UserCard from '../components/UserProfile/UserCard.vue';
import DeleteProfile from 'src/components/UserProfile/DeleteProfile';
import Cookies from 'js-cookie';
import jwt_decode from 'jwt-decode';
import {
  getUserById,
  updateUserById,
  deleteUserById,
} from '../api_wrapper/users/users';

export default {
  name: 'User',
  components: {
    EditProfileForm,
    UserCard,
    DeleteProfile,
  },

  data() {
    return {
      email: '',
      username: '',
      userId: '',
    };
  },
  methods: {
    createUser() {},
    async updateUser(userId, user) {
      await updateUserById(userId, user);
    },
    async getUser() {
      const token = Cookies.get('token');
      const user = await getUserById(jwt_decode(token).id);
      this.email = user.email;
      this.username = user.username;
      this.userId = user.id.toString();
    },
    async deleteUser(userId) {
      await deleteUserById(userId);
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
