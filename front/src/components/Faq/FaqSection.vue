<template>
  <div>
    <h3 class="title"><slot name="title"></slot></h3>
    <hr class="separator" />
    <p class="text"><slot name="content"></slot></p>
  </div>
</template>

<script>
export default {
  name: 'FaqSection',
};
</script>

<style lang="scss" scoped>
.text {
  margin-left: 10px;
}
</style>
