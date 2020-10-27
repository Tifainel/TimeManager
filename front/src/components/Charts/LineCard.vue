<template>
  <div>
    <card class="content-card line-card">
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
      >
      </base-input>
      <line-chart
        class="line-chart"
        id="line"
        :data="lineData"
        line-colors='[ "#FF6384", "#36A2EB" ]'
        resize="true"
        xkey="year"
        ykeys='[ "a", "b" ]'
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
        { year: '2013', a: 10, b: 5 },
        { year: '2014', a: 40, b: 15 },
        { year: '2015', a: 20, b: 25 },
        { year: '2016', a: 30, b: 20 },
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
