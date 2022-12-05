const Counter = {
  data() {
    return {
      count : 0,
      message : ""
    }
  },
  template : `
  ===> 6403-Disallow_input_of_non-numeric_characters.js ===>
    <br>====> 카운트 (100 보다 작아야 한다):
    <br>====> <input type="text" :value="count"
        @blur="valid($event)"
        @keydown="verif($event)"/>
    <br>====> 카운트 = {{count}}
    <br> <span>{{message}}</span>
    <===
  `,
  methods : {
    valid(event) {
      this.message = "";  // reset of the error message
                          // before each check
      if (event.target.value < 100) this.count = event.target.
      value;
      else this.message = "Error: count must be less than 100";
    },
    verif(event) {
      console.log(event.key);   // display in the console
                                // the value of the key
                                // pressed
      if (event.key != "Backspace" && event.key != "Delete"
      &&
          event.key != "ArrowLeft" && event.key !=
          "ArrowRight" &&
          event.key != "Tab") {
        // forbid the key if it is not numeric
        if (event.key < "0" || event.key > "9")
        event.preventDefault();  // forbidden key
      }
    }
  }
}
export default Counter;
