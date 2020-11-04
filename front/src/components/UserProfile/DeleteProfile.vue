<template>
  <div>
    <card>
      <h4 slot="header" class="card-title">Delete profile</h4>
      <p class="text-container">
        Warning ! Clicking on this button will definitly delete all of your
        personnal and work information.
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
import Cookies from "js-cookie";
import jwt_decode from "jwt-decode";
import { getConnexionType } from "../../helpers/getConnexionType";

export default {
  name: "DeleteProfile",
  props: {
    deleteUser: {
      type: Function,
      required: true
    }
  },
  methods: {
    async handleDeleteUser() {
      if (getConnexionType() === "none") {
        alert(
          "Oops ! You must be connected to the Internet to use this feature"
        );
        return;
      }
      const token = Cookies.get("token");
      if (confirm("Do you really want to delete your profile ?")) {
        this.deleteUser(jwt_decode(token).id);
        Cookies.remove("token");
        window.localStorage.clear();
        this.$router.push("signup");
      }
    }
  }
};
</script>

<style scoped>
.text-container {
  padding: 20px;
}
</style>
