<template>
  <div class="drop-down">
    <form>
      <base-drop-down tag="div" :title="selectedName" id="select">
        <a class="dropdown-item" @click="setSelected()">Me</a>
        <div v-for="team in teams" :key="team.id" v-show="loaded">
          <p class="label">{{ team.name }}</p>
          <div v-for="member in team.members" :key="member.id">
            <a class="dropdown-item" @click="setSelected(member)">
              {{ member.username }}
            </a>
          </div>
        </div>
      </base-drop-down>
      <div class="clearfix"></div>
    </form>
  </div>
</template>
<script>
import Cookies from "js-cookie";
import jwt_decode from "jwt-decode";
import TeamMemberCard from "src/components/Cards/TeamMemberCard.vue";
import { getTeamsbyManagerId, modifyTeam } from "../../api_wrapper/teams/teams";
import BaseDropDown from "src/components/BaseDropdown.vue";
import { getUserById } from "../../api_wrapper/users/users";

export default {
  name: "DropDownTeams",
  components: { BaseDropDown, TeamMemberCard },
  props: {
    setSelectedId: Function,
  },
  data() {
    return {
      userId: "",
      teams: "",
      selectedName: "Me",
      loaded: false
    };
  },
  methods: {
    async getMembersForTeams(teams) {
      for (const team in teams) {
        if (this.teams[team].members) {
          for (const member in this.teams[team].members) {
            this.teams[team].members[member] = await getUserById(
              this.teams[team].members[member]
            );
          }
        } else {
        }
      }
      this.loaded = true;
    },
    setSelected(member) {
      if (!member) {
        this.setSelectedId(this.userId);
        this.selectedName = "Me";
      } else {
        this.setSelectedId(member.id);
        this.selectedName = member.username;
      }
    },
  },

  async mounted() {
    const token = Cookies.get("token");
    this.userId = jwt_decode(token).id;
    this.teams = await getTeamsbyManagerId(this.userId);
    this.getMembersForTeams(this.teams);
  },
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
  cursor: pointer;
}
.label {
  padding: 5px;
  background-color: aliceblue;
  margin: 0px;
}
.drop-down {
  width: 200px;
  background-color: white;
}
</style>
