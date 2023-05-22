// original array
var tab = ["Element 1", "Element 2", "Element 3", "Element 4", "Element 5"];
// adding a new element in the array, at index 10
tab[10] = "Element 9";
console.log("tab =", tab);
// display the array with a for() loop
console.log("Access to each element by a for() loop");
for (var i = 0; i < tab.length; i++) console.log("tab[" + i + "]=", tab[i]);
// display the array by the forEach() method
console.log("Access to each element by the forEach() method");
tab.forEach(function(elem, i) {
  console.log("tab[" + i + "]=", elem);
});
