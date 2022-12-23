const Element = {
  data() {
    return {
      input : false   // display element text by default
    }
  },
  template : `
    <li>
      <span v-if="!input"> {{text}} </span>
      <input v-else type="text" :value="text"
       @blur="modify($event)" ref="refInput" />
      <button @click="remove()"> 삭제 </button>
      <button @click="input=true"> 수정 </button>
    </li>
  `,
  props : ["text", "index"],
  methods : {
    remove() {
      // process the click on the Remove button
      this.$emit("remove", { index : this.index });
    },
    modify(event) {
      var value = event.target.value;    // value entered
                                         // in the field
      this.input = false;                // delete input field
      this.$emit("modify", { index : this.index, value :
      value });   // update element in list
    }
  },
  emits : ["remove", "modify"],
  updated() {
    // check that the ref="refInput" attribute exists, and
    // if so, give focus to the input field
    if (this.$refs.refInput) this.$refs.refInput.focus();
  }
}
export default Element;	
