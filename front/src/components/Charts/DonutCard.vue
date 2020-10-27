<template>
  <div>
    <card class="content-card donut-card">
      <template slot="header">
        <h4 class="card-title">
          Proportion of night and day hours
        </h4>
      </template>
      <base-input
        class="lol"
        type="number"
        min="1"
        label="On the last ... days"
        placeholder="Number of days"
        v-model="nbDays"
        @change="handleNbDaysChange"
      >
      </base-input>
      <donut-chart
        class="donut-chart"
        id="donut"
        :data="donutData"
        colors='[ "#FF6384", "#36A2EB" ]'
        resize="true"
      >
      </donut-chart>
    </card>
  </div>
</template>
<script>
import Raphael from 'raphael/raphael';
global.Raphael = Raphael;

import { DonutChart } from 'vue-morris';
import Card from '../Cards/Card';

export default {
  name: 'DonutCard',
  components: { DonutChart, Card },
  data() {
    return {
      nbDays: 7,
      donutData: [
        { label: 'Day', value: 100 },
        { label: 'Night', value: 30 },
      ],
    };
  },
  methods: {
    handleNbDaysChange() {
      this.donutData = [
        { label: 'Day', value: 10 * this.nbDays },
        { label: 'Night', value: 5 * this.nbDays },
      ];
    },
  },
};
</script>
<style scoped lang="scss">
.donut-card {
  margin-top: 20px;
}
</style>
