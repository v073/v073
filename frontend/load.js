import Vue from 'vue'
import VueRouter from 'vue-router'
Vue.use(VueRouter)

import VueMaterial from 'vue-material'
import 'vue-material/dist/vue-material.min.css'
import 'vue-material/dist/theme/default.css'
Vue.use(VueMaterial)

import V073 from './V073.vue'

import TokenForm    from './components/TokenForm.vue'
import AboutV073    from './components/AboutV073.vue'

const router = new VueRouter({routes: [
    {path: '/',         component: TokenForm},
    {path: '/about',    component: AboutV073},
]})

new Vue({
    router,
    el: '#v073-frontend',
    render: h => h(V073)
})
