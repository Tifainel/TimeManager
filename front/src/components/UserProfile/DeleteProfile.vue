<template>
  <div>
    <card>
      <h4 slot="header" class="card-title">Delete profile</h4>
      <p class="text-container">
        Warning ! Clicking on this button will definitly delete all of your
        personnal and work informations.
      </p>
      <div class="text-center">
        <button
          type="submit"
          class="btn btn-info btn-danger"
          @click.prevent="handleDeleteUser"
        >
          Delete profile
        </button>
      </div>
    </card>
  </div>
</template>

<script>
import Cookies from 'js-cookie';
import jwt_decode from 'jwt-decode';

export default {
  name: 'DeleteProfile',
  props: {
    deleteUser: {
      type: Function,
      required: true,
    },
  },
  methods: {
    async handleDeleteUser() {
      const token = Cookies.get('token');
      this.deleteUser(jwt_decode(token).id);
    },
  },
};
</script>

<style scoped>
.text-container {
  padding: 20px;
}
</style>
