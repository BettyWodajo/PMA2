<template>
  <v-container>
    <v-layout align-center justify-center>
      <v-flex md7>
        <v-card>
          <v-card-title
            class="header"
          >{{ selectedContact? selectedContact.full_name : 'Select contact'}}</v-card-title>
          <v-card-text class="messages">
            <div class="feed" ref="feed">
              <ul v-if="to">
                <li
                  v-for="message in messages"
                  :class="`message${message.to == to ? ' sent' : ' received'}`"
                  :key="message.id"
                >
                  <div class="text">{{ message.text }}</div>
                </li>
              </ul>
            </div>
          </v-card-text>
          <v-card-actions class="footer">
            <v-layout row wrap>
              <v-flex md11>
                <v-text-field v-model="message" @keydown.enter="send" placeholder="Message ..."></v-text-field>
              </v-flex>
              <v-flex md1>
                <v-btn @click="send" small fab class="primary">
                  <v-icon>send</v-icon>
                </v-btn>
              </v-flex>
            </v-layout>
          </v-card-actions>
        </v-card>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import Axios from "axios";
export default {
  props: {
    to: {
      default: 0
    },
    from: {
      default: 0
    }
  },
  data() {
    return {
      selectedContact: null,
      messages: [],
      done: false,
      message: ""
    };
  },
  mounted() {
    this.done = false;
    Axios.get("/api/user/" + this.to).then(res => {
      this.startConversationWith(res.data);
      this.selectedContact = res.data;

      Echo.channel("message" + this.to).listen("newMessage", e => {
        this.handleImcomingMessage(e.message);
        console.log("new message");
      });
    });
  },
  watch: {
    contact(contact) {
      this.scrollToBottom();
    },
    messages(messages) {
      this.scrollToBottom();
    }
  },
  methods: {
    scrollToBottom() {
      setTimeout(() => {
        this.$refs.feed.scrollTop =
          this.$refs.feed.scrollHeight - this.$refs.feed.clientHeight;
      }, 50);
    },
    send(e) {
      e.preventDefault();

      if (this.message !== "") {
        Axios.post("/api/message/send", {
          to: this.selectedContact.id,
          from: this.from,
          text: this.message
        }).then(res => {
          this.saveNewMessage(res.data);
        });

        this.message = "";
      }
    },
    startConversationWith() {
      Axios.get("/api/conversation/" + this.from + "/" + this.to).then(res => {
        this.messages = res.data;
        this.done = true;
      });
    },
    saveNewMessage(message) {
      this.messages.push(message);
    },
    handleImcomingMessage(message) {
      if (this.selectedContact && message.from == this.selectedContact.id) {
        this.saveNewMessage(message);
        return;
      }
      alert(message.text);
    }
  }
};
</script>

<style lang="scss" scoped>
.header {
  border-bottom: 1px solid rgb(194, 191, 191);
}
.footer {
  border-top: 1px solid rgb(194, 191, 191);
}
.messages {
  padding: 0;
  .feed {
    background: #f0f0f0;
    height: 100%;
    max-height: 320px;
    min-height: 320px;
    overflow: scroll;

    ul {
      list-style-type: none;
      padding: 5px;

      li {
        &.message {
          margin: 10px 0;
          width: 100%;

          .text {
            max-width: 200px;
            border-radius: 5px;
            padding: 12px;
            display: inline-block;
          }

          &.received {
            text-align: left;

            .text {
              background: #b2b2b2;
            }
          }

          &.sent {
            text-align: right;

            .text {
              background: #81c4f9;
            }
          }
        }
      }
    }
  }
}
</style>
