<template>
  <div>
    <v-layout style="max-height: 100vh;" row wrap align-center>
      <v-flex sm8>
        <v-img style="max-height: 100vh;" src="/img/login_bg.jpg"></v-img>
      </v-flex>
      <v-flex xs12 sm4 class="pl-4 pr-4 scrollable">
        <v-container grid-list-md>
          <v-card>
            <v-card-title primary-title>
              <v-flex xs12>
                <!-- <span class="error--text text-xs-left">{{authError}}</span> -->
              </v-flex>
              <v-layout row wrap>
                <v-flex>
                  <v-form v-model="valid" @keyup.native.enter="login" ref="form" lazy-validation>
                    <v-flex xs12>
                      <v-text-field
                        :disabled="loading"
                        label="Full name"
                        v-model="user.full_name"
                        prepend-icon="person"
                        type="text"
                        :error-messages="signupError['full_name'] ? signupError['full_name'] : ''"
                        :rules="[rules.required.required]"
                        :validate-on-blur="true"
                      ></v-text-field>
                    </v-flex>
                    <v-flex xs12>
                      <v-text-field
                        :disabled="loading"
                        label="E-mail"
                        v-model="user.email"
                        prepend-icon="mail"
                        @keyup="removeError('email')"
                        :error-messages="signupError['email'] ? signupError['email'] : ''"
                        :rules="[rules.email.required, rules.email.email]"
                        type="email"
                        :validate-on-blur="true"
                      ></v-text-field>
                    </v-flex>
                    <v-flex xs12>
                      <v-text-field
                        :disabled="loading"
                        v-model="user.password"
                        prepend-icon="lock"
                        :append-icon="show ? 'fa-eye-slash' : 'fa-eye'"
                        :rules="[rules.password.required]"
                        :error-messages="signupError['password'] ? signupError['password'] : ''"
                        :type="show ? 'text' : 'password'"
                        name="password"
                        label="Password"
                        @click:append="show = !show"
                      ></v-text-field>
                    </v-flex>
                    <v-flex xs12>
                      <v-text-field
                        :disabled="loading"
                        v-model="user.address"
                        prepend-icon="map"
                        :error-messages="signupError['address'] ? signupError['address'] : ''"
                        :rules="[rules.required.required]"
                        type="text"
                        name="address"
                        label="Address"
                      ></v-text-field>
                    </v-flex>
                    <v-flex xs12>
                      <v-select
                        prepend-icon="lock"
                        v-model="user.role"
                        :items="roles"
                        :rules="[rules.required.required]"
                        :error-messages="signupError['role'] ? signupError['role'] : ''"
                        item-text="name"
                        item-value="value"
                        label="Role"
                      ></v-select>
                    </v-flex>
                    <v-flex xs12>
                      <v-select
                        v-if="user.role === 'customer'"
                        prepend-icon="lock"
                        v-model="customer.disease_id"
                        :items="diseases"
                        :error-messages="signupError['disease'] ? signupError['disease'] : ''"
                        :rules="[rules.required.required]"
                        item-text="name"
                        item-value="id"
                        label="Disease"
                      ></v-select>
                    </v-flex>
                    <v-flex xs12>
                      <v-select
                        v-if="user.role === 'expert'"
                        prepend-icon="lock"
                        v-model="expert.specialization_area"
                        :items="diseases"
                        :error-messages="signupError['specialization_area'] ? signupError['specialization_area'] : ''"
                        item-text="name"
                        item-value="id"
                        :rules="[rules.required.required]"
                        label="Specialization area"
                      ></v-select>
                    </v-flex>
                    <v-flex xs12>
                      <v-text-field
                        v-if="user.role === 'expert'"
                        :disabled="loading"
                        v-model="expert.job_location"
                        prepend-icon="map"
                        :rules="[rules.required.required]"
                        :error-messages="signupError['job_location'] ? signupError['job_location'] : ''"
                        type="text"
                        name="job_location"
                        label="Job location"
                      ></v-text-field>
                    </v-flex>
                    <v-btn @click="signup" :disabled="loading || !valid" color="primary">
                      <v-progress-circular v-if="loading" indeterminate color="primary"></v-progress-circular>
                      <span v-if="!loading">Signup</span>
                    </v-btn>
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
  data() {
    return {
      show: false,
      valid: true,
      roles: [
        {
          name: "Customer",
          value: "customer"
        },
        {
          name: "Expert",
          value: "expert"
        }
      ],
      diseases: [
        {
          name: "test",
          id: 1
        }
      ],
      customer: {
        disease_id: ""
      },
      expert: {
        job_location: "",
        specialization_area: ""
      },
      user: {
        email: "elnataldebebe@gmail.com",
        password: "password",
        full_name: "",
        role: "",
        address: ""
      },
      rules: {
        required: {
          required: value => !!value || "This field is required."
        },
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
    signup() {
      if (this.$refs.form.validate()) {
        let user = this.user;
        if (this.user.role === "customer") {
          user["disease_id"] = this.customer.disease_id;
        } else if (this.user.role === "expert") {
          user["job_location"] = this.expert.job_location;
          user["specialization_area"] = this.expert.specialization_area;
        }
        this.$store.dispatch("register", user);
      }
    },
    removeError(name) {
      if (this.signupError[name]) {
        this.$store.state.signupError[name] = null
      }
    }
  },
  computed: {
    loading() {
      return this.$store.state.loading;
    },
    signupError() {
      return this.$store.state.signupError
    }
  }
};
</script>

<style lang="scss" scoped>
.scrollable {
  height: 100vh;
  overflow-y: scroll;
}
</style>
