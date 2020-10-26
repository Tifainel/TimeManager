<template>
  <div class="faq-panel">
    <top-navbar></top-navbar>
    <div class="faq-content" v-for="item in faqData" v-bind="item">
      <faq-section>
        <template slot="title">{{ item.title }}</template>
        <template slot="content">{{ item.content }}</template>
      </faq-section>
    </div>
    <content-footer></content-footer>
  </div>
</template>

<script>
import TopNavbar from '../layout/TopNavbar';
import ContentFooter from '../layout/ContentFooter.vue';
import FaqSection from '../components/Faq/FaqSection';
import faq from '../faq';

export default {
  name: 'Faq',
  components: { TopNavbar, ContentFooter, FaqSection },
  data() {
    return {
      faqData: faq,
    };
  },
  mounted() {
    console.log('data: ');
    console.log(this.faqData);
  },
};
</script>

<style scoped>
.faq-panel {
  background-color: rgba(203, 203, 210, 0.15);
  height: 100%;
}

.faq-content {
  width: 45%;
  margin-left: 30px;
}
</style>
