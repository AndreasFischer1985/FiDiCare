<script setup>
  import fidicare from './data/fidicare.json';

  const columns = [
    { field: 'id', label: '#', sortable: true },
    { field: 'name', label: 'Produktname', searchable: true, sortable: true },
    { field: 'type', label: 'Arbeitsart', sortable: true },
    { field: 'technology', label: 'Technologie', sortable: true },
    { field: 'description', label: 'Beschreibung', searchable: true },
  ]

  const colors = [
    {"type": "planmäßig-rationale Arbeit (prA)", "color": "dark"},
    {"type": "Interaktionsarbeit (iA)", "color": "info"},
    {"type": "Wissensbasierte Arbeit (wA)", "color": "danger"}
  ]
</script>

<template>
  <section class="section theme-light">
    <div class="container">
      <div class="columns">
        <div class="column">
          <b-field label="Arbeitsart" grouped group-multiline>
            <b-button size="is-small" @click="selectedTypes = []" :type="selectedTypes.length == 0 ? 'is-primary' : ''" class="mr-3 has-text-weight-bold">Alle anzeigen</b-button>
            <b-checkbox-button v-model="selectedTypes" v-for="(item, index) in uniqueTypes" :native-value="item" :type="getTypeColor(item, colors)" size="is-small">{{ item }}</b-checkbox-button>
          </b-field>

          <b-field label="Technologie" grouped group-multiline>
            <b-button size="is-small" @click="selectedTechnologies = []" :type="selectedTechnologies.length == 0 ? 'is-primary' : ''" class="mr-3 has-text-weight-bold">Alle anzeigen</b-button>
            <b-checkbox-button v-model="selectedTechnologies" v-for="(item, index) in uniqueTechnologies" :native-value="item" size="is-small">{{ item }}</b-checkbox-button>
          </b-field>

          <b-field label="Anzahl">
            <span class="tag is-primary mr-1">{{ entries.length }}</span>
            <span class="has-text-primary"> Pflegeprodukte</span>
          </b-field>
        </div>

        <div class="column">
        </div>
      </div>


      <b-table
        :data="entries"
        :columns="columns"
        sort-icon="chevron-up"
        sortIconSize="is-small"
        sort-icon-desc="chevron-down"
        default-sort-direction="asc"
        default-sort="id"
        paginated
        per-page="10">
      </b-table>
    </div>
  </section>
</template>

<script>
    export default {
        data() {
            return {
                selectedTypes: [],
                selectedTechnologies: []
            }
        },
        computed: {
          entries: function () {
            // Daten ggfs. filtern und bereit stellen
            return fidicare.filter(item =>
              (this.selectedTypes.length === 0 || this.selectedTypes.includes(item.type)) &&
              (this.selectedTechnologies.length === 0 || this.selectedTechnologies.includes(item.technology))
            )
          },
          uniqueTypes: function () {
            return [...new Set( fidicare.map(eintrag => eintrag.type) )]; // Eindeutige Werte aus den Daten filtern
          },
          uniqueTechnologies: function () {
            return [...new Set( fidicare.map(eintrag => eintrag.technology) )]; // Eindeutige Werte aus den Daten filtern
          }
        },
        methods: {
            // Farbe anhand der Arbeitsart (type) finden, vgl. 'colors' im Setup
            getTypeColor: function(type, colors) {
              const item = colors.find(el => el.type === type);
              return item ? 'is-' + item.color : 'is-primary';
            }
        }
    }
</script>
