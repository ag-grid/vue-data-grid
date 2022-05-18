# Getting Started

This section will help you get started with the community edition of AG Grid using Vue so you learn how to setup the project, render your first grid, load data from a server and configure some simple properties.

## Quick Start Guide Video

https://youtu.be/V14w_NFuZB4

- 00:00 Create Vue App
- 01:37 Styling the Grid
- 02:40 Adding Reactive State
- 02:54 Loading Server Data
- 03:16 Column Definition Properties
- 03:46 Default Column Definitions
- 04:14 Grid Properties
- 04:59 Grid Events
- 05:20 Using Grid API
- 06:15 Summary

## Initial Code

This section will take you through the start point from a clean and empty project.

## Create A Project

We create a project using the VUE CLI.

```shell
vue create this-place
```

Change into the newly created project folder:

```shell
cd this-place
```

We will use `npm` to install AG Grid Community edition. This version of AG Grid has all the core functionality and is 100% free to use in commercial applications.

```shell
npm install ag-grid-community
```

We also need to install the Vue bindings for AG Grid.

```shell
npm install ag-grid-vue3
```

Then run the newly created project:

```shell
npm run serve
```

Then open the project in your editor of choice.


After this installation project your `package.json` file will contain references to AG Grid.

```
    "ag-grid-community": "^27.1.0",
    "ag-grid-vue3": "^27.1.0",
```

Both are required to use AG Grid with Vue and it is important that their version numbers match.

When creating a project using the CLI, there is always boiler plate code don't need so we tend to clean up the `App.vue`.

```javascript
<template>
</template>

<script>

export default {
  name: "App",
  components: {

  }
}
</script>

<style lang="scss"></style>
```

The first step is to import AG Grid into `App.vue` and register it as a component and add it to the template.

```javascript
<template>
  <ag-grid-vue>
  </ag-grid-vue>
</template>

<script>
import { AgGridVue } from "ag-grid-vue3";

export default {
  name: "App",
  components: {
    AgGridVue,
  }
}
</script>
```

We then need to configure the Grid with the basic properties required to render the column definitions and the row data and add them to the template


```javascript
<template>
  <ag-grid-vue>
    :columnDefs="columnDefs.value"
    :rowData="rowData.value"
  </ag-grid-vue>
</template>

<script>
export default {
  name: "App",
  components: {
    AgGridVue,
  },
  setup(){
      return{
          columnDefs:[],
          rowData:[],
      }
  }
}
</script>
```

This will render an unstyled grid with no data on the screen.

We configure the column definitions by adding Column Definition objects into the `columnDef` array:

```javascript
        columnDefs:[
            { field: "make" },
            { field: "model" },
            { field: "price" }
        ],
```

The `columnDefs` define the columns that will be displayed and which field values in the `rowData` to display in the columns.

Additionally we will hard code some data into the columns to render in the grid:

```javascript
    rowData:[
        { make: "Vauxhall", model: "Corsa", price: 17300 },
        { make: "Ford", model: "Fiesta", price: 18000 },
        { make: "Volkswagen", model: "Golf", price: 26000 },
      ],
```

Then return these:

```javascript
      return{
          columnDefs,
          rowData
      }
```

This will render data on the screen but it won't look like a Data Grid because we haven't added any CSS Styles yet.

## Styling the Grid

AG Grid comes with two CSS styles, one structural which renders the data as a grid, and one visual which adds the theme style.

We add the styling by importing the CSS files into the `App.vue`

```javascript
<script>
import { AgGridVue } from "ag-grid-vue3";
import "ag-grid-community/dist/styles/ag-grid.css";
import "ag-grid-community/dist/styles/ag-theme-alpine.css";
```

To apply the theme to the grid we need to configure the `class` in the `template` and add a size for the Grid:

```javascript
<template>
  <ag-grid-vue
    class="ag-theme-alpine"
    style="height: 500px"
    :columnDefs="columnDefs.value"
    :rowData="rowData.value"
  >
  </ag-grid-vue>
</template>
```

AG Grid comes with many themes built in which you can find described in the documentation.

https://www.ag-grid.com/vue-data-grid/themes-provided/

## Adding Reactive State

We can use Reactive State for the column definitions and row data so that we can update them using the composition API.

```javascript
    const rowData = reactive({
      value: [
        { make: "Vauxhall", model: "Corsa", price: 17300 },
        { make: "Ford", model: "Fiesta", price: 18000 },
        { make: "Volkswagen", model: "Golf", price: 26000 },
      ],
    });
    const columnDefs = reactive({
      value: [{ field: "make" }, { field: "model" }, { field: "price" }],
    });
```

Remember to import `reactive` from `vue`:

```javascript
import { reactive } from "vue";
```

## Loading Server Data

To load data from the server we will use the `onMounted` life cycle event to populate the grid when it is mounted on the page.

```javascript
import { reactive, onMounted, ref } from "vue";
```

And then write the code to handle the event:

