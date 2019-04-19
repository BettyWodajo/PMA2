<template>
<v-app>
  <v-container fluid grid-list-md>
    <v-layout row wrap>
      <v-flex d-flex xs12 sm6 md4>
        <v-card color="blue lighten-2" dark>
          <v-card-title primary class="title">permission request</v-card-title>
          <v-card-text>Full Name: {{ expert.fName }}</v-card-text>
          <v-card-text>Email: {{ expert.email }}</v-card-text>
          <v-card-text>Address: {{ expert.address }}</v-card-text>
          <v-card-text>Specialization: {{ expert.specialization }}</v-card-text>
          <v-card-text>Job Location :{{ expert.jobLocation }}</v-card-text>
          <div>
    <v-btn color="success">Accept</v-btn>
    <v-btn color="error">Reject</v-btn>
  </div>
        </v-card>
      </v-flex>
      <v-flex d-flex xs12 sm6 md4>
         <v-card color="blue lighten-2" dark>
          <v-card-title primary class="title">permission request</v-card-title>
          <v-card-text>Full Name: {{ expert.fName }}</v-card-text>
          <v-card-text>Email: {{ expert.email }}</v-card-text>
          <v-card-text>Address: {{ expert.address }}</v-card-text>
          <v-card-text>Specialization: {{ expert.specialization }}</v-card-text>
          <v-card-text>Job Location :{{ expert.jobLocation }}</v-card-text>
          <div>
    <v-btn color="success">Accept</v-btn>
    <v-btn color="error">Reject</v-btn>
  </div>
        </v-card>
      </v-flex>
      <v-flex d-flex xs12 sm6 md4>
         <v-card color="blue lighten-2" dark>
          <v-card-title primary class="title">permission request</v-card-title>
          <v-card-text>Full Name: {{ expert.fName }}</v-card-text>
          <v-card-text>Email: {{ expert.email }}</v-card-text>
          <v-card-text>Address: {{ expert.address }}</v-card-text>
          <v-card-text>Specialization: {{ expert.specialization }}</v-card-text>
          <v-card-text>Job Location :{{ expert.jobLocation }}</v-card-text>
          <div>
    <v-btn color="success">Accept</v-btn>
    <v-btn color="error">Reject</v-btn>
  </div>
        </v-card>
      </v-flex>
    </v-layout>
  </v-container>
</v-app>
</template>
<script>
export default{
    name:'request',

     data(){
    return {
      expert:{
        fName: 'Abebe melese',
        email: 'abebe@gmail.com',
       address: 'Addis ababa',
        specialization: 'cardiac',
        jobLocation : 'tikur anbessa'
      },
     
    }
  }
}
</script>
