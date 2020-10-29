<template>
  <div>
    <card class="content-card line-card">
      <template slot="header">
        <h4 class="card-title">
          Proportion of night and day hours
        </h4>
      </template>
      <base-input
        type="number"
        min="1"
        label="On the last ... days"
        placeholder="Number of days"
        v-model="nbDays"
      >
      </base-input>
      <line-chart
        id="chart_issue_24"
        :data="lineData"
        xkey="date"
        resize="true"
        ykeys='["timeWorked", "scheduledTime"]'
        labels='["Time worked", "Scheduled time"]'
        lineColors='[ "#FF6384", "#36A2EB" ]'
      >
      </line-chart>
    </card>
  </div>
</template>

<script>
import Raphael from 'raphael/raphael';
global.Raphael = Raphael;

import { LineChart } from 'vue-morris';
import Card from '../Cards/Card';

export default {
  name: 'LineCard',
  components: { LineChart, Card },
  data() {
    return {
      nbDays: 7,
      lineData: [
        { date: '2020-02-01', timeWorked: 10, scheduledTime: 5 },
        { date: '2020-02-02', timeWorked: 40, scheduledTime: 15 },
        { date: '2020-02-03', timeWorked: 20, scheduledTime: 25 },
        { date: '2020-02-04', timeWorked: 30, scheduledTime: 20 },
        { date: '2020-02-05', timeWorked: 30, scheduledTime: 20 },
      ],
    };
  },
};
</script>
<style scoped lang="scss">
.line-card {
  margin-top: 20px;
}
</style>
