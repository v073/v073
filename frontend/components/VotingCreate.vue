<template>
    <div id="create">
        <md-card md-with-hover>

            <md-card-header>
                <div class="md-title">Create a voting</div>
            </md-card-header>

            <md-card-content>

                <md-field>
                    <label>Text</label>
                    <md-input v-model="form.text"></md-input>
                </md-field>

                <div class="md-layout md-gutter">
                    <div class="md-layout-item md-xsmall-size-100 md-small-size-60 md-medium-size-70 md-large-size-70 md-xlarge-size-70">
                        <md-field>
                            <md-select v-model="form.type" name="country" id="country" placeholder="Available options">
                                <md-option value="free">Define your own options</md-option>
                                <md-optgroup label="Predefined">
                                    <md-option v-for="(options, type_name) in form.types" :value="type_name">
                                        {{ options.join(' / ') }}
                                    </md-option>
                                </md-optgroup>
                            </md-select>
                        </md-field>

                    </div>
                    <div class="md-layout-item md-xsmall-size-100 md-small-size-40 md-medium-size-30 md-large-size-30 md-xlarge-size-30">
                        <md-field>
                            <label>Initial token number</label>
                            <md-input v-model="form.tokens" type="number"></md-input>
                        </md-field>
                    </div>
                </div>
            </md-card-content>

            <md-card-actions>
                <md-button class="md-raised md-primary" @click="createVoting">
                    Create voting
                </md-button>
            </md-card-actions>

        </md-card>

        <md-dialog :md-active="state == 'waiting'" id="create-voting-waiting">
            <md-dialog-title>Creating voting...</md-dialog-title>
            <md-dialog-content>
                <md-progress-spinner md-mode="indeterminate"/>
            </md-dialog-content>
        </md-dialog>

        <md-dialog :md-active="state == 'done' || state == 'really'" id="create-voting-success">
            <md-dialog-title>Voting created!</md-dialog-title>
            <md-dialog-content>
                <p>Your voting administration token is</p>
                <p id="voting-administration-token" :class="{'really': state == 'really'}">{{ token }}</p>
                <p>Please write it down!</p>
            </md-dialog-content>
            <md-dialog-actions>
                <md-button v-if="state == 'done'" @click="state = 'really'" class="md-primary md-raised">
                    OK
                </md-button>
                <md-button v-if="state == 'really'" to="/" class="md-accent md-raised">
                    OK!!!
                </md-button>
            </md-dialog-actions>
        </md-dialog>
    </div>
</template>

<style scoped>
#create-voting-waiting {
    text-align: center;
}
#create-voting-success {
    padding-left: 2em;
    padding-right: 2em;
}
#voting-administration-token {
    font-size: 2em;
}
#voting-administration-token.really {
    font-weight: bold;
    animation: blinkyblink .5s infinite;
}
@keyframes blinkyblink {
    0%      { color: black }
    25%     { color: red }
    50%     { color: yellow }
    75%     { color: green }
    100%    { color: blue }
}
</style>

<script>
import axios from 'axios'
export default {
    data: () => ({
        state: 'form', // form, waiting, done, really
        form: {
            types: {},
            text: '',
            type: null,
            tokens: 5,
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
            this.state = 'waiting';
            setTimeout(() => {this.state = 'done'; this.token = 'xnorfzt'}, 1000);
        },
    },
}
</script>
