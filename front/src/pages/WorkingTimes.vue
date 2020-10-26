<template>
  <div class="content">
    <div class="container-fluid">
        <working-times-table :mini="false"></working-times-table>
    </div>
  </div>
</template>
<script>

import Cookies from 'js-cookie';
import jwt_decode from 'jwt-decode';
import WorkingTimesTable from '../components/WorkingTimes/WorkingTimesTable'

export default {
  name: 'WorkingTimes',
  components: { WorkingTimesTable },

  data() {
    return {
      email: '',
      username: '',
      userId: '',
    };
  },
  methods: {
    
  },

  async mounted() {

  },
};
</script>
<style>
.row {
  display: flex;
  justify-content: center;
}
</style>
