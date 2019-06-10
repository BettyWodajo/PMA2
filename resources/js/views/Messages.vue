<template>
  <v-container>
    <v-layout align-center justify-center>
      <v-flex md7>
        <v-card>
          <v-card-title class="header">Messages</v-card-title>
          <v-card-text class="messages">
            <v-list>
              <v-list-tile :to="'/chat/' + id + '/' + message.from" v-for="message in messages" :key="message.id">
                <v-list-tile-avatar>
                  <v-icon>person</v-icon>
                </v-list-tile-avatar>
                <v-list-tile-content>
                  <v-list-tile-title>{{message.sender.full_name}}</v-list-tile-title>
                  <v-list-tile-sub-title>{{message.text}}</v-list-tile-sub-title>
                </v-list-tile-content>
              </v-list-tile>
            </v-list>
          </v-card-text>
        </v-card>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import Axios from "axios";
export default {
  props: {
    id: {
      default: 0
    }
  },
  data() {
    return {
      messages: []
    };
  },
  mounted() {
      this.getMessages();
  },
  methods: {
    getMessages() {
      Axios.get("/api/messages/" + this.id).then(res => {
        this.messages = res.data;
        console.log(res.data)
      });
    }
  }
};
</script>