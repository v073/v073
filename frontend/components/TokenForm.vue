<template>
    <div id="tokenform">
        <h1>Welcome to v073!</h1>
        <router-link :to="{name: 'Create'}" tag="button">Create a new voting</router-link>
    </div>
</template>

<script>
module.exports = {
    name: 'TokenForm',
}
</script>
