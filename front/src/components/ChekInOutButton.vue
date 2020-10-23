<template>
  <button
    v-if="lastClock.isWorking"
    type="submit"
    class="btn btn-fill button-style checkout-button"
    @click.prevent="getLastClock"
  >
    Check-out
  </button>
  <button
    v-else-if="!lastClock.isWorking"
    type="submit"
    class="btn btn-fill button-style checkin-button"
    @click.prevent="getLastClock"
  >
    Check-in
  </button>
</template>

<script>
export default {
  name: 'CheckInOutButton',
  data() {
    return {
      lastClock: {
        date: '',
        isWorking: true,
      },
    };
  },
  methods: {
    getLastClock() {
      this.lastClock.isWorking = !this.lastClock.isWorking;
    },
  },

  serverPrefetch() {
    // this.getLastClock();
  },
};
</script>

<style scoped lang="scss">
.button-style {
  margin: 10px 0 0 20px;
  width: 80%;
}

.checkout-button {
  background-color: #ff4a55;
  border-color: #ff4a55;
  &:hover {
    background-color: #ee2d20;
    border-color: #ee2d20;
  }
}

.checkin-button {
  background-color: #1dc7ea;
  border-color: #1dc7ea;
  &:hover {
    background-color: lighten(#1dc7ea, 8%);
    border-color: lighten(#1dc7ea, 8%);
  }
}
</style>
