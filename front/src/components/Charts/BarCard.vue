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
        xkey="day"
        labels='[ "Hours" ]'
        ykeys='[ "time"]'
      >
      </bar-chart>
    </card>
  </div>
</template>

<script>
import Cookies from "js-cookie";
import jwt_decode from "jwt-decode";
import Raphael from "raphael/raphael";
global.Raphael = Raphael;
import { getTimePerDay } from "../../api_wrapper/charts/charts";
import { BarChart } from "vue-morris";
import Card from "../Cards/Card";
import { getConnexionType } from "../../helpers/getConnexionType";

export default {
  name: "BarCard",
  components: { BarChart, Card },
  props: {
    selectedUserId: String
  },
  data() {
    return {
      nbDays: 7,
      barData: [],
      userId: ""
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
      const data = await getTimePerDay(this.userId, this.nbDays);
      if (data.error) {
        this.available = false;
      } else {
        this.barData = data;
        for (let i in this.barData) {
          this.barData[i].time = Math.round(this.barData[i].time / 3600);
        }
        this.available = true;
        this.changed = !this.changed;
      }
    }
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
.bar-card {
  margin-top: 20px;
}
</style>
