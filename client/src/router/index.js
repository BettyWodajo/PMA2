import Vue from 'vue'
import Router from 'vue-router'
import test from '@/components/test'
import main from '@/components/main'
import experts from '@/components/experts'
import PMA_INFO from '@/components/PMA_INFO'
import first_aid from '@/components/first_aid'
import medical_library from '@/components/medical_library'


Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'main',
      component: main
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
      path: '/medical_library',
      name: 'medical_library',
      component:medical_library
    }

  ]
})
