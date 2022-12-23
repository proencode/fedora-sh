const Element = {
  data() {
    return {
    }
  },
  template : `
    <li>
      <span> {{text}} </span>
      <button @click="remove()"> 삭제 </button>
      <button> 수정 </button>
    </li>
  `,
  props : ["text", "index"],
  methods : {
    remove() {
      // process the click on the Remove button
      this.$emit("remove", { index : this.index });
    },
  },
  emits : ["remove"]
}
export default Element;	
