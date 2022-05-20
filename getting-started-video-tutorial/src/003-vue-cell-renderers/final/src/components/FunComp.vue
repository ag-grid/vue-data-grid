<template>
  <div>
    <button @click="alertClick('£')">Push</button>
    
    <span>{{ value }}</span>
  </div>
</template>

<script>
export default {
  setup(props) {
    let { value } = props.params;
    let {btnText} = props.params
    function alertClick(s) {
      alert(s + s + s + s + " from " + value);
    }
    return { value, alertClick,btnText };
  },
};
</script>

<style lang="scss" scoped></style>
