<template>
    <div id="v073">

        <header>
            <h1>
                <router-link :to="{name: 'Start'}">v073</router-link>
            </h1>
        </header>

        <nav>
            <ul>
                <li><router-link :to="{name: 'Start'}">Start</router-link></li>
                <li><router-link :to="{name: 'About'}">About v073</router-link></li>
            </ul>
        </nav>

        <main>
            <router-view/>
        </main>

        <footer>
            <p id="copyright">
                &copy; 2020
                <a href="https://mirko.westermeier.de/">Mirko Westermeier</a>
            </p>
            <p
                v-if="$route.name != 'About'"
                id="about-link"
            >
                <router-link to="/about">About v073</router-link>
            </p>
        </footer>

    </div>
</template>

<script>
module.exports = {
    name: 'V073',
}
</script>
