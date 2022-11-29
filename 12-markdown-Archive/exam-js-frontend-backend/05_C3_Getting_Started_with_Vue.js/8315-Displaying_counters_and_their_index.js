const Counter = {
  data() {
    return {
      counts : ["카운터 1", "카운터 2", "카운터 3",
      "카운터 4", "카운터 5"]
    }
  },
  template : `
    <ul>
      <li v-for="(count, index) in counts">
        <span>=== 8315_F-Displaying_counters_and_their_index.js === Index {{index}} : {{count}}</span>
      </li>
    </ul>
  `,
}
export default Counter;
