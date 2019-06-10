<template>
  <v-layout>
    <!-- Side navigation bar -->
    <v-navigation-drawer :clipped="clipped" v-model="drawer" enable-resize-watcher app>
      <v-list class="pt-0" dense>
        <v-divider></v-divider>
        <v-list-group value="true" prepend-icon="person" no-action>
          <template v-slot:activator>
            <v-list-tile to="/app/user">
              <v-list-tile-content>
                <v-list-tile-title>User</v-list-tile-title>
              </v-list-tile-content>
            </v-list-tile>
          </template>
          <v-list-tile to="/app/user/admins">
            <v-list-tile-content>
              <v-list-tile-title>Admin</v-list-tile-title>
            </v-list-tile-content>
            <v-list-tile-action>
              <v-icon>person</v-icon>
            </v-list-tile-action>
          </v-list-tile>
          <v-list-tile to="/app/user/experts">
            <v-list-tile-content>
              <v-list-tile-title>Expert</v-list-tile-title>
            </v-list-tile-content>
            <v-list-tile-action>
              <v-icon>person</v-icon>
            </v-list-tile-action>
          </v-list-tile>
          <v-list-tile to="/app/user/customers">
            <v-list-tile-content>
              <v-list-tile-title>Customer</v-list-tile-title>
            </v-list-tile-content>
            <v-list-tile-action>
              <v-icon>person</v-icon>
            </v-list-tile-action>
          </v-list-tile>
        </v-list-group>
        <v-list-tile to="/app/diseases">
            <v-list-tile-action>
                <v-icon>dns</v-icon>
            </v-list-tile-action>
            <v-list-tile-content>
                <v-list-tile-title>Diseases</v-list-tile-title>
            </v-list-tile-content>
        </v-list-tile>
        <v-list-tile to="/app/firstAid">
            <v-list-tile-action>
                <v-icon>local_hospital</v-icon>
            </v-list-tile-action>
            <v-list-tile-content>
                <v-list-tile-title>First aid</v-list-tile-title>
            </v-list-tile-content>
        </v-list-tile>
        <v-list-tile to="/app/blog">
            <v-list-tile-action>
                <v-icon>assignment</v-icon>
            </v-list-tile-action>
            <v-list-tile-content>
                <v-list-tile-title>Blog</v-list-tile-title>
            </v-list-tile-content>
        </v-list-tile>
      </v-list>
    </v-navigation-drawer>

    <!-- Top navigation bar -->
    <v-toolbar color="primary" dark app clipped-left dense>
      <v-toolbar-side-icon @click.stop="drawer = !drawer"></v-toolbar-side-icon>
      <v-toolbar-title>
        <small>{{title}}</small>
      </v-toolbar-title>
      <v-spacer></v-spacer>
      <v-toolbar-items>
        <v-btn flat @click="logout">
          <span>Logout</span>
          <v-icon right v-html="'fa-sign-out-alt'"></v-icon>
        </v-btn>
      </v-toolbar-items>
    </v-toolbar>
  </v-layout>
</template>

<script>
export default {
  data() {
    return {
      clipped: true,
      drawer: true,
      menu: false,
      sideNavLinks: [
        { icon: "people", link: "/app/user", name: "Users" },
        { icon: "person", link: "/app/disease", name: "Diseases" },
        { icon: "local_hospital", link: "/app/firstAid", name: "First aid"},
        { icon: "local_hospital", link: "/app/blog", name: "Blog"}
      ],
      title: "PMA"
    };
  },
  methods: {
    logout() {
      this.$store.dispatch("logout");
    }
  },
  computed: {
    isAuthenticated() {
      return this.$store.getters.isAuthenticated;
    },
    getName() {
      return (
        this.$store.state.userData.surname +
        " " +
        this.$store.state.userData.first_name +
        " " +
        this.$store.state.userData.middle_name
      );
    }
  }
};
</script>
