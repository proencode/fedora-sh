const Counter = {
  data() {
    return {
      count : 0
    }
  },
  template : `
  ===> (6401_F-Increment.js) ===>
    <br>===> <button @click="count++">count++ 로 카운트 증가</button> &nbsp;&nbsp; 카운트 = {{count}}
    <br>===> <button @click="incr()">incr() 로 카운트 증가</button>
    <br>===> 카운트 = {{count}}
  <=== (6401_F-) <===
  `,
  methods : {
    incr() {
      this.count++;
    }
  }
}
export default Counter;
