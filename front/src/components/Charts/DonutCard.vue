<template>
  <div>
    <card class="content-card donut-card">
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
        @change="handleNbDaysChange"
      >
      </base-input>
      <donut-chart
        class="donut-chart"
        id="donut"
        :data="donutData"
        colors='[ "#FF6384", "#36A2EB" ]'
        resize="true"
        :key="changed"
      >
      </donut-chart>
    </card>
  </div>
</template>
<script>
import Cookies from "js-cookie";
import jwt_decode from "jwt-decode";
import Raphael from "raphael/raphael";
global.Raphael = Raphael;
import { getDayNightChart } from "../../api_wrapper/charts/charts";
import { DonutChart } from "vue-morris";
import Card from "../Cards/Card";

export default {
  name: "DonutCard",
  components: { DonutChart, Card },
  data() {
    return {
      userId: '',
      nbDays: 5,
      donutData: [
        { label: "Day", value: 0 },
        { label: "Night", value: 0 }
      ],
      changed: true
    };
  },
  methods: {
    handleNbDaysChange() {
      this.getData();
    },
    async getData() {
      const data = await getDayNightChart(this.userId, this.nbDays);
      this.donutData[0].value = data.totalDay / 3600;
      this.donutData[1].value = data.totalNight / 3600;
      this.changed = !this.changed;
    }
  },
  async beforeMount() {
    const token = Cookies.get("token");
    this.userId = jwt_decode(token).id;
    this.getData();
  }
};
</script>
<style scoped lang="scss">
.donut-card {
  margin-top: 20px;
}
</style>
