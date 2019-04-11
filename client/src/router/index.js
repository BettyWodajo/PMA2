import Vue from 'vue'
import Router from 'vue-router'
import experts from '@/components/experts'
import PMA_INFO from '@/components/PMA_INFO'
import first_aid from '@/components/first_aid'
import index from '@/components/index'
import request from '@/components/request'
import blogs from '@/components/blogs'
import medical from '@/components/medical'
Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'index',
      component: index
    },
    {
      path: '/experts',
      name: 'experts',
      component:experts
    },
    {
      path: '/PMA_INFO',
      name: 'PMA_INFO',
      component:PMA_INFO
    },
    {
      path: '/first_aid',
      name: 'first_aid',
      component:first_aid
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
    },
    {
      path: '/medical',
      name: 'medical',
      component:medical
    }


  ]
})
