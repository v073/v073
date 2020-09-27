import Vue from 'vue'
import VueRouter from 'vue-router'
Vue.use(VueRouter)

import VueMaterial from 'vue-material'
import 'vue-material/dist/vue-material.min.css'
import 'vue-material/dist/theme/default.css'
Vue.use(VueMaterial)

import V073 from './V073.vue'

import Start    from './components/Start.vue'
import About    from './components/About.vue'

const router = new VueRouter({routes: [
    {path: '/',         component: Start},
    {path: '/about',    component: About},
]})

new Vue({
    router,
    el: '#v073-frontend',
    render: h => h(V073)
})
