// original array
var tab = ["Element 1", "Element 2", "Element 3", "Element 4", "Element 5"];
console.log("initial tab =", tab);
// keep only items with index >= 2
tab = tab.filter(function(element, index) {
  if (index >= 2) return true;   // keep this element
});
console.log("\nfinal tab =", tab);
