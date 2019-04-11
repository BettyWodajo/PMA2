<template>
  <v-app>
  <v-toolbar color="grey">
    <v-toolbar-title> PMA</v-toolbar-title>
    <v-spacer></v-spacer>
    <v-toolbar-items class="hidden-sm-and-down">
      <v-btn flat router-link to="/request">All Requests</v-btn>
      <v-btn flat router-link to="/experts">Experts</v-btn>
      <v-btn flat router-link to="/blogs">Blogs</v-btn>
      <v-btn flat router-link to="/PMA_INFO">PMA informations</v-btn>
      <v-btn flat router-link to="/request">New posts</v-btn>

    </v-toolbar-items>
  </v-toolbar>
  <div class="container">
    <router-view/>
  </div>
</v-app>
</template>
<script>
export default{
    name:'index',

  };


</script>
