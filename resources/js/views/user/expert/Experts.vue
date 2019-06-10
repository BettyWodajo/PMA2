<template>
  <div>
    <v-card-title>Experts</v-card-title>
    <v-card-text>
      <v-data-table :headers="headers" :items="users" class="elevation-1">
        <template v-slot:items="props">
          <td>{{ props.item.full_name }}</td>
          <td>{{ props.item.email }}</td>
          <td>{{ props.item.address }}</td>
          <td>{{ props.item.role }}</td>
          <td>
              <v-btn small class="error" @click="deactivate(props.item.id)" :disabled="props.item.active === 0">Deactivate</v-btn>
              <v-btn small class="success" @click="activate(props.item.id)" :disabled="props.item.active === 1">Activate</v-btn>
          </td>
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
        { text: "Role", value: "role" },
        { text: "Actions", value: "actions" }
      ],
      users: []
    };
  },
  mounted() {
    this.getExperts();
  },
  methods: {
    getExperts() {
      this.$store.commit('startLoading', 'Fetching experts data');
      Axios.get(
        "/api/expert?token=" + this.$store.state.userData.access_token
      ).then(res => {
        this.users = res.data;
        this.$store.commit('stopLoading');
      });
    },
    activate(id) {
      this.$store.commit('startLoading', 'Activating user account');
      Axios.get('/api/user/activate/' + id + '?token=' + this.$store.state.userData.access_token)
      .then(
        res => {
          this.getExperts();
        },
        error => {
          console.error(error);
        }
      )
    },
    deactivate(id) {
      this.$store.commit('startLoading', 'Deactivating user account');
      Axios.get('/api/user/deactivate/' + id + '?token=' + this.$store.state.userData.access_token)
      .then(
        res => {
          this.getExperts();
        }
      )
    }
  }
};
</script>
