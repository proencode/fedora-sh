const Counter = {
  data() {
    return {
      count : 0,
      old_value : 0
    }
  },
  template : `
  +++> (6404_F-counter.js) +++>
  <input type="text" v-model="count"
       @keydown="verif($event)"
       @input="calcul()"
       @focus="focus()"
       @blur="blur()" />
  <+++ (6404_F-) <+++
  `,
  methods : {
    verif(event) {
      if (event.key != "Backspace" && event.key != "Delete" &&
          event.key != "ArrowLeft" && event.key !=
          "ArrowRight" &&
          event.key != "Tab") {
        // forbid the key if it is not numeric
        if (event.key < "0" || event.key > "9")
        event.preventDefault();  // key forbidden
      }
      this.old_value = event.target.value;
    },
    calcul() {
      this.$emit("sub", this.old_value || 0);  // subtract
                                               // old value
      this.$emit("add", this.count || 0);      // add new value
    },
    focus() {
      if (this.old_value == "0") this.count = "";
    },
    blur() {
      if (!parseInt(this.count)) {
        this.old_value = 0;
        this.count = 0;
      }
    }
  },
  emits : ["sub", "add"]    // declare events emitted to
                            // the parent
}
export default Counter;
