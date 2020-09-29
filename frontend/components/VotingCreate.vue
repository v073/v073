<template>
    <div id="create">
        <md-card md-with-hover>

            <md-card-header>
                <div class="md-title">Create a voting</div>
            </md-card-header>

            <md-card-content>

                <md-field>
                    <label>Text</label>
                    <md-input v-model="text"></md-input>
                </md-field>

                <div class="md-layout md-gutter">
                    <div class="md-layout-item md-xsmall-size-100 md-small-size-60 md-medium-size-70 md-large-size-70 md-xlarge-size-70">
                        <md-field>
                            <md-select v-model="type" name="country" id="country" placeholder="Available options">
                                <md-option value="free">Define your own options</md-option>
                                <md-optgroup label="Predefined">
                                    <md-option v-for="(options, type_name) in types" :value="type_name">
                                        {{ options.join(' / ') }}
                                    </md-option>
                                </md-optgroup>
                            </md-select>
                        </md-field>

                    </div>
                    <div class="md-layout-item md-xsmall-size-100 md-small-size-40 md-medium-size-30 md-large-size-30 md-xlarge-size-30">
                        <md-field>
                            <label>Initial token number</label>
                            <md-input v-model="tokens" type="number"></md-input>
                        </md-field>

                    </div>
                </div>
            </md-card-content>

            <md-card-actions>
                <md-button class="md-raised md-primary">
                    Create voting
                </md-button>
            </md-card-actions>

        </md-card>
    </div>
</template>

<script>
import axios from 'axios'
export default {
    data: () => ({
        types: {},
        text: '',
        type: null,
        tokens: 5,
    }),
    mounted() {
        axios.get('/types/default').then(res => { this.types = res.data })
    },
}
</script>
