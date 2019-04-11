<template>

<navbar class="indigo" dark>
  <!-- Navbar brand -->
  <mdb-navbar-brand href="https://mdbootstrap.com/">
  PMA
  </mdb-navbar-brand>
  <navbar-collapse>
    <navbar-nav>
      <navbar-item ><router-link to="/experts">ALL EXPERTS </router-link></navbar-item>
      <navbar-item ><router-link to="">REQUESTS</router-link></navbar-item>
      <navbar-item ><router-link to="/PMA_INFO">PMA INFORMATIONS</router-link></navbar-item>
      <navbar-item ><router-link to="">BLOGS</router-link></navbar-item>
      <navbar-item ><router-link to="">NEW POSTS</router-link></navbar-item>
    </navbar-nav>
    <!-- Search form -->
    <form class="form-inline">
      <input class="form-control mr-auto p-2" type="text" placeholder="Search" aria-label="Search">
    </form>
  </navbar-collapse>
</navbar>


</template>
<script>
import { Navbar, NavbarItem, NavbarNav, NavbarCollapse, mdbNavbarBrand,Dropdown, DropdownToggle,DropdownMenu,DropdownItem } from 'mdbvue';
export default{
    name:'school_admin',
    components: {
    Navbar,
    NavbarItem,
    NavbarNav,
    NavbarCollapse,
    mdbNavbarBrand,
    Dropdown,
    DropdownToggle,
    DropdownMenu,
    DropdownItem

  }

}
</script>
