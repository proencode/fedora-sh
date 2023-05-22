const Counter = {
  data() {
    return {
      counts : ["Counter 1", "Counter 2", "Counter 3",
      "Counter 4", "Counter 5"]
    }
  },
  template : `
    <ul>
      <li v-for="count in counts">
        <span>=== 8314_F---Displaying_counters_as_a_list.js === {{count}}</span>
      </li>
    </ul>
  `,
}
export default Counter;
