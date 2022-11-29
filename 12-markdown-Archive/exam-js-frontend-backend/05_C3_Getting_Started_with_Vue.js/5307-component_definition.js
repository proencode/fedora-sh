const Counter = {
  data() {
    return {
      count: 0
    }
  },
  template : "=== 5307_F---component_definition.js === The counter is: {{count}}",
  created() {
    setInterval(() => {
      this.count += 1;
    }, 1000)
  }
}
export default Counter;
