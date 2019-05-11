require('./bootstrap');

import Vue from 'vue';
import Vuetify from 'vuetify';
import router from './router'
import store from './store'
import mainApp from './MainApp'
import 'vuetify/dist/vuetify.min.css'

Vue.config.productionTip = false;

Vue.use(Vuetify, {
    theme: {
        primary: '#27cee8',
        secondary: '#424242',
        accent: '#82B1FF',
        error: '#FF5252',
        info: '#2196F3',
        success: '#4CAF50',
        warning: '#FFC107'
    }
})

router.beforeEach((to, from, next) => {
    if (to.meta.requireAuth && !store.getters.isAuthenticated) {
        router.push('/login/' + to.name)
    } else {
        next()
    }
})

new Vue({
    router,
    store,
    render: h => h(mainApp)
}).$mount('#app')