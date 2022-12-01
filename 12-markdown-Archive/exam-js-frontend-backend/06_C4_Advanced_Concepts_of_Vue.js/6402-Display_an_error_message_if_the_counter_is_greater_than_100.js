const Counter = {
  data() {
    return {
      count : 0,
      message : ""
    }
  },
  template : `
  ==== 6402-Display_an_error_message_if_the_counter_is_greater_than_100.js ===
    count (less than 100): <input type="text"
    :value="count" @blur="moyamoya($event)" />
     &nbsp;&nbsp; count = {{count}}
    <br><br>
    <span>{{message}}</span>
  `,
  methods : {
    moyamoya(eeevvvnnnttt) {
      this.message = "";  // reset of the error message
                          // before each check
      if (eeevvvnnnttt.target.value < 100) this.count =
      eeevvvnnnttt.target.value;
      else this.message = "Error: count " + eeevvvnnnttt.target.value + " must be less than 100";
    }
  }
}
export default Counter;
