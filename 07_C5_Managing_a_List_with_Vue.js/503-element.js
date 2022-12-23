const Element = {
  data() {
    return {
    }
  },
  template : `
    <li>
      <span> {{text}} </span>
      <button> 삭제 </button>
      <button> 수정 </button>
    </li>
  `,
  props : ["text"],
}
export default Element;
