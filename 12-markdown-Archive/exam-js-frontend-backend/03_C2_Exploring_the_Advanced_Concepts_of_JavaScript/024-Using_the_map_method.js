// original array
var tab = ["Element 1", "Element 2", "Element 3", "Element 4", "Element 5"];
console.log("initial tab =", tab);
// capitalize all elements
tab = tab.map(function(element, index) {
  return element.toUpperCase();
});
console.log("\nfinal tab =", tab);
