<template>
  <card class="content-card">
    <template slot="header">
      <h4 class="card-title">Add a new working shift</h4>
    </template>
    <div class="form-container">
      <div class="row">
        <div class="col-md-6">
          <base-input type="date" label="Start date" v-model="dates.startDate">
          </base-input>
        </div>
        <div class="col-md-6">
          <base-input type="date" label="End date" v-model="dates.endDate">
          </base-input>
        </div>
        <div class="col-md-6">
          <base-input type="time" label="Start time" v-model="dates.startTime">
          </base-input>
        </div>
        <div class="col-md-6">
          <base-input type="time" label="End time" v-model="dates.endTime">
          </base-input>
        </div>
      </div>
      <p class="form-error">{{ formError }}</p>
      <button
        type="submit"
        class="btn btn-info btn-fill float-right center button-size"
        @click.prevent="updateProfile"
      >
        Add
      </button>
    </div>
  </card>
</template>

<script>
import Card from 'src/components/Cards/Card';

export default {
  name: 'AddWorkingTime',
  components: { Card },
  data() {
    return {
      dates: {
        startDate: '',
        endDate: '',
        startTime: '',
        endTime: '',
      },
      formError: '',
    };
  },
  methods: {
    isFormValid() {
      return (
        this.dates.startDate &&
        this.dates.endDate &&
        this.dates.endTime &&
        this.dates.startTime
      );
    },
    updateProfile() {
      if (!this.isFormValid()) {
        this.formError = 'All fields must be filled';
        return;
      }
      this.formError = '';
      const start = new Date(
        `${this.dates.startDate} ${this.dates.startTime}:00`,
      );
      const end = new Date(`${this.dates.endDate} ${this.dates.endTime}:00`);
      if (start > end) {
        this.formError = 'Start date and time must be before end date and time';
      }
    },
  },
};
</script>

<style scoped>
.form-container {
  display: flex;
  flex-direction: column;
  align-items: center;
}
.content-card {
  min-height: 200px;
}
.center {
  text-align: center;
}
.form-error {
  color: #fc6b74;
  font-size: 14px;
  margin-bottom: 5px;
}
.button-size {
  width: 200px;
}
</style>
