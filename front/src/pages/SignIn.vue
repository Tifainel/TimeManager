<template>
  <div class="content">
      <auth-card :connexion="false"></auth-card>
  </div>
</template>
<script>
import AuthCard from 'src/components/Cards/AuthCard.vue'

export default {
  name: 'SignIn',
  components: { AuthCard },

  data() {
    return {

    };
  },
  methods: {
    
  },
};
</script>
<style>
.content {
  display: flex;
  justify-content: center;
  background-color: rgba(203, 203, 210, 0.15) !important;
}
</style>
