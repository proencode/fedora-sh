import Element from "./501-element.js";
const GlobalApp = {
  data() {
    return {
      elements : []
    }
  },
  components : {
    Element:Element
  },
  template : `
    <button>501 항목 추가</button>
    <ul></ul>
  `,
}
export default GlobalApp;
