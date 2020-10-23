<template>
  <card class="content-card">
    <template slot="header">
      <h4 class="card-title" v-if="add">Add a new working shift</h4>
      <h4 class="card-title" v-else>Modify a working shift</h4>
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
      <div v-if="add">
        <button
          type="submit"
          class="btn btn-info btn-fill float-right center button-size"
          @click.prevent="createForm"
        >
          Add
        </button>
        <p class="form-success">{{ formSuccess }}</p>
      </div>
      <div v-else>
        <button
          type="submit"
          class="btn btn-info btn-fill float-left center button-size"
          @click.prevent="updateForm"
        >
          Modify
        </button>
        <button class="btn btn-cancel float-right center" @click="switchModal">
          Cancel
        </button>
      </div>
    </div>
  </card>
</template>

<script>
import Card from "src/components/Cards/Card";
import Cookies from "js-cookie";
import jwt_decode from "jwt-decode";
import { createWorkingtime } from "../../api_wrapper/workingtimes/workingtime";

export default {
  name: "AddWorkingTime",
  components: { Card },
  props: {
    affectWorkingTimes: {
      type: Function,
      required: true
    },
    switchModal: {
      type: Function
    },
    add: Boolean,
    selectedWorkingTime: Object
  },
  data() {
    return {
      dates: {
        startDate: "",
        endDate: "",
        startTime: "",
        endTime: ""
      },
      formError: "",
      formSuccess: "",
      userId: String
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
    checkForm() {
      if (!this.isFormValid()) {
        this.formError = "All fields must be filled";
        return;
      }
      this.formError = "";
      const start = new Date(
        `${this.dates.startDate} ${this.dates.startTime}:00`
      );
      const end = new Date(`${this.dates.endDate} ${this.dates.endTime}:00`);
      if (start > end) {
        this.formError = "Start date and time must be before end date and time";
        return;
      }
      return { start: start, end: end };
    },
    async createForm() {
      const isChecked = this.checkForm();
      if (isChecked) {
        const created = await createWorkingtime(this.userId, isChecked.start, isChecked.end);
        if (created.error) {
          this.formError = "An error has occured";
        } else {
          this.formSuccess = "This worktime has been created";
          this.affectWorkingTimes();
        }
      }
    },
    async updateForm() {
      console.log(selectedWorkingTime)
      const isChecked = this.checkForm();
      if (isChecked) {
        const updated = await updateWorkingtimeById(this.workingTimeId, isChecked.start, isChecked.end);
        if (updated.error) {
          this.formError = "An error has occured";
        } else {
          this.formSuccess = "This worktime has been updated";
          this.affectWorkingTimes();
          this.switchModal();
        }
      }
    },
  },
  mounted(){
    // console.log(selectedWorkingTime)
  },

  beforeMount() {
    const token = Cookies.get("token");
    this.userId = jwt_decode(token).id;
    console.log(this.add);
  }
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
.form-success {
  color: #58d68d;
  font-size: 14px;
  margin-top: 5px;
}
.button-size {
  width: 200px;
}
</style>
