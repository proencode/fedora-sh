class Person {
  // class properties
  lastname = "";
  firstname = "";
  age = 0;

  // class methods
  display() {
    console.log("성은 " + this.lastname + " 이고, 이름은 " + this.firstname + " 입니다.");
  }
}
var p = new Person;
p.lastname = "Clinton";  // initialization of the lastname
                         // property of the object p
p.firstname = "Bill";    // initialization of the firstname
                         // property of the object p
console.log("Variable p = ", p);
p.display();
