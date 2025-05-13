import './assets/main.css'

// main.js
import { createApp } from 'vue'
import App from './App.vue'

// Buefy + Bulma
import Buefy from 'buefy'
import 'buefy/dist/buefy.css'
import './assets/bulma.scss'

// Icons
import '@mdi/font/css/materialdesignicons.css'

const app = createApp(App)
app.use(Buefy, {
  defaultIconPack: 'mdi'
})

app.mount('#app')
