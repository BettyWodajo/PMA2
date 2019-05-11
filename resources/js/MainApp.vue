<template>
  <v-app>
    <v-content class="main-container">
        <router-view></router-view>
    </v-content>
  </v-app>
</template>

<script>
export default {};
</script>

<style lang="scss" scoped>
    .main-container {
        background: rgb(242, 251, 252);
    }
</style>