```javascript
    onMounted(() => {
      fetch("https://www.ag-grid.com/example-assets/row-data.json")
        .then((result) => result.json())
        .then((remoteRowData) => (rowData.value = remoteRowData));
    });
```

The code above will fetch data from the server, use the JSON and assign it to the `rowData`.

## Column Definitions

There are many properties available for column definitions, and these can be found in the documentation:

https://www.ag-grid.com/vue-data-grid/column-definitions/

Column Definition properties allow us to very quickly add functionality like filtering and sorting to the grid.

We can do this by adding the `sortable` and `filter` property to each column definition that we want to sort or filter:

```javascript
    const columnDefs = reactive({
      value: [
          { field: "make", sortable: true, filter: true }, 
          { field: "model", sortable: true, filter: true }, 
          { field: "price", sortable: true, filter: true }],
    });
```

This is all that is required to make every column sortable and have a text filter.

Because it would become clumsy to add every property to every column definition we also have the concept of Default Column Definitions and these can be overridden (when necessary) by columns.

## Default Column Definitions

To add default column definitions we need to add the object and wire it up in the template.

```javascript
    const defaultColDef = {
      sortable: true,
      filter: true
    };
```

And in the template:

```javascript
<template>
  <ag-grid-vue
    class="ag-theme-alpine"
    style="height: 500px"
    :columnDefs="columnDefs.value"
    :rowData="rowData.value"
    :defaultColDef="defaultColDef"
  >
  </ag-grid-vue>
</template>
```

Remember to add this to the return value set.

```javascript
      return{
          columnDefs,
          rowData,
          defaultColDef
      }
```

This means that our `columnDefs` can return to their simpler form:

```javascript
        columnDefs:[
            { field: "make" },
            { field: "model" },
            { field: "price" }
        ],
```

Because of the `defaultColDef` the `sortable` and `filter` property will be applied to all columns automatically.

## Grid Properties

In addition to configuring the column definitions we can also configure the data grid itself for properties to control pagination, selection and other grid options.

https://www.ag-grid.com/vue-data-grid/grid-options/


We can enable selection by adding `rowSelection` and `animateRows` will animate the rows when the user sorts data.

```javascript
    rowSelection="multiple"
    animateRows="true"
```

These properties would be added in the `template` section.

```javascript
<template>
  <ag-grid-vue
    class="ag-theme-alpine"
    style="height: 500px"
    :columnDefs="columnDefs.value"
    :rowData="rowData.value"
    :defaultColDef="defaultColDef"
    rowSelection="multiple"
    animateRows="true"
  >
  </ag-grid-vue>
</template>
```

## Grid Events

There are many Grid Events that can be handled to add extra functionality into your application.

In this section we will look at the click event.

Full list of events can be found in the documentation:

https://www.ag-grid.com/vue-data-grid/grid-events/

We add the event handler to the properties in the template

```javascript
    @cell-clicked="cellWasClicked"
```

And then create an event handler to output the details of the event to the console.

```javascript
    return {
      columnDefs,
      rowData,
      defaultColDef,
      cellWasClicked: (event) => {
        console.log("cell was clicked", event);
      },
    }
```

## Grid API

AG Grid has an extensive API that allows you to re-configure and interact with the grid data at run time.

The Grid API is documented online:

https://www.ag-grid.com/vue-data-grid/grid-api/

To use the Grid API we will use the `gridReady` event to get a reference to the API.

We need to add a handler in the grid properties:

```javascript
    @grid-ready="onGridReady"
```

Then write the handler code.

```javascript
    const gridApi = ref(null);

    const onGridReady = (params) => {
      gridApi.value = params.api;
    };
```

We also need to add this to the `return` value set.


```javascript
    return {
      onGridReady,
      columnDefs,
      rowData,
      defaultColDef,
      cellWasClicked: (event) => {
        console.log("cell was clicked", event);
      },
    }
```

This will create reference so that we can subsequently add code to use the API.

We can add a button in the template which will call a handler and in this use the API to clear the selected rows.

```javascript
<template>
  <button @click="deselectRows">deselect rows</button>
  <ag-grid-vue
```

Then add the handler `deselectRows`

```javascript
    return {
      onGridReady,
      columnDefs,
      rowData,
      defaultColDef,
      cellWasClicked: (event) => {
        console.log("cell was clicked", event);
      },
      deselectRows: e =>{
        gridApi.value.deselectAll()
      }
    }
```

Now when the user clicks the `[deselect rows]` button, any rows that they have selected in the grid will be deselected by the use of the API.

The Grid API is enormously powerful and allows your application to manipulate and interrogate the grid and date.

## Summary

In this section you learned how to get started with AG Grid and Vue.

We have released all the code for this section to Github:

https://github.com/ag-grid/vue-data-grid/tree/main/getting-started-video-tutorial/src/001-vue-getting-started

We recommend that you experiment with other grid and column properties and see how little configuration it takes to offer new functionality to your user e.g. pagination, column header values, ordering, sizing, etc.