<template>
    <div id="create">

        <h1>Create a voting</h1>

        <div id="createform">
            <p>
                <label for="text">Text</label>
                <input type="text" id="text"
                    v-model="form.text"
                >
            </p>

            <p>
                <label for="options">Available Options</label>
                <select id="options"
                    v-model="form.type"
                >
                    <option value="free">Define your own options</option>
                    <optgroup label="Predefined">
                        <option
                            v-for="(options, type_name) in form.types"
                            :value="type_name"
                        >
                            {{ options.join(' / ') }}
                        </option>
                    </optgroup>
                </select>

                <button @click="createVoting">Create voting</button>
            </p>
        </div>

        <div id="create-voting-waiting" class="dialog"
            v-if="state == 'waiting'"
        >
            <h2>Creating voting...</h2>
        </div>

        <div id="create-voting-waiting" class="dialog"
            v-if="state == 'done'"
        >
            <h2>Voting created!</h2>
            <p>Your voting administration token is</p>
            <p id="voting-administration-token">{{ token }}</p>
            <p>Please write it down!</p>
        </div>

    </div>
</template>

<script>
module.exports = {
    name: 'Create',
    data: () => ({
        state: 'form', // form, waiting, done
        form: {
            types: {},
            text: '',
            type: null,
        },
        token: null,
    }),
    mounted() {
        axios.get('/types/default').then(res => {
            this.form.types = res.data
        })
    },
    methods: {
        createVoting() {

            // Prepare
            this.state = 'waiting';
            let type = this.form.type;

            // free: create a new type
            let creationPromise = (this.form.type == 'free') ?
                axios.post('/types').then(res => res.data.name)
                : Promise.resolve(this.form.type);

            // Create the voting
            creationPromise
                .then(type => axios.post('/voting', {
                    type: type,
                    text: this.form.text,
                }))
                .then(res => {
                    this.token = res.data.token;
                    this.state = 'done';
                });
        },
    },
}
</script>
