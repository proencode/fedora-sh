var p = { lastname : "Clinton", firstname : "Bill" };
console.log("p2 만들기 전의 p =", p);
       // p = { lastname : "Clinton", firstname : "Bill" }
var p2 = p;
console.log("var p2 = p; <---- 새 오브젝트를 만들지 않고, 동일한 값을 가리키는 참조만 만든다.");
console.log("p 오브젝트를 복사해서 만든 p2 =", p2);
console.log("p2 만든 직후의 p =", p);
p2.city = "Washington";
console.log("city 프로퍼티를 추가한 p2 =", p2);
       // p2 = { lastname : "Clinton", firstname : "Bill",
       // city : "Washington"}
console.log("p2 를 손댄 다음의 p =", p);
       // p = { lastname : "Clinton", firstname : "Bill",
       // city : "Washington"}
