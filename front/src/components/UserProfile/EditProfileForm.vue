<template>
  <card>
    <h4 slot="header" class="card-title">Edit Profile</h4>
    <form>
      <div class="row">
        <div class="col-md-6">
          <base-input
            type="text"
            label="Username"
            placeholder="Username"
            v-model="user.username"
          >
          </base-input>
        </div>
      </div>
      <div class="row">
        <div class="col-md-6">
          <base-input
            type="email"
            label="Email"
            placeholder="Email"
            v-model="user.email"
          >
          </base-input>
        </div>
      </div>
      <div class="text-center">
        <button
          type="submit"
          class="btn btn-info btn-fill float-right"
          @click.prevent="updateProfile"
        >
          Update Profile
        </button>
      </div>
      <div class="clearfix"></div>
    </form>
  </card>
</template>

<script>
import Card from 'src/components/Cards/Card.vue';
import Cookies from 'js-cookie';
import jwt_decode from 'jwt-decode';

export default {
  components: {
    Card,
  },
  props: {
    email: {
      type: String,
      required: true,
    },
    username: {
      type: String,
      required: true,
    },
    updateUser: {
      type: Function,
      required: true,
    },
  },
  data() {
    return {
      user: {
        username: '',
        email: '',
      },
    };
  },
  methods: {
    async updateProfile() {
      const token = Cookies.get('token');
      this.updateUser(jwt_decode(token).id, this.user);
      // alert('Your data: ' + JSON.stringify(this.user));
    },
  },
  mounted() {
    setTimeout(() => {
      this.user.username = this.username;
      this.user.email = this.email;
    }, 500);
  },
};
</script>

<style>
.text-center {
  display: flex;
  justify-content: center;
}
</style>
