<template>
  <div class="container-fluid dashboard">
      <div class="row">
        <div class="col-4">
          <add-working-time
            :affectWorkingTimes="affectWorkingTimes"
            :add="true"
          ></add-working-time>
        </div>
        <div class="col-8">
          <working-times-table ref="WorkingTimeTableRef" :mini="true"></working-times-table>
        </div>
      </div>
  </div>
</template>

<script>
import WorkingTimesTable from '../components/WorkingTimes/WorkingTimesTable';
import AddWorkingTime from "../components/WorkingTimes/AddWorkingTime";

export default {
  name: 'Dashboard',
  components: { AddWorkingTime, WorkingTimesTable },

  methods: {
    affectWorkingTimes() {
      this.$refs.WorkingTimeTableRef.affectWorkingTimes();
    },
  }
}
</script>

<style scoped>
.dashboard {
  min-height: 87%;
  margin-top: 30px;
}
</style>