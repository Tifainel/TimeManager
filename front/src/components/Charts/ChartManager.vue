<template>
  <div class="chart-manager">
    <div class="row">
      <div class="col-md-6">
        <donut-card :selectedUserId="selectedUserId"></donut-card>
      </div>
      <div class="col-md-6"><line-card :selectedUserId="selectedUserId"></line-card></div>
    </div>
    <div class="row">
      <div class="col-md-12"><bar-card :selectedUserId="selectedUserId"></bar-card></div>
    </div>
  </div>
</template>

<script>
import DonutCard from "./DonutCard";
import LineCard from "./LineCard";
import BarCard from "./BarCard";

export default {
  name: "ChartManager",
  components: { DonutCard, LineCard, BarCard },
  props: {
    selectedUserId: String
  }
};
</script>

<style scoped>
.chart-manager {
  background-color: #f7f7f8;
}
</style>
