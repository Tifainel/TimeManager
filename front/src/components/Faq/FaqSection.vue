<template>
  <div>
    <card class="faq-card">
      <template slot="header">
        <h3 class="title"><slot name="title"></slot></h3>
        <hr class="separator" />
      </template>
      <p class="text"><slot name="content"></slot></p>
    </card>
  </div>
</template>

<script>
export default {
  name: 'FaqSection',
};
</script>

<style lang="scss" scoped>
.title {
  margin: 0 0 10px 0;
}
.faq-card {
  margin: 20px 0;
  display: flex;
  align-items: start;
}
.text {
  margin-left: 10px;
}
.separator {
  margin: 0;
  width: 300px;
  background-color: #95edff;
}
</style>
