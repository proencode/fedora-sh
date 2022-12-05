const Counter = {
  data() {
    return {
      count : 0,
      message : ""
    }
  },
  template : `
  ===> (6402-Display_an_error.js)
    <br>===> 카운트 값 (100 보다 작아야 한다): <input type="text"
    :value="count" @blur="moyamoya($event)" />
    <br>===> 카운트 = {{count}}
    <br> <span>{{message}}</span>
    (6402) <===
  `,
  methods : {
    moyamoya(eeevvvnnnttt) {
      this.message = "";  // reset of the error message
                          // before each check
      if (eeevvvnnnttt.target.value < 100) this.count =
      eeevvvnnnttt.target.value;
      else this.message = "*** 오류! : 카운트 " + eeevvvnnnttt.target.value + " 는 100 보다 작아야 한다. ***";
    }
  }
}
export default Counter;
