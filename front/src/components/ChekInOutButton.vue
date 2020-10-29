<template>
  <button
    v-if="lastClock.clockIn"
    type="submit"
    class="btn btn-fill button-style checkout-button"
    @click.prevent="setClock"
  >
    Check-out
  </button>
  <button
    v-else-if="!lastClock.clockIn"
    type="submit"
    class="btn btn-fill button-style checkin-button"
    @click.prevent="setClock"
  >
    Check-in
  </button>
</template>

<script>
import Cookies from "js-cookie";
import jwt_decode from "jwt-decode";
import {
  getLastClockbyUserId,
  createClock
} from "../api_wrapper/clocks/clocks";

export default {
  name: "CheckInOutButton",
  data() {
    return {
      lastClock: {
        date: "",
        clockIn: Boolean
      },
      userId: String
    };
  },
  methods: {
    setClock() {
      this.lastClock.clockIn = !this.lastClock.clockIn;
      const newClock = {
        time: new Date().toISOString(),
        status: this.lastClock.clockIn
      };
      createClock(this.userId, newClock);
    },

    async getLastClock() {
      const clock = await getLastClockbyUserId(this.userId);
      if (clock) {
        this.lastClock.date = clock.time;
        this.lastClock.clockIn = clock.status;
      } else {
        this.lastClock.clockIn = false;
      }
    }
  },

  beforeMount() {
    const token = Cookies.get("token");
    this.userId = jwt_decode(token).id;
    this.getLastClock();
  }
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
  &:focus {
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
  &:focus {
    background-color: lighten(#1dc7ea, 8%);
    border-color: lighten(#1dc7ea, 8%);
  }
}
</style>
