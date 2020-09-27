<template>
    <div class="page-container">
        <md-app md-mode="reveal">

            <md-app-toolbar class="md-accent">
                <span class="md-title">v073</span>
            </md-app-toolbar>

            <md-app-drawer md-permanent="full">
                <md-toolbar class="md-transparent" md-elevation="0">Navigation</md-toolbar>

                <md-list>

                    <md-list-item>
                        <md-icon>home</md-icon>
                        <span class="md-list-item-text">
                            <router-link to="/">Start</router-link>
                        </span>
                    </md-list-item>

                    <md-list-item>
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
.md-drawer {
    width: 230px;
    max-width: calc(100vw - 125px);
}
</style>

<script>
export default {
}
</script>
