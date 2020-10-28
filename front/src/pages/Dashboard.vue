<template>
  <div class="content">
    <div class="container-fluid">
      <div class="row">
        <div class="col-md-4">
          <add-working-time
            :affectWorkingTimes="affectWorkingTimes"
            :add="true"
          ></add-working-time>
        </div>
        <div class="col-md-8">
          <working-times-table
            ref="WorkingTimeTableRef"
            :mini="true"
          ></working-times-table>
        </div>
      </div>
      <chart-manager></chart-manager>
    </div>
  </div>
</template>

<script>
import WorkingTimesTable from '../components/WorkingTimes/WorkingTimesTable';
import AddWorkingTime from '../components/WorkingTimes/AddWorkingTime';
import ChartManager from '../components/Charts/ChartManager';

export default {
  name: 'Dashboard',
  components: { AddWorkingTime, WorkingTimesTable, ChartManager },

  methods: {
    affectWorkingTimes() {
      this.$refs.WorkingTimeTableRef.affectWorkingTimes();
    },
  },
};
</script>

<style scoped>
/* .dashboard {
  margin-top: 30px; */
/* } */
</style>
