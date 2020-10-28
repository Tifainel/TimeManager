<template>
  <div>
    <card class="content-card bar-card">
      <template slot="header">
        <h4 class="card-title">
          Time worked per day
        </h4>
      </template>
      <base-input
        class="lol"
        type="number"
        min="7"
        label="On the last ... days"
        placeholder="Number of days"
        v-model="nbDays"
        @change="handleNbDaysChange"
      >
      </base-input>
      <bar-chart
        class="bar-chart"
        id="bar"
        :data="barData"
        bar-colors='[ "#36A2EB" ]'
        resize="true"
        xkey="days"
        labels='[ "Hours" ]'
        ykeys='[ "time"]'
      >
      </bar-chart>
    </card>
  </div>
</template>

<script>
import Raphael from 'raphael/raphael';
global.Raphael = Raphael;

import { BarChart } from 'vue-morris';
import Card from '../Cards/Card';

export default {
  name: 'BarCard',
  components: { BarChart, Card },
  data() {
    return {
      nbDays: 7,
      barData: [
        { days: '10/11/2020', time: 8 },
        { days: '11/11/2020', time: 0 },
        { days: '12/11/2020', time: 10 },
        { days: '13/11/2020', time: 9 },
        { days: '14/11/2020', time: 8 },
        { days: '15/11/2020', time: 12 },
        { days: '16/11/2020', time: 4 },
      ],
    };
  },

  methods: {
    handleNbDaysChange() {
      this.barData = [];
      for (let i = 0; i < this.nbDays; i++) {
        this.barData.push({
          days: `${i + 1}/11/2020`,
          time: Math.floor(Math.random() * 12),
        });
      }
    },
  },
};
</script>
<style scoped lang="scss">
.bar-card {
  margin-top: 20px;
}
</style>
