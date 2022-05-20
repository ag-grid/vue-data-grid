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
import FunCompVue from "./components/FunComp.vue";
import OptionsCompVue from "./components/OptionsComp.vue";
export default {
  name: "App",
  components: {
    AgGridVue,
    SimpleComp: {
      setup(props) {
        const { params } = props;
        return () => h("b", "! " + params.value + " !");
      },
    },
    FunCompVue,
    OptionsCompVue,
  },
  setup(props) {
    const columnDefs = reactive({
      columns: [
        {
          field: "athlete",
          cellRenderer: "FunCompVue",
        },
        {
          field: "age",
          cellRenderer: "OptionsCompVue",
        },
        { field: "country", cellRenderer: "SimpleComp" },
        {
          field: "year",
          cellRendererSelector: (p) => {
            if (p.value === 2000) {
              return {
                component: "FunCompVue",
                params: {},
              };
            }
            if (p.value === 2008) {
              return {
                component: "OptionsCompVue",
                params: {},
              };
            }
          },
        },
        { field: "date" },
        { field: "sport" },
        { field: "gold" },
        { field: "silver" },
        { field: "bronze" },
        { field: "total" },
      ],
    });
    const defaultColDef = reactive({
      def: {
        sortable: true,
        filter: true,
      },
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
