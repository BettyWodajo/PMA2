<template>
  <div>
    <v-card-title>users</v-card-title>
    <v-card-text>
      <v-data-table :headers="headers" :items="users" class="elevation-1">
        <template v-slot:items="props">
          <td>{{ props.item.full_name }}</td>
          <td>{{ props.item.email }}</td>
          <td>{{ props.item.address }}</td>
          <td>{{ props.item.role }}</td>
        </template>
      </v-data-table>
    </v-card-text>
  </div>
</template>

<script>
import Axios from "axios";
export default {
  data() {
    return {
      headers: [
        { text: "Full name", value: "full_name" },
        { text: "Email", value: "email" },
        { text: "Address", value: "address" },
        { text: "Role", value: "role" }
      ],
      users: []
    };
  },
  mounted() {
    this.getAllUsers();
  },
  methods: {
    getAllUsers() {
      Axios.get(
        "/api/users?token=" + this.$store.state.userData.access_token
      ).then(res => {
        console.log(res.data);
        this.users = res.data;
      });
    }
  }
};
</script>
