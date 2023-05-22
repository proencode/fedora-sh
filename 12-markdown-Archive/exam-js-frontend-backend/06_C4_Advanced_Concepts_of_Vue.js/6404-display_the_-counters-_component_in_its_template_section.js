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
  ===> (6404_F-display.js) ===>
  <br>===> 카운터 1 : <counter @add="add($event)"
      @sub="sub($event)" /> <===
  <br>===> 카운터 2 : <counter @add="add($event)"
      @sub="sub($event)" /> <===
  <br>===> 카운터 3 : <counter @add="add($event)"
      @sub="sub($event)" /> <===
  <br>===> 합계 : {{total}} <===
  <=== (6404_F-) <===
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
