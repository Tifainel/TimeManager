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
        @change="handleNbDaysChange"
      >
      </base-input>
      <p v-if="!available" style="text-align: center">
        No data available at this time
      </p>

      <line-chart
        id="chart_issue_24"
        :data="lineData"
        xkey="day"
        resize="true"
        ykeys='["time", "scheduled"]'
        labels='["Hours worked", "Scheduled hours"]'
        lineColors='[ "#36A2EB", "#FF6384" ]'
        :key="changed"
        v-if="available"
      >
      </line-chart>
    </card>
  </div>
</template>

<script>
import Cookies from "js-cookie";
import jwt_decode from "jwt-decode";
import Raphael from "raphael/raphael";
global.Raphael = Raphael;
import { getWorkingTimeAndClocked } from "../../api_wrapper/charts/charts";
import { LineChart } from "vue-morris";
import Card from "../Cards/Card";
import { getConnexionType } from "../../helpers/getConnexionType";

export default {
  name: "LineCard",
  components: { LineChart, Card },
  props: {
    selectedUserId: String
  },
  data() {
    return {
      nbDays: 7,
      lineData: [],
      userId: "",
      changed: true,
      available: false
    };
  },
  methods: {
    handleNbDaysChange() {
      if (getConnexionType() === "none") {
        alert(
          "Oops ! You must be connected to the Internet to use this feature"
        );
        return;
      }
      this.getData();
    },
    async getData() {
      const data = await getWorkingTimeAndClocked(this.userId, this.nbDays);
      if (data.error) {
        this.available = false;
      } else {
        this.lineData = data;
        for (let i in this.lineData) {
          this.lineData[i].scheduled = Math.round(this.lineData[i].scheduled / 3600);
          this.lineData[i].time = Math.round(this.lineData[i].time / 3600);
        }
        this.available = true;
        this.changed = !this.changed;
      }
    },
  },
  mounted() {
    if (!this.selectedUserId) {
      const token = Cookies.get("token");
      this.userId = jwt_decode(token).id;
    } else {
      this.userId = this.selectedUserId;
    }
    this.getData();
  }
};
</script>
<style scoped lang="scss">
.line-card {
  margin-top: 20px;
}
</style>
