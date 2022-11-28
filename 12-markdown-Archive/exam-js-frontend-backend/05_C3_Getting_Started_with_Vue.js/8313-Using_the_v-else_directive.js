const Counter = {
  data() {
    return {
      count : parseInt(this.start),  // we initialize the
                                     // count to the value
                                     // of start
    }
  },
template : `
  === 8313_F-Using_the_v-else_directive.js === {{time()}} &nbsp;&nbsp;
  <span v-if='count<=20'>The counter is: {{count}}</span>
  <span v-else>The counter has exceeded 20, it is:
  {{count}}</span>
`,
// template : `
//   === 8311_F-Using_the_v-if_directive.js === {{time()}} &nbsp;&nbsp;
//   <span v-if='count<=20'>The counter is: {{count}}</span>
// `,
  created() {
    var timer = setInterval(() => {
      this.count += 1;
    }, 1000)
  },
  methods : {
    time() {
     // return time as HH:MM:SS
     var date = new Date();
     var hour = date.getHours();
     var min = date.getMinutes();
     var sec = date.getSeconds();
     if (hour < 10) hour = "0" + hour;
     if (min < 10) min = "0" + min;
     if (sec < 10) sec = "0" + sec;
     return "" + hour + ":" + min + ":" + sec + " ";
    }
  },
  computed : {
    countX2() {
      return 2 * this.count;
    }
  },
  props : [
    "start"
  ]
}
export default Counter;
