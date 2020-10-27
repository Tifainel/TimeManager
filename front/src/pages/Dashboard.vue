<template>
  <div class="dashboard">
    <working-times></working-times>
    <donut></donut>
  </div>
</template>

<script>
import WorkingTimes from '../components/WorkingTimes/WorkingTimes';
import Donut from '../components/Donut';

export default {
  name: 'Dashboard',
  components: { WorkingTimes, Donut },
};
</script>

<style scoped>
.dashboard {
  min-height: 87%;
  margin-top: 30px;
}
</style>
