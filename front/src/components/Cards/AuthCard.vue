<template>
  <card class="class">
    <h4
      slot="header"
      class="card-title"
      id="card-title"
      v-if="connexion == true"
    >
      Connexion
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
            type="text"
            label="Username"
            placeholder="Username"
            v-model="user.username"
          >
          </base-input>
        </div>
      </div>
      <div class="row" v-if="!connexion">
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
      <div class="text-center" v-if="connexion">
        <button
          type="submit"
          class="btn btn-info btn-fill float-right"
          @click.prevent="connexion"
        >
          Connexion
        </button>
      </div>
      <div class="text-center" v-else>
        <button
          type="submit"
          class="btn btn-info btn-fill float-right"
          @click.prevent="createProfile"
        >
          Create Profile
        </button>
      </div>
      <div class="msg" v-if="connexion">
        Want to create an account ? <a href="/#/sign-in">Sign in here</a>
      </div>
      <div class="msg" v-else>
        Already have an account ? <a href="/#/sign-up">Sign up here</a>
      </div>
    </form>
  </card>
</template>
<script>
export default {
  name: "AuthCard",
  components: {},
  props: {
    connexion: {
      type: Boolean
    }
  },
  data() {
    return {
      user: {
        username: "",
        email: "",
        password: ""
      }
    };
  },
  methods: {
    createProfile() {}
    // redirect() {
    //   if (connexion) {
    //     this.$router.push({ name: "SignIn" });
    //   } else {
    //     this.$router.push({ name: "SignUp" });
    //   }
    // }
  }
};
</script>
<style>
.row {
  display: flex;
  justify-content: center;
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
