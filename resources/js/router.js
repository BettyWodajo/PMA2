import Vue from 'vue'
import Router from 'vue-router'
import Login from './views/Login'
import Signup from './views/Signup'
import App from './views/App'
import Test from './views/Test'
import User from './views/user/User'
import Users from './views/user/Users'
import Admin from './views/user/admin/Admins'
import Expert from './views/user/expert/Experts'
import Customer from './views/user/customer/Customers'
import Diseases from './views/Diseases'
import FirstAid from './views/FirstAid'
import Blog from './views/Blog'
import SingleBlog from './views/SingleBlog'
import Chat from './views/Chat'
import Messages from './views/Messages'

Vue.use(Router)

export default new Router({
    routes: [{
        path: '/',
        redirect: '/login'
    },
    {
        path: '/login/:path?',
        name: 'login',
        props: true,
        component: Login
    },
    {
        path: '/signup',
        name: 'signup',
        component: Signup
    }, {
        path: '/chat/:from/:to',
        name: 'chat',
        props: true,
        component: Chat
    },{
        path: '/messages/:id',
        name: 'messages',
        props: true,
        component: Messages
    },
    {
        path: '/app',
        component: App,
        children: [
            {
                path: '',
                name: 'test',
                component: Test,
                meta: {
                    requireAuth: true
                }
            }, {
                path: 'blog',
                name: 'blog',
                component: Blog,
                meta: {
                    requireAuth: true
                }
            }, {
                path: 'blog/:id',
                name: 'single-blog',
                props: true,
                component: SingleBlog,
                meta: {
                    requireAuth: true
                }
            }, {
                path: 'user',
                component: User,
                children: [
                    {
                        path: '',
                        name: 'users',
                        component: Users,
                        meta: {
                            requireAuth: true
                        }
                    },
                    {
                        path: 'admins',
                        name: 'admins',
                        component: Admin,
                        meta: {
                            requireAuth: true
                        }
                    },
                    {
                        path: 'experts',
                        name: 'experts',
                        component: Expert,
                        meta: {
                            requireAuth: true
                        }
                    },
                    {
                        path: 'customers',
                        name: 'customers',
                        component: Customer,
                        meta: {
                            requireAuth: true
                        }
                    }
                ],
                meta: {
                    requireAuth: true
                }
            },
            {
                path: 'diseases',
                name: 'diseases',
                component: Diseases,
                meta: {
                    requireAuth: true
                }
            },
            {
                path: 'firstAid',
                name: 'firstAid',
                component: FirstAid,
                meta: {
                    requireAuth: true
                }
            }
        ],
        meta: {
            requireAuth: true
        }
    }
    ],
    mode: 'history'
})