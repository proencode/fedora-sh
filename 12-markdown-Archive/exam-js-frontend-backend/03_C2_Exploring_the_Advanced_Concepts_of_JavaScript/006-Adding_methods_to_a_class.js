class Person {
  // class properties
  firstname = "";
  lastname = "";
  age = 0;

  // class methods
  display() {
    console.log("The person's lastname is = " +
                this.lastname +
                ", firstname = " + this.firstname);
  }
}
var p = new Person;
console.log("Variable p = ", p);
p.display();  // use of the display() method on the p object
