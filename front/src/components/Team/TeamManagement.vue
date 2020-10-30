<template>
  <div class="container-fluid">
    <div class="row">
      <div class="col-sm-6">
        <create-team :affectChange="affectChange"></create-team>
      </div>
      <div class="col-sm-6">
        <modify-members :key="changed" :affectChange="affectChange"></modify-members>
      </div>
    </div>
    <div class="row">
      <div class="col-sm-6">
        <add-member :key="changed" :affectChange="affectChange"></add-member>
      </div>
      <div class="col-sm-6">
        <delete-team :key="changed" :affectChange="affectChange"></delete-team>
      </div>
    </div>
  </div>
</template>
<script>
import Cookies from 'js-cookie';
import jwt_decode from 'jwt-decode';
import CreateTeam from './CreateTeam.vue';
import ModifyMembers from './ModifyMembers.vue';
import AddMember from './AddMember.vue';
import DeleteTeam from './DeleteTeam.vue';

export default {
  name: 'TeamManagement',
  components: { CreateTeam, ModifyMembers, AddMember, DeleteTeam },

  data() {
    return {
      changed: false
    };
  },
  methods: {
    affectChange() {
      this.changed = !this.changed
    }
  },
};
</script>
<style>
.row {
  display: flex;
  justify-content: center;
}
</style>
