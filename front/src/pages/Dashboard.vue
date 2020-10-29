<template>
  <div class="content">
    <div class="container-fluid">
      <drop-down-teams :setSelectedId="setSelectedId" v-if="role == 2 || role == 3"></drop-down-teams>

      <div class="row">
        <div class="col-md-4">
          <add-working-time
            :affectWorkingTimes="affectWorkingTimes"
            :add="true"
            :selectedUserId="selectedUserId"
            :key="selectedUserId"
          ></add-working-time>
        </div>
        <div class="col-md-8">
          <working-times-table
            ref="WorkingTimeTableRef"
            :mini="true"
            :selectedUserId="selectedUserId"
            :key="selectedUserId"
          ></working-times-table>
        </div>
      </div>
      <chart-manager :selectedUserId="selectedUserId"
            :key="selectedUserId"></chart-manager>
    </div>
  </div>
</template>

<script>
import Cookies from "js-cookie";
import jwt_decode from "jwt-decode";
import WorkingTimesTable from "../components/WorkingTimes/WorkingTimesTable";
import AddWorkingTime from "../components/WorkingTimes/AddWorkingTime";
import ChartManager from "../components/Charts/ChartManager";
import DropDownTeams from "../components/Team/DropDownTeams";

export default {
  name: "Dashboard",
  components: {
    AddWorkingTime,
    WorkingTimesTable,
    ChartManager,
    DropDownTeams
  },

  data() {
    return {
      selectedUserId: "",
      role: ""
    };
  },
  methods: {
    affectWorkingTimes() {
      this.$refs.WorkingTimeTableRef.affectWorkingTimes();
    },
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

<style scoped>
/* .dashboard {
  margin-top: 30px; */
/* } */
</style>
