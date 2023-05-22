// original array
var tab = ["Element 1", "Element 2", "Element 3", "Element 4", "Element 5"];
// insert an element using the push() method
tab.push("Element 6");
console.log("tab =", tab);
// display the array with a for() loop
console.log("Access to each element by a for() loop");
for (var i = 0; i < tab.length; i++) console.log("tab[" + i + "]=", tab[i]);
// display the array by the forEach() method
console.log("Access to each element by the forEach() method");
tab.forEach(function(elem, i) {
  console.log("tab[" + i + "]=", elem);
});
