<script setup>
  import fidicare from './data/fidicare.json'
  import Chart from './components/Chart.vue'

  const columns = [
    { field: 'id', label: '#', sortable: true },
    { field: 'name', label: 'Produktname', searchable: true, sortable: true },
    { field: 'type', label: 'Arbeitsart', sortable: true },
    { field: 'technology', label: 'Technologie', sortable: true },
    { field: 'description', label: 'Beschreibung', searchable: true },
  ]
</script>

<template>
  <section class="section theme-light">
    <div class="container">
      <div class="columns">
        <div class="column is-8">
          <b-field label="Arbeitsart" grouped group-multiline>
            <b-button size="is-small" @click="selectedTypes = []" :type="selectedTypes.length == 0 ? 'is-primary' : ''" class="mr-3 has-text-weight-bold">Alle anzeigen</b-button>
            <b-checkbox-button v-model="selectedTypes" v-for="(item, index) in uniqueTypes" :native-value="item" size="is-small">{{ item }}</b-checkbox-button>
          </b-field>

          <b-field label="Technologie" grouped group-multiline>
            <b-button size="is-small" @click="selectedTechnologies = []" :type="selectedTechnologies.length == 0 ? 'is-primary' : ''" class="mr-3 has-text-weight-bold">Alle anzeigen</b-button>
            <b-checkbox-button v-model="selectedTechnologies" v-for="(item, index) in uniqueTechnologies" :native-value="item" size="is-small">{{ item }}</b-checkbox-button>
          </b-field>

          <b-field label="Anzahl">
            <span class="tag is-primary mr-1">{{ filteredData.length }}</span>
            <span class="has-text-primary has-text-weight-bold">Pflegeprodukte</span>
          </b-field>
        </div>

        <div class="column is-hidden-mobile is-4">
          <Chart :filteredData="filteredData" />
        </div>
      </div>


      <b-table
        :data="filteredData"
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
          filteredData: function () {
            // Daten ggfs. filtern und bereit stellen
            return fidicare.filter(item =>
              (this.selectedTypes.length === 0 || this.selectedTypes.includes(item.type)) &&
              (this.selectedTechnologies.length === 0 || this.selectedTechnologies.includes(item.technology))
            )
          },
          uniqueTypes: function () {
            return [...new Set( fidicare.map(eintrag => eintrag.type) )] // Eindeutige Werte aus den Daten filtern
          },
          uniqueTechnologies: function () {
            return [...new Set( fidicare.map(eintrag => eintrag.technology) )] // Eindeutige Werte aus den Daten filtern
          }
        }
    }
</script>
