import Element from "./503-element.js";
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
    <button @click="add()">503 항목 추가</button>
    <ul>
      <Element v-for="(element, index) in elements"
      :key="index" :text="element" />
    </ul>
  `,
  methods : {
    add() {
      var element = "항목 " + (this.elements.length +
      1);  // "Element X"
      this.elements.push(element);
    }
  }
}
export default GlobalApp;
