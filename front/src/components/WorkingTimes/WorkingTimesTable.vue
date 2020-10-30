<template>
  <div>
    <transition name="modal" v-if="showModal">
      <div class="modal-mask">
        <div class="modal-wrapper">
          <div class="modal-container" :class="isMobile ? 'mobile-modal' : ''">
            <add-working-time
              :affectWorkingTimes="affectWorkingTimes"
              :switchModal="switchModal"
              :add="false"
              :selectedId="selectedId"
            ></add-working-time>
          </div>
        </div>
      </div>
    </transition>
    <card
      class="strpied-tabled-with-hover card"
      body-classes="table-full-width table-responsive"
    >
      <template slot="header">
        <h4 class="card-title" v-if="mini">Upcoming working shifts</h4>
        <h4 class="card-title" v-else>All future working shifts</h4>
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
              @click="handleEdit(row.id)"
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
</template>

<script>
import Cookies from 'js-cookie';
import jwt_decode from 'jwt-decode';
import Card from '../Cards/Card';
import LTable from 'src/components/Table';
import AddWorkingTime from './AddWorkingTime';
import {
  getAllWorkingTimesByUserId,
  deleteWorkingtimeById,
} from '../../api_wrapper/workingtimes/workingtime';

export default {
  name: 'WorkingTimesTable',
  components: {
    Card,
    LTable,
    AddWorkingTime,
  },
  props: {
    mini: {
      type: Boolean,
      required: true,
    },
    selectedUserId: String,
  },
  computed: {
    isMobile() {
      if (screen.width <= 760) {
        return true;
      } else {
        return false;
      }
    },
  },
  data() {
    return {
      userId: '',
      workingTimes: [],
      tableColumns: ['Start', 'End', 'Actions'],
      showModal: false,
      selectedId: String,
    };
  },

  methods: {
    formatDates(date) {
      return `${date.toLocaleDateString('fr-FR')} at ${date.toLocaleTimeString(
        'fr-FR',
        {
          hour: '2-digit',
          minute: '2-digit',
        },
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
        endDate.toISOString(),
      );
      const workingtimetable = [];
      for (const time in workingTimes) {
        const dateStart = new Date(workingTimes[time].start);
        const dateEnd = new Date(workingTimes[time].end);
        if (dateStart < now) {
          workingtimetable.push(time);
        } else {
          workingTimes[time].start = this.formatDates(dateStart);
          workingTimes[time].end = this.formatDates(dateEnd);
        }
      }
      for (const element in workingtimetable) {
        workingTimes.splice(element, 1);
      }
      if (this.mini == true) {
        workingTimes.splice(3);
      }
      return workingTimes;
    },
    handleEdit(id) {
      this.selectedId = id.toString();
      this.showModal = true;
      window.scrollTo(0, 0);
    },
    handleDelete(workingtimeId) {
      if (confirm('Do you really want to delete this working time ?')) {
        this.deleteWorkingTime(workingtimeId);
      }
    },
    async deleteWorkingTime(workingtimeId) {
      const deleted = await deleteWorkingtimeById(workingtimeId);
      this.affectWorkingTimes();
    },
    async affectWorkingTimes() {
      this.workingTimes = await this.getWorkingTimes();
    },
    switchModal() {
      this.showModal = !this.showModal;
    },
  },

  mounted() {
    if (!this.selectedUserId) {
      const token = Cookies.get('token');
      this.userId = jwt_decode(token).id;
    } else {
      this.userId = this.selectedUserId;
    }
    this.affectWorkingTimes();
  },
};
</script>

<style scoped>
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
.mobile-modal {
  width: 95%;
}
</style>
