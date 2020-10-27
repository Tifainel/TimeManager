<template>
  <div class="content">
    <auth-card :connexion="true"></auth-card>
  </div>
</template>
<script>
import AuthCard from "src/components/Cards/AuthCard.vue";

export default {
  name: "SignUp",
  components: { AuthCard },

  data() {
    return {};
  },
  methods: {}
};
</script>
<style>
.content {
  display: flex;
  justify-content: center;
}
</style>
