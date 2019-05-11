<template>
  <div>
    <v-layout row wrap align-center>
      <v-flex sm8>
        <v-img style="max-height: 100vh;" src="/img/login_bg.jpg"></v-img>
      </v-flex>
      <v-flex xs12 sm4 class="pl-4 pr-4">
        <v-container grid-list-md>
          <v-card>
            <v-card-title primary-title>
              <v-flex xs12>
                <v-layout column align-center>
                  <v-flex class="mt-2">
                    <v-avatar size="100">
                      <v-img src="/img/user.png"></v-img>
                    </v-avatar>
                  </v-flex>
                </v-layout>
                <span class="error--text text-xs-left">{{authError}}</span>
              </v-flex>
              <v-layout row wrap>
                <v-flex>
                  <v-form v-model="valid" @keyup.native.enter="login" ref="form" lazy-validation>
                    <v-flex xs12>
                      <v-text-field
                        :disabled="loading"
                        label="E-mail"
                        v-model="email"
                        prepend-icon="mail"
                        :rules="[rules.email.required, rules.email.email]"
                        type="email"
                        :validate-on-blur="true"
                      ></v-text-field>
                    </v-flex>
                    <v-flex xs12>
                      <v-text-field
                        :disabled="loading"
                        v-model="password"
                        prepend-icon="lock"
                        :append-icon="show ? 'fa-eye-slash' : 'fa-eye'"
                        :rules="[rules.password.required]"
                        :type="show ? 'text' : 'password'"
                        name="password"
                        label="Password"
                        @click:append="show = !show"
                      ></v-text-field>
                    </v-flex>
                    <v-btn @click="login" :disabled="loading || !valid" color="primary">
                      <v-progress-circular v-if="loading" indeterminate color="primary"></v-progress-circular>
                      <span v-if="!loading">Login</span>
                    </v-btn>
                    <router-link :to="'/app'">sdxas</router-link>
                  </v-form>
                </v-flex>
              </v-layout>
            </v-card-title>
          </v-card>
        </v-container>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
import Axios from "axios";

export default {
  props: ['path'],
  data() {
    return {
      show: false,
      valid: true,
      email: "",
      password: "",
      rules: {
        password: {
          required: value => !!value || "Password is required."
        },
        email: {
          required: value => !!value || "Email is required.",
          email: value => {
            const pattern = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            return pattern.test(value) || "Invalid e-mail.";
          }
        }
      }
    };
  },
  methods: {
    login() {
      if (this.$refs.form.validate()) {
        this.$store.dispatch("login", {
          email: this.email,
          password: this.password,
          path: this.$route.params.path
        });
      }
    }
  },
  mounted() {
      let access_token = localStorage.getItem('access_token');
      if (access_token) {
          this.$store.dispatch('getUser', {'access_token': access_token, 'path': this.$route.params.path})
      }
  },
  computed: {
    url() {
      return this.$store.state.url;
    },
    authError() {
      return this.$store.state.authError;
    },
    loading() {
      return this.$store.state.loading;
    }
  }
};
</script>
