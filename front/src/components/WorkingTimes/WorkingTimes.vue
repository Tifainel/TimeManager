<template>
  <div class="content">
    <transition name="modal" v-if="showModal">
      <div class="modal-mask">
        <div class="modal-wrapper">
          <div class="modal-container">
            <add-working-time
              :affectWorkingTimes="affectWorkingTimes"
              :switchModal="switchModal"
              :add="false"
              :selectedWorkingTime="selectedWorkingTime"
            ></add-working-time>
          </div>
        </div>
      </div>
    </transition>
    <div class="container-fluid">
      <div class="row">
        <div class="col-4">
          <add-working-time
            :affectWorkingTimes="affectWorkingTimes"
            :add="true"
          ></add-working-time>
        </div>
        <div class="col-8">
          <card
            class="strpied-tabled-with-hover card"
            body-classes="table-full-width table-responsive"
          >
            <template slot="header">
              <h4 class="card-title">Upcoming working shifts</h4>
            </template>
            <l-table
              class="table table-hover table-striped"
              :columns="tableColumns"
              :data="workingTimes"
            >
              <template slot="columns"> </template>
              <template slot-scope="{ row }">
                <td>{{ row.start }}</td>
                <td>
                  {{ row.end }}
                </td>
                <td>
                  <button
                    class="btn btn-icon btn-info button"
                    @click="handleEdit(row)"
                  >
                    <i class="fa fa-edit"></i>
                  </button>
                  <button
                    class="btn btn-icon btn-danger"
                    @click="handleDelete(row.id)"
                  >
                    <i class="fa fa-trash"></i>
                  </button>
                </td>
              </template>
            </l-table>
          </card>
        </div>
        <modal v-if="showModal" @close="switchModal">
          <h3 slot="header">custom header</h3>
        </modal>
      </div>
    </div>
  </div>
</template>

<script>
import Cookies from "js-cookie";
import jwt_decode from "jwt-decode";
import Card from "../Cards/Card";
import LTable from "src/components/Table";
import AddWorkingTime from "./AddWorkingTime";
import {
  getAllWorkingTimesByUserId,
  deleteWorkingtimeById
} from "../../api_wrapper/workingtimes/workingtime";

export default {
  name: "WorkingTimes",
  components: { Card, LTable, AddWorkingTime },
  data() {
    return {
      userId: "",
      workingTimes: [],
      tableColumns: ["Start", "End", "Actions"],
      showModal: false,
      selectedWorkingTime: ""
    };
  },

  methods: {
    formatDates(date) {
      return `${date.toLocaleDateString("fr-FR")} at ${date.toLocaleTimeString(
        "fr-FR"
      )}`;
    },

    async getWorkingTimes() {
      const now = new Date();
      // end date is 50 years later
      const endDate = new Date();
      endDate.setFullYear(endDate.getFullYear() + 50);
      const workingTimes = await getAllWorkingTimesByUserId(
        this.userId,
        now.toISOString(),
        endDate.toISOString()
      );
      workingTimes.splice(3);
      for (const time in workingTimes) {
        const dateStart = new Date(workingTimes[time].start);
        const dateEnd = new Date(workingTimes[time].end);
        if (dateStart < now) workingTimes.splice(time, 1);
        else {
          workingTimes[time].start = this.formatDates(dateStart);
          workingTimes[time].end = this.formatDates(dateEnd);
        }
      }
      return workingTimes;
    },
    handleEdit(data) {
      this.selectedWorkingTime = data;
      this.showModal = true;
    },
    handleDelete(workingtimeId) {
      if (confirm("Do you really want to delete this working time ?")) {
        this.deleteWorkingTime(workingtimeId);
      }
    },
    createWorkingTime() {},
    updateWorkingTime() {},
    async deleteWorkingTime(workingtimeId) {
      const deleted = await deleteWorkingtimeById(workingtimeId);
      if (!deleted.error) {
        console.log("deleted");
      }
      this.affectWorkingTimes();
    },
    async affectWorkingTimes() {
      this.workingTimes = await this.getWorkingTimes();
    },
    switchModal() {
      this.showModal = !this.showModal;
    }
  },

  mounted() {
    const token = Cookies.get("token");
    this.userId = jwt_decode(token).id;
    this.affectWorkingTimes();
  }
};
</script>

<style scoped>
.content {
  margin-top: 30px;
}
.button {
  margin-right: 10px;
}

.modal-mask {
  position: fixed;
  z-index: 9998;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  display: table;
  transition: opacity 0.3s ease;
}

.modal-wrapper {
  display: table-cell;
  vertical-align: middle;
}

.modal-container {
  width: 500px;
  margin: 0px auto;
  background-color: #fff;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.33);
  transition: all 0.3s ease;
  font-family: Helvetica, Arial, sans-serif;
}

.modal-header h3 {
  margin-top: 0;
  color: #42b983;
}

.modal-body {
  margin: 20px 0;
}

.modal-default-button {
  float: right;
}

/*
 * The following styles are auto-applied to elements with
 * transition="modal" when their visibility is toggled
 * by Vue.js.
 *
 * You can easily play with the modal transition by editing
 * these styles.
 */

.modal-enter {
  opacity: 0;
}

.modal-leave-active {
  opacity: 0;
}

.modal-enter .modal-container,
.modal-leave-active .modal-container {
  -webkit-transform: scale(1.1);
  transform: scale(1.1);
}
</style>
