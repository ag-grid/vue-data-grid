<template>
  <ag-grid-vue
    style="width: 100%; height: 700px"
    class="ag-theme-alpine"
    :columnDefs="columnDefs.value"
    :rowData="rowData.value"
    :defaultColDef="defaultColDef"
    rowGroupPanelShow="always"
  >
  </ag-grid-vue>
</template>

<script>
import { AgGridVue } from "ag-grid-vue3";
import { reactive, onMounted, ref } from "vue";
import 'ag-grid-enterprise'
export default {
  name: "App",
  components: { AgGridVue },
  setup() {

    let rowData = reactive({ value: [] });
    let columnDefs = reactive({
      value: [
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
    const defaultColDef = {
      sortable: true,
      filter: true,
      enableRowGroup: true
    };

    onMounted(() => {
      fetch("https://www.ag-grid.com/example-assets/olympic-winners.json")
        .then((result) => result.json())
        .then((remoteRowData) => (rowData.value = remoteRowData));
    });

    return {
      rowData,
      columnDefs,
      defaultColDef,
    };
  },
};
</script>

<style lang="scss">
@import "~ag-grid-community/dist/styles/ag-grid.css";
@import "~ag-grid-community/dist/styles/ag-theme-alpine.css";
</style>
