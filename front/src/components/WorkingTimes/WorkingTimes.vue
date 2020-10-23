<template>
  <div class="content">
    <div class="container-fluid">
      <div class="row">
        <div class="col-4">
          <add-working-time />
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
                    @click="handleDelete(row)"
                  >
                    <i class="fa fa-trash"></i>
                  </button>
                </td>
              </template>
            </l-table>
          </card>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Card from '../Cards/Card';
import LTable from 'src/components/Table';
import AddWorkingTime from './AddWorkingTime';

export default {
  name: 'WorkingTimes',
  components: { Card, LTable, AddWorkingTime },
  data() {
    return {
      userId: '',
      workingTimes: [],
      tableColumns: ['Start', 'End', 'Actions'],
    };
  },

  methods: {
    formatDates(date) {
      return `${date.toLocaleDateString('fr-FR')} at ${date.toLocaleTimeString(
        'fr-FR',
      )}`;
    },
    getWorkingTimes() {
      const now = new Date();
      const workingTimes = [
        {
          start: '2020-11-02 10:00:00',
          end: '2020-11-02 18:00:00',
        },
        {
          start: '2020-11-03 10:00:00',
          end: '2020-11-03 18:00:00',
        },
        {
          start: '2020-11-04 10:00:00',
          end: '2020-11-04 18:00:00',
        },
      ];
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
      alert('You want to edit: ', data);
    },
    handleDelete(data) {
      alert('You want to delete: ', data);
    },
    createWorkingTime() {},
    updateWorkingTime() {},
    deleteWorkingTime() {},
  },

  mounted() {
    this.workingTimes = this.getWorkingTimes();
  },
};
</script>

<style scoped>
.content {
  margin-top: 30px;
}
.button {
  margin-right: 10px;
}
</style>
