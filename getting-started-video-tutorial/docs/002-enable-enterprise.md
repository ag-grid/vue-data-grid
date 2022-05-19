# Getting Started

This section will help you get started with the enterprise edition of AG Grid. The community edition is free to use in commercial applications, the Enterprise edition requires a license and offers extra features like pivoting, aggregation, integrated charts, row grouping, server side data models and more.

## Quick Start Guide Video

https://youtu.be/9WnYqSxTuE8

- 00:00 Starting Code
- 00:28 Enable Enterprise
- 01:43 Row Grouping
- 02:00 User Controlled Grouping
- 02:34 Enterprise Features


## Starting Code

You can find the starting code in the github repo, but the `App.vue` should be familiar to you if you worked through the first section on getting started with the community edition.

This configures a grid with some column definitions, and a default column definition to enable sorting and filtering, then loads in some data from the server to render in the grid when the `onMounted` event fires.

```javascript
<template>
  <ag-grid-vue
    style="width: 100%; height: 700px"
    class="ag-theme-alpine"
    :columnDefs="columnDefs.value"
    :rowData="rowData.value"
    :defaultColDef="defaultColDef"
  >
  </ag-grid-vue>
</template>

<script>
import { AgGridVue } from "ag-grid-vue3";
import { reactive, onMounted, ref } from "vue";


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
```

This uses the community edition of AG Grid which has the standard features you'd expect from a data grid and offers extensive column header, cell and row customization opportunities.

## Enabling Enterprise

To enable the enterprise edition features we first need to install the enterprise component.

```shell
npm install ag-grid-enterprise
```

This will add the `ag-grid-enterprise` package into our project in `package.json`

```
    "ag-grid-community": "^27.2.1",
    "ag-grid-enterprise": "^27.2.1",
    "ag-grid-vue3": "^27.2.1",
```

All three packages are required to use AG Grid enterprise with Vue.

- `ag-grid-community` is the core set of grid functionality
- `ag-grid-enterprise` provides all the enterprise functionality
- `ag-grid-vue3` is the wrapper required to allow working with Vue

To enable the enterprise features we need to import the enterprise module into our `App.vue`

```javascript
import 'ag-grid-enterprise'
```

This is shown in context in the snippet below:

```javascript
<script>
import { AgGridVue } from "ag-grid-vue3";
import { reactive, onMounted, ref } from "vue";
import 'ag-grid-enterprise'
```

The default enterprise features will be enabled in the grid after this `import` is added.

Out of the box you will see new options like the right click menu now being an AG Grid menu with export and clipboard options, and you will see richer filtering capabilities. There are many more features available which can be found in the documentation. In this section we will only cover a small subset of available Enterprise features.

## Row Grouping

Column Grouping is available in the community edition of AG Grid. To use Row Grouping and start working with a hierarchical data view we need the Enterprise edition.

Row Grouping is configured as a column definition property.

We can group by specific column values by adding the `rowGroup` property to a column:

```javascript
{ field: "country", rowGroup: true },
```

This will cause the grid to group by values in the `Country` column.

It is possible to group by multiple columns, and they are nested based on their order in the definitions, so we can group by country and then by year using the code below:

```javascript
{ field: "country", rowGroup: true },
{ field: "year", rowGroup: true },
```

## User Controlled Grouping

We can pass control of grouping over to the user by adding `enableRowGroup` to the default column definitions.

```javascript
    const defaultColDef = {
      sortable: true,
      filter: true,
      enableRowGroup: true
    };
```

We also have to enable the grouping drop zone to allow users to drag column headers and subsequently group by the values. We do this by adding `rowGroupPanelShow` to the grid properties.

```javascript
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
```

Learn more about Row Grouping in the documentation:

https://www.ag-grid.com/vue-data-grid/grouping/

You will see that enterprise features like row grouping are identifiable with a red "(e)" symbol in the docs. Anything without this symbol means it is part of the Community edition.

AG Grid does not require a trial license for Enterprise evaluation you are free to trial Enterprise in your own organization, a license is required when you deploy the application to production.

If you wish to remove the watermark and console message then a trial license can be issued to help you evaluate AG Grid without the license warnings.

Contact `info@ag-grid.com` if you wish to purchase a license, or be issued with a trial license.


