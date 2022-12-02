import Counter from "./6404a-display_the_-counters-_component_in_its_template_section.js";
const Counters = {
  data() {
    return {
      total : 0
    }
  },
  components : {
    Counter:Counter
  },
  template : `
  === 6404b-display_the_-counters-_component_in_its_template_section.js ===<br>
      Counter 1 : <counter @add="add($event)"
      @sub="sub($event)" /> <br>
      Counter 2 : <counter @add="add($event)"
      @sub="sub($event)" /> <br>
      Counter 3 : <counter @add="add($event)"
      @sub="sub($event)" /> <br><br>
      Total : {{total}} <br>
  `,
  methods : {
    add(value) {
      this.total += parseInt(value);
    },
    sub(value) {
      this.total -= parseInt(value);
    }
  },
}
export default Counters;
