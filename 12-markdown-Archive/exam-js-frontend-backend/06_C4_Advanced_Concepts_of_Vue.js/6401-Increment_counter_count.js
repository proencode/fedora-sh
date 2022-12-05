const Counter = {
  data() {
    return {
      count : 0
    }
  },
  template : `
  ===> 6401_F-Increment_counter_count.js ===>
    <br>====> <button @click="count++">count++ 로 카운트 증가</button> &nbsp;&nbsp; 카운트 = {{count}}
    <br>====> <button @click="incr()">incr() 로 카운트 증가</button>
    <br>====> 카운트 = {{count}}
    <===
  `,
  methods : {
    incr() {
      this.count++;
    }
  }
}
export default Counter;
