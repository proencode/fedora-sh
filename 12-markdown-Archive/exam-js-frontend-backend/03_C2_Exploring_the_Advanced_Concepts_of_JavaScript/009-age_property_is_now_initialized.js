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
    // the age of the person is also displayed
    console.log("The person's lastname = " + this.lastname +
                ", firstname = " + this.firstname +
                ", age = " + this.age);
  }
}
var p = new Person("Clinton", "Bill", 33);    // age is now
                                              // transmitted
console.log("Variable p = ", p);
p.display();
