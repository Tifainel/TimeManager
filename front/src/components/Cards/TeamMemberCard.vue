<template>
  <div class="member">
    <i class="nc-icon nc-single-02" id="head" />
    {{ user.username }}
    <i class="nc-icon nc-simple-remove align" @click="deleteMemberFromTeam(user.id)" />
  </div>
</template>
<script>
import { getUserById } from "../../api_wrapper/users/users";

export default {
  name: "TeamMemberCard",
  components: {},
  props: {
    user: Object,
    deleteMemberFromTeam: Function
  },
  data() {
    return {};
  },
  methods: {

  },
  async mounted() {}
};
</script>
<style>
.member {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: #f2f2f2;
  border-radius: 2px;
  margin-bottom: 3px;
}
.align {
  cursor: pointer;
  padding-right: 10px;
}
#head {
  padding-left: 10px;
}
</style>
