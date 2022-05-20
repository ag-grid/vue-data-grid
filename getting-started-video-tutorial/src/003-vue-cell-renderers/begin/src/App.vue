<template>
  <ag-grid-vue
    style="width: 100%; height: 100vh"
    class="ag-theme-alpine"
    :columnDefs="columnDefs.columns"
    :rowData="rowData.rows"
    :defaultColDef="defaultColDef.def"
  >
  </ag-grid-vue>
</template>

<script>
import { AgGridVue } from "ag-grid-vue3";
import { reactive, h } from "vue";


export default {
  name: "App",
  components: {
    AgGridVue,
  },
  setup(props) {
    const columnDefs = reactive({
      columns: [
        { field: "athlete" },
        { field: "age" },
        { field: "country" },
        { field: "year" },
        { field: "date" },
        { field: "sport" },
        { field: "gold" },
        { field: "silver" },
        { field: "bronze" },
        { field: "total" },
      ],
    });

    const defaultColDef = reactive({
      def: { sortable: true, filter: true },
    });
    const rowData = reactive({
      rows: [],
    });

    return { columnDefs, rowData, defaultColDef };
  },

  mounted() {
    fetch(
      "https://www.ag-grid.com/example-assets/olympic-winners.json"
    )
      .then((resp) => resp.json())
      .then((data) => (this.rowData.rows = data));
  },
};
</script>

<style lang="scss">
@import "~ag-grid-community/dist/styles/ag-grid.css";
@import "~ag-grid-community/dist/styles/ag-theme-alpine.css";
</style>
