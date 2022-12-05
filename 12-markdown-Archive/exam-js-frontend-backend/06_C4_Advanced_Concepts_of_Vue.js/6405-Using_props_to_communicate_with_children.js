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
  props : ["nb"],
  computed : {
    NB() {
      var tab = [];
      for(var i = 0; i < this.nb; i++) tab.push(i+1);
      return tab;
    }
  },
  template : `
     <div v-for="i in NB">
	===> (6405-Using_props.js)
        <br>===> 카운터 {{i}} : <counter @add="add($event)"
        @sub="sub($event)" /> <===
     </div>
     <br>===> 합계 : {{total}} <===
     (6405) <===
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
