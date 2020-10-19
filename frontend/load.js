Vue.use(VueRouter)

const router = new VueRouter({routes: [
    {path: '/',         name: 'Start',  component: httpVueLoader('./components/TokenForm.vue')},
    {path: '/create',   name: 'Create', component: httpVueLoader('./components/Create.vue')},
    {path: '/about',    name: 'About',  component: httpVueLoader('./components/About.vue')},
]})

new Vue({
    router,
    el: '#frontend',
    components: {
        'V073': httpVueLoader('./App.vue'),
    },
})
