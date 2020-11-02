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
      <div class="row">
        <div class="col-md-6">
          <base-input
            type="password"
            label="Password"
            placeholder="Password"
            v-model="user.password"
          >
          </base-input>
        </div>
      </div>
      <p class="form-error text-center">{{ formError }}</p>
      <div class="text-center">
        <button
          type="submit"
          class="btn btn-info btn-fill float-right"
          @click.prevent="updateProfile"
        >
          Update Profile
        </button>
      </div>
      <p class="form-success text-center">{{ formSuccess }}</p>
      <div class="clearfix"></div>
    </form>
  </card>
</template>

<script>
import Card from 'src/components/Cards/Card.vue';
import Cookies from 'js-cookie';
import jwt_decode from 'jwt-decode';
import { getConnexionType } from '../../helpers/getConnexionType'

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
        username: "",
        email: "",
        password: ""
      },
      formError: "",
      formSuccess: ""
    };
  },
  methods: {
    async updateProfile() {
      const token = Cookies.get('token');
      if (getConnexionType() === 'none') {
        alert("Oops ! You must be connected to the Internet to use this feature");
        return;
      }
      if (this.isEmailValid()) {
        this.formError = "";
        const updated = await this.updateUser(jwt_decode(token).id, this.user);
        if (updated.error) {
          this.formError = "An error has occured";
        } else {
          this.formSuccess = "Your profile has been updated";
        }
      } else {
        this.formError = 'The email is incorrect';
      }
    },
    isEmailValid() {
      return this.user.email.match(
        /([a-zA-Z0-9\.\-\_]*)@[a-zA-Z0-9\.\-]*\.[a-zA-Z]{1,3}/g,
      );
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
