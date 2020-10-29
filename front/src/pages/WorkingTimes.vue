<template>
  <div class="content">
    <div class="container-fluid">
        <drop-down-teams :setSelectedId="setSelectedId"></drop-down-teams>
        <working-times-table :mini="false" :selectedUserId="selectedUserId"></working-times-table>
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
      selectedUserId: ""
    };
  },
  methods: {
    setSelectedId(id) {
      this.selectedUserId = id.toString();
    }
  },

  async mounted() {

  },
};
</script>
<style>
.row {
  display: flex;
  justify-content: center;
}
</style>
