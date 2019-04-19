import Vue from 'vue'
import Router from 'vue-router'
import experts from '@/components/experts'
import PMA_INFO from '@/components/PMA_INFO'
import first_aid from '@/components/first_aid'
import index from '@/components/index'
import request from '@/components/request'
import blogs from '@/components/blogs'
import medical from '@/components/medical'
import login from '@/components/login'
Vue.use(Router)

export default new Router({
  routes: [
  {
    path: '/',
    name: 'login',
    component: login,
  },
    {
      path: '/index',
      name: 'index',
      component: index,
      children:[
          {path: '/experts',
          component:experts},
          {
            path: '/PMA_INFO',
            name: 'PMA_INFO',
            component:PMA_INFO,
            children:[
              {
                path: '/first_aid',
                name: 'first_aid',
                component:first_aid
              },
              {
                path: '/medical',
                name: 'medical',
                component:medical
              }
            ]

          },
          {
            path: '/request',
            name: 'request',
            component:request
          },
          {
            path: '/blogs',
            name: 'blogs',
            component:blogs
          }


      ]
    }


  ]
})
