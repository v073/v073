<template>
    <p>Hi, I'm {{ name }}!</p>
</template>

<script>
export default {
    data() { return {
        name: "Voty McVoteface",
    }; }
};
</script>

<style scoped>
p { color: red }
</style>
