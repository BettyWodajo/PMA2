<template>
  <div>
    <navbar></navbar>
    <v-container>
      <router-view></router-view>
    </v-container>
  </div>
</template>

<script>
import navbar from "../components/nav";
export default {
  components: {
    navbar
  }
};
</script>