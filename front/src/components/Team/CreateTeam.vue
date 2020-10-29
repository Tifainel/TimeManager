<template>
  <card>
    <h4 slot="header" class="card-title">Create a team</h4>
    <form>
      <base-input
        type="text"
        label="Team Name"
        placeholder="Team name"
        v-model="name"
      >
      </base-input>
      <p class="form-error text-center">{{ formError }}</p>
      <div class="text-center">
        <button
          type="submit"
          class="btn btn-info btn-fill float-right"
          @click.prevent="createTeam"
        >
          Submit
        </button>
      </div>
      <p class="form-success text-center">{{ formSuccess }}</p>
      <div class="clearfix"></div>
    </form>
  </card>
</template>
<script>
import Cookies from "js-cookie";
import jwt_decode from "jwt-decode";
import Card from "src/components/Cards/Card.vue";
import { createTeam } from "../../api_wrapper/teams/teams";

export default {
  name: "CreateTeam",
  components: { Card },
  props: {
    affectChange: Function
  },
  data() {
    return {
      userId: "",
      name: "",
      members: [],
      formError: "",
      formSuccess: ""
    };
  },
  methods: {
    async createTeam() {
      if (!this.name) {
        this.formError = "You must add a name";
        return;
      }
      this.formError = "";
      const data = {
        "userId": this.userId,
        "name": this.name,
        "member": this.members
      }
      const created = await createTeam(data);
      if (created.error) {
        this.formError = "An error has occured";
      } else {
        this.formSuccess = "This team has been created";
        this.affectChange();
      }
    }
  },

  mounted() {
    const token = Cookies.get("token");
    this.userId = jwt_decode(token).id;
  }
};
</script>
<style>
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
</style>
