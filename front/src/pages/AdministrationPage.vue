<template>
  <div class="content">
    <div class="container">
      <div class="row">
        <card class="col-md-12">
          <h4 slot="header" class="card-title">
            Modify the priviledge of a user
          </h4>
          <form>
            <base-input
              type="text"
              label="Username"
              placeholder="Username"
              v-model="username"
            >
            </base-input>
            <base-input
              type="text"
              label="Email"
              placeholder="email"
              v-model="email"
            >
            </base-input>
            <label>Role</label>
            <base-drop-down
              tag="div"
              :title="selectedRole.name || 'Select a role'"
              id="select"
            >
              <a
                class="dropdown-item"
                v-for="role in roles"
                :key="role.id"
                @click="selectedRole = role"
                >{{ role.name }}</a
              >
            </base-drop-down>
            <p class="form-error text-center">{{ formError }}</p>
            <div class="text-center">
              <button
                type="submit"
                class="btn btn-info btn-fill float-centers"
                @click.prevent="addMember"
              >
                Change the role
              </button>
            </div>
            <p class="form-success text-center">{{ formSuccess }}</p>
            <div class="clearfix"></div>
          </form>
        </card>
      </div>
    </div>
  </div>
</template>
<script>
import Cookies from "js-cookie";
import jwt_decode from "jwt-decode";
import Card from "src/components/Cards/Card.vue";
import { getRoles } from "src/api_wrapper/roles/roles.js";
import BaseDropDown from "src/components/BaseDropdown.vue";
import {
  getUserByEmailAndUsername,
  updateUserById
} from "src/api_wrapper/users/users.js";
import TeamMemberCard from "src/components/Cards/TeamMemberCard.vue";
import { getConnexionType } from '../helpers/getConnexionType'

export default {
  name: "AddMember",
  components: { Card, BaseDropDown, TeamMemberCard },

  data() {
    return {
      userId: "",
      roles: [],
      user: {
        id: "",
        username: "",
        email: "",
        role: ""
      },
      email: "",
      username: "",
      selectedRole: "",
      formError: "",
      formSuccess: ""
    };
  },
  methods: {
    async addMember() {
      if (getConnexionType() === "none") {
        alert(
          "Oops ! You must be connected to the Internet to use this feature"
        );
        return;
      }
      if (this.selectedRole && this.email && this.username) {
        this.user = await getUserByEmailAndUsername(this.email, this.username);
        if (this.user.error) {
          this.formError = "This user could not be found";
        } else {
          const body = {
            email: this.user.email,
            username: this.user.username,
            role: this.selectedRole.id
          };
          const updated = await updateUserById(this.user.id, body);
          if (!updated.error) {
            this.formError = "";
            this.formSuccess = `This user now has the priviledges ${this.selectedRole.name}`;
          } else {
            this.formError = "An error has occured";
          }
        }
      } else {
        this.formError = "All fields must be filled";
      }
    }
  },

  async mounted() {
    const token = Cookies.get("token");
    this.userId = jwt_decode(token).id;
    const roles = await getRoles();
    this.roles = roles.data;
  }
};
</script>
<style>
#select {
  width: 100%;
  border-radius: 5px;
  color: black;
  border-style: solid;
  border-width: 1px;
  border-color: #e3e3e3;
  margin-bottom: 1rem;
}

a {
  color: black;
  text-decoration: none;
}

.form-error {
  color: #fc6b74;
  font-size: 14px;
  margin-bottom: 5px;
}
.form-success {
  color: #58d68d;
  font-size: 14px;
  margin-top: 5px;
}
</style>
