import Vue from 'vue'
import VueMaterial from 'vue-material'
import 'vue-material/dist/vue-material.min.css'
import 'vue-material/dist/theme/default.css'
import V073 from './V073.vue'

Vue.use(VueMaterial)

new Vue({
    el: '#v073-frontend',
    render: h => h(V073)
})
