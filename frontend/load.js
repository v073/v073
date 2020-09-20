import Vue from 'vue'
import V073 from './V073.vue'

window.addEventListener("load", function() {
    new Vue({
        el: '#v073-frontend',
        render: h => h(V073)
    })
});
