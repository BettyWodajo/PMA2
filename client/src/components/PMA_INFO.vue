<template>
  <v-app>
  <v-toolbar color="cyan">

    <v-toolbar-items class="hidden-sm-and-down">
      <v-btn flat router-link to="/first_aid">First Aid</v-btn>

      <v-btn flat router-link to="/medical">Medical Library</v-btn>

    </v-toolbar-items>
    <v-spacer></v-spacer>
    <v-btn icon>
     <v-icon>search</v-icon>
   </v-btn>
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
