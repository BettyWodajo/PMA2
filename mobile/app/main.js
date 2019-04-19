import Vue from 'nativescript-vue'
import App from './components/App'
import store from './store';
import Vuetify from 'vuetify';
import VueRouter from 'vue-router';
import Vue from 'nativescript-vue'
Vue.use(Vuetify);
Vue.use(VueRouter)
Vue.registerElement('sidedrawer', ()=> require('nativescript-ui-sidedrawer').sidedrawer)


new Vue({
  store,
  render: h => h('frame', [h(App)])
}).$start()
