<template>
  <card>
    <h4 slot="header" class="card-title">Add a member to a team</h4>
    <form>
      <label>Name of the team</label>
      <base-drop-down tag="div" :title="selectedTeam.name" id="select">
        <a
          class="dropdown-item"
          v-for="team in teams"
          :key="team.id"
          @click="affectSelected(team)"
          >{{ team.name }}</a
        >
      </base-drop-down>
      <base-input
        type="text"
        label="Username"
        placeholder="Username"
        v-model="username"
      >
      </base-input>
      <base-input type="text" label="Email" placeholder="email" v-model="email">
      </base-input>
      <p class="form-error text-center">{{ formError }}</p>
      <div class="text-center">
        <button
          type="submit"
          class="btn btn-info btn-fill float-centers"
          @click.prevent="addMember"
        >
          Add
        </button>
      </div>
      <p class="form-success text-center">{{ formSuccess }}</p>
      <div class="clearfix"></div>
    </form>
  </card>
</template>
<script>
import Cookies from "js-cookie";
import jwt_decode from "jwt-decode";
import Card from "src/components/Cards/Card.vue";
import {
  getTeamsbyManagerId,
  modifyTeam,
  getOneTeam
} from "../../api_wrapper/teams/teams";
import BaseDropDown from "src/components/BaseDropdown.vue";
import { getUserByEmailAndUsername } from "../../api_wrapper/users/users";
import TeamMemberCard from "src/components/Cards/TeamMemberCard.vue";

export default {
  name: "AddMember",
  components: { Card, BaseDropDown, TeamMemberCard },

  data() {
    return {
      userId: "",
      teams: "",
      selectedTeam: {
        name: "Select a team",
        id: "",
        members: []
      },
      user: {
        id: "",
        username: "",
        email: ""
      },
      email: "",
      username: "",
      formError: "",
      formSuccess: ""
    };
  },
  methods: {
    async affectSelected(team) {
      this.selectedTeam = team;
    },
    async getAllUsers() {
      // this.users = await
    },

    async addMember() {
      if (this.selectedTeam.id && this.email && this.username) {
        this.user = await getUserByEmailAndUsername(this.email, this.username);
        if (this.user.error) {
          this.formError = "This user could not be found";
        } else {
          if (this.checkForUserInTeam(this.user.id)) {
            this.selectedTeam.members.push(this.user.id);
            modifyTeam(this.selectedTeam.id, this.selectedTeam);
            this.formError = "";
            this.formSuccess = `This user was added to ${this.selectedTeam.name}`;
          } else {
            this.formError = "This user is already in this team";
          }
        }
      } else {
        this.formError = "All fields must be filled";
      }
    },
    checkForUserInTeam(userId) {
      for (const i in this.selectedTeam.members) {
        if (this.selectedTeam.members[i] == userId) {
          return false;
        }
      }
      return true;
    }
  },

  async mounted() {
    const token = Cookies.get("token");
    this.userId = jwt_decode(token).id;
    this.teams = await getTeamsbyManagerId(this.userId);
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
