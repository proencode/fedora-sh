const Counter = {
  data() {
    return {
      count : 10
    }
  },
  // === 8316_F-Using_the_v-model_directive_in_an_input_field.js ===
  template : `
    Without v-model:
      <input type="text" :value="count" /> &nbsp;&nbsp;
      count = {{count}} <br><br>
    With v-model:
      <input type="text" v-model="count" /> &nbsp;&nbsp;
      count = {{count}}
  `,
}
export default Counter;
