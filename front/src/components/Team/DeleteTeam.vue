<template>
  <card>
    <h4 slot="header" class="card-title">Delete a team</h4>
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
      <p class="form-error text-center">{{ formError }}</p>
      <div class="text-center">
        <button
          type="submit"
          class="btn btn-info btn-danger"
          @click.prevent="deleteTeam"
        >
          Delete
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
import { getAllTeams, deleteTeam, getTeamsbyManagerId } from "../../api_wrapper/teams/teams";
import BaseDropDown from "src/components/BaseDropdown.vue";
import { getConnexionType } from "../../helpers/getConnexionType";

export default {
  name: "DeleteTeam",
  components: { Card, BaseDropDown },
  props: {
    affectChange: Function
  },
  data() {
    return {
      userId: "",
      role: "",
      teams: [],
      selectedTeam: {
        name: "Select a team",
        id: "",
        members: []
      },
      formSuccess: "",
      formError: ""
    };
  },
  methods: {
    async deleteTeam() {
      if (getConnexionType() === "none") {
        alert(
          "Oops ! You must be connected to the Internet to use this feature"
        );
        return;
      }
      deleteTeam(this.selectedTeam.id);
      this.formSuccess = `The team ${this.selectedTeam.name} has been deleted`;
      this.selectedTeam = {
        name: "Select a team",
        id: "",
        members: []
      };
      this.refresh();
      this.affectChange();
    },
    affectSelected(team) {
      this.selectedTeam = team;
    },
    async refresh() {
      if (this.role === 3) {
        const res = await getAllTeams();
        this.teams = res.data;
      } else if (this.role === 2) {
        this.teams = await getTeamsbyManagerId(this.userId);
      }
    }
  },

  mounted() {
    const token = Cookies.get("token");
    this.userId = jwt_decode(token).id;
    this.role = jwt_decode(token).role;
    this.refresh();
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
</style>
