class Person {
  // class properties
  lastname = "";
  firstname = "";
  age = 0;

  // class methods
  constructor(lastname, firstname, age) {
    this.lastname = lastname;
    this.firstname = firstname;
    this.age = age;
  }
  display() {
    console.log(" The person's lastname = " + this.lastname +
                ", firstname = " + this.firstname);
  }
}
var p = new Person("Clinton", "Bill");
console.log("Variable p = ", p);
p.display();
