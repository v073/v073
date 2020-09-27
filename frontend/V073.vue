<template>
    <div class="page-container">
        <md-app md-mode="reveal">

            <md-app-toolbar class="md-accent">
                <md-button class="md-icon-button" @click="menuVisible = ! menuVisible">
                    <md-icon>menu</md-icon>
                </md-button>
                <span class="md-title">v073</span>
            </md-app-toolbar>

            <md-app-drawer :md-active.sync="menuVisible">
                <md-list>

                    <md-list-item @click="menuVisible = false">
                        <md-icon>home</md-icon>
                        <span class="md-list-item-text">
                            <router-link to="/">Start</router-link>
                        </span>
                    </md-list-item>

                    <md-list-item @click="menuVisible = false">
                        <md-icon>info</md-icon>
                        <span class="md-list-item-text">
                            <router-link to="/about">About v073</router-link>
                        </span>
                    </md-list-item>

                </md-list>
            </md-app-drawer>

            <md-app-content>
                <div class="md-layout md-alignment-center">
                    <div class="md-layout-item md-small-size-100 md-medium-size-75 md-large-size-50 md-xlarge-size-40">
                        <router-view/>
                    </div>
                </div>
            </md-app-content>

        </md-app>
    </div>
</template>

<style scoped>
.md-app {
    max-height: 100vh;
}
.md-title {
    font-weight: bold;
}
.md-drawer {
    width: 230px;
    max-width: calc(100vw - 125px);
}
</style>

<script>
export default {
    data: () => ({
        menuVisible: false
    })
}
</script>
