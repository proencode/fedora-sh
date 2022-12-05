import Counter from "./6404-counter.js";
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
  ***> 6404-display_the_-counters-_component_in_its_template_section.js ***>
  <br>***> 카운터 1 : <counter @add="add($event)"
      @sub="sub($event)" /> <***
  <br>***> 카운터 2 : <counter @add="add($event)"
      @sub="sub($event)" /> <***
  <br>***> 카운터 3 : <counter @add="add($event)"
      @sub="sub($event)" /> <***
  <br>***> 합계 : {{total}} <***
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
