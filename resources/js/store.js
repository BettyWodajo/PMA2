import Vue from 'vue'
import Vuex from 'vuex'
import router from './router'
import Axios from 'axios'

Vue.use(Vuex)

export default new Vuex.Store({
    state: {
        userData: {
            access_token: '',
            expires_in: null,
            user: null
        },
        loading: false,
        loadingMessage: '',
        authError: '',
        signupError: []
    },
    getters: {
        isAuthenticated(status) {
            return (status.userData.access_token !== '')
        }
    },
    mutations: {
        startLoading(state, payload) {
            state.loadingMessage = payload
            state.loading = true
        },
        stopLoading(state) {
            state.loadingMessage = ''
            state.loading = false
        },
        setUserData(state, paylode) {
            state.userData = paylode;
            localStorage.setItem('access_token', paylode.access_token)
            state.authError = '';
            state.loading = false;
            if (paylode.path) {
                router.push({'name': paylode.path})
            } else {
                router.push('/app/')
            }
        },
        logout(state) {
            localStorage.removeItem('access_token')
            state.userData = { access_token: '', user: null }
            router.push('/login')
        }
    },
    actions: {
        login({ commit, state }, payload) {
            state.loading = true
            Axios.post('/api/auth/login', { email: payload.email, password: payload.password })
                .then(response => {
                    if (response.data.user.role === 'admin') {
                        response.data['path'] = payload.path;
                        commit('setUserData', response.data);
                    } else {
                        state.authError = 'Unauthorized';
                        state.loading = false;
                    }
                })
                .catch(error => {
                    state.loading = false;
                    state.authError = 'Something went wrong';
                })
        },
        logout({ commit, state }) {
            Axios.post('/api/auth/logout?token=' + state.userData.access_token)
                .then(
                    res => {
                        commit('logout')
                    }
                ).catch(
                    error => {
                        console.log(error)
                    }
                )
        },
        getUser({ commit }, payload) {
            Axios.get('/api/auth/me?token=' + payload.access_token)
                .then(
                    (res) => {
                        var data = {
                            access_token: payload.access_token,
                            user: res.data,
                            path: payload.path
                        }
                        commit('setUserData', data)
                        this.authError = ''
                    }
                )
                .catch(() => {
                    commit('logout')
                })
        },
        register({ commit, dispatch, state }, payload) {
            console.log(payload);

            Axios.post('/api/register', payload)
                .then(
                    res => {
                        dispatch('login', { 'email': payload.email, 'password': payload.password })
                    },
                    error => {
                        if (error.response.status == 422) {
                            state.signupError = error.response.data.errors
                        }
                    }
                )
        }
    }
})
