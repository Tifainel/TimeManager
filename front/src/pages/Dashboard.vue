<template>
  <div class="dashboard"><working-times></working-times></div>
</template>

<script>
import WorkingTimes from '../components/WorkingTimes/WorkingTimes';

export default {
  name: 'Dashboard',
  components: { WorkingTimes },
};
</script>

<style scoped>
.dashboard {
  min-height: 87%;
}
</style>
