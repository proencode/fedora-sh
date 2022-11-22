var p = { lastname : "Clinton", firstname : "Bill" }
console.log("p (before modification of p2) =", p);
var p2 = { ...p};   // copy the properties of object p into
                    // object p2
p2.city = "Washington";
console.log("// var p2 = { ...p};   p2.city = \"Washington\";");
console.log("// OR");
console.log("// var p2 = { ...p, city : \"Washington\" };");
console.log("p (after modification of p2) =", p);
console.log("p2 =", p2);
