<template>
  <card>
    <h4 slot="header" class="card-title">Manage a team</h4>
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
      <div class="members" v-if="selectedTeam.id">
        <team-member-card
          :user="member"
          :deleteMemberFromTeam="deleteMemberFromTeam"
          v-for="member in membersInfo"
          :key="member.id"
        ></team-member-card>
      </div>
      <div class="clearfix"></div>
    </form>
  </card>
</template>
<script>
import Cookies from "js-cookie";
import jwt_decode from "jwt-decode";
import Card from "src/components/Cards/Card.vue";
import TeamMemberCard from "src/components/Cards/TeamMemberCard.vue";
import { getTeamsbyManagerId, modifyTeam } from "../../api_wrapper/teams/teams";
import BaseDropDown from "src/components/BaseDropdown.vue";
import { getUserById } from "../../api_wrapper/users/users";
import { getConnexionType } from "../../helpers/getConnexionType";

export default {
  name: "ModifyMembers",
  components: { Card, BaseDropDown, TeamMemberCard },
  props: {
    affectChange: Function
  },
  data() {
    return {
      userId: "",
      teams: "",
      selectedTeam: {
        name: "Select a team",
        id: "",
        members: []
      },
      membersInfo: []
    };
  },
  methods: {
    async affectSelected(team) {
      this.membersInfo = [];
      this.selectedTeam = team;
      if (this.selectedTeam.members) {
        for (const member in this.selectedTeam.members) {
          const memberInfo = await getUserById(
            this.selectedTeam.members[member]
          );
          this.membersInfo.push(memberInfo);
        }
      }
    },
    deleteMemberFromTeam(userId) {
      if (getConnexionType() === 'none') {
        alert("Oops ! You must be connected to the Internet to use this feature");
        return;
      }
      for (const member in this.selectedTeam.members) {
        if (userId == this.selectedTeam.members[member]) {
          this.selectedTeam.members.splice(member, 1);
          break;
        }
      }
      for (const member in this.membersInfo) {
        if (this.membersInfo[member].id == userId) {
          this.membersInfo.splice(member, 1);
          break;
        }
      }
      modifyTeam(this.selectedTeam.id, this.selectedTeam);
      this.affectChange();
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
.members {
  display: flex;
  flex-direction: column;
}
</style>
