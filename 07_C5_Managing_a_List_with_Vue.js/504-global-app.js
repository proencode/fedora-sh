import Element from "./504-element.js";
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
    <button @click="add()">504 항목 추가</button>
    <ul>
      <Element v-for="(element, index) in elements"
      :key="index" :text="element"
           :index="index"
               @remove="remove($event)"
      />
    </ul>
  `,
  methods : {
    add() {
      var element = "항목 " + (this.elements.length +
      1);
      this.elements.push(element);
    },
    remove(params) {
      var index = params.index;
      this.elements.splice(index, 1);  // delete element in
                                       // array
    }
  }
}
export default GlobalApp;
