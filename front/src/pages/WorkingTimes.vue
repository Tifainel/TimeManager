<template>
  <div class="content">
    <div class="container-fluid">
        <drop-down-teams :setSelectedId="setSelectedId" v-if="role == 2 || role == 3"></drop-down-teams>
        <working-times-table :mini="false" :selectedUserId="selectedUserId" :key="selectedUserId"></working-times-table>
    </div>
  </div>
</template>
<script>

import Cookies from 'js-cookie';
import jwt_decode from 'jwt-decode';
import WorkingTimesTable from '../components/WorkingTimes/WorkingTimesTable'
import DropDownTeams from '../components/Team/DropDownTeams'

export default {
  name: 'WorkingTimes',
  components: { WorkingTimesTable, DropDownTeams },

  data() {
    return {
      selectedUserId: "",
      role: ""
    };
  },
  methods: {
    setSelectedId(id) {
      this.selectedUserId = id.toString();
    }
  },

  mounted() {
    const token = Cookies.get("token");
    this.role = jwt_decode(token).role;
  }
};
</script>
<style>
.row {
  display: flex;
  justify-content: center;
}
</style>
