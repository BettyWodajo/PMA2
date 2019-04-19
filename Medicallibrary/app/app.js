import Vue from 'nativescript-vue';

import MasterPage from './components/MasterPage';

// Uncommment the following to see NativeScript-Vue output logs
// Vue.config.silent = false;

new Vue({

  render: h => h('frame', [h(MasterPage)])

}).$start();
