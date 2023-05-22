var lastname = "Clinton";
var firstname = "Bill";
// old way of concatenating strings and variables
var s1 = "lastname is " + lastname + ", firstname is " + firstname;
// new way of concatenating strings and variables
var s2 = `lastname is ${lastname}, firstname is ${firstname}`;
console.log("s1 =", s1);
console.log("s2 =", s2);
