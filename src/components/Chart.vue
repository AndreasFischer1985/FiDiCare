<template>
  <Doughnut :data="chartData" :options="chartOptions" />
</template>

<script setup>
import { computed, watch } from 'vue'
import { Doughnut } from 'vue-chartjs'
import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  ArcElement,
} from 'chart.js'

ChartJS.register(Title, Tooltip, Legend, ArcElement)

// Props: gefilterte Daten
const props = defineProps({
  filteredData: {
    type: Array,
    required: true
  }
})

// Aggregiere die Anzahl pro "type"
const chartData = computed(() => {
  const counts = {}
  props.filteredData.forEach(item => {
    counts[item.type] = (counts[item.type] || 0) + 1
  })

  return {
    labels: Object.keys(counts),
    datasets: [{
      data: Object.values(counts),
      backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56', '#9CCC65', '#AB47BC']
    }]
  }
})

const chartOptions = {
  responsive: true,
  plugins: {
    legend: {
      position: 'bottom',
      onClick: () => {} // Klick in der Legende deaktivieren
    },
    title: {
      display: true,
      text: 'Verteilung nach Arbeitsart'
    }
  }
}
</script>
