<template>
  <card class="class">
    <h4
      slot="header"
      class="card-title"
      id="card-title"
      v-if="connexion == true"
    >
      Connection
    </h4>
    <h4
      slot="header"
      class="card-title"
      id="card-title"
      v-if="connexion == false"
    >
      Registration
    </h4>

    <form>
      <div class="row" v-if="!connexion">
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
            type="password"
            label="Password"
            placeholder="Password"
            v-model="user.password"
          >
          </base-input>
        </div>
      </div>
      <p class="form-error text-center">{{ formError }}</p>
      <div class="text-center" v-if="connexion">
        <button
          type="submit"
          class="btn btn-info btn-fill float-right"
          @click.prevent="signinUser"
        >
          Connexion
        </button>
      </div>
      <div class="text-center" v-else>
        <button
          type="submit"
          class="btn btn-info btn-fill float-right"
          @click.prevent="signupUser"
        >
          Create Profile
        </button>
      </div>
      <div class="msg" v-if="connexion">
        Want to create an account ? <a href="/#/signup">Sign up here</a>
      </div>
      <div class="msg" v-else>
        Already have an account ? <a href="/#/signin">Sign in here</a>
      </div>
    </form>
  </card>
</template>

<script>
import { createUser, signin } from '../../api_wrapper/users/users';
import Cookies from 'js-cookie';

export default {
  name: 'AuthCard',
  components: {},
  props: {
    connexion: {
      type: Boolean,
    },
  },
  data() {
    return {
      user: {
        username: '',
        email: '',
        password: '',
      },
      formError: '',
    };
  },
  methods: {
    isSignupFormValid() {
      return (
        this.user.username != '' &&
        this.user.email != '' &&
        this.user.password != ''
      );
    },
    isSigninFormValid() {
      return this.user.username != '' && this.user.password != '';
    },
    async signupUser() {
      if (!this.connexion) {
        this.formError = '';
        if (!this.isSignupFormValid()) {
          this.formError = 'All fields must be filled';
          return;
        }
        const user = await createUser(this.user);
        if (user.errors) {
          this.formError = 'A user with this username or email already exists';
        }
      }
      if (this.formError === '') {
        this.signinUser();
      }
    },
    async signinUser() {
      this.formError = '';
      if (!this.isSigninFormValid()) {
        this.formError = 'All fields must be filled';
        return;
      }
      const token = (await signin(this.user)).token;
      if (token) {
        Cookies.set('token', token);
        this.$router.push('dashboard');
      } else this.formError = 'Incorrect username or password';
    },
  },
};
</script>
<style>
.row {
  display: flex;
  justify-content: center;
  text-align: start;
}
.class {
  min-width: 40%;
  margin: 0;
  position: absolute;
  top: 40%;
  left: 50%;
  transform: translate(-50%, -50%);
  text-align: center;
}
#card-title {
  margin-top: 20px;
}
.msg {
  padding: 20px;
}
</style>
