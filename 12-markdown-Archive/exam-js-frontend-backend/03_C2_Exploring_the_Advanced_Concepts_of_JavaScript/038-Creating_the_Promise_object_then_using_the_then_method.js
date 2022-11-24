function time() {
 // return time as HH:MM:SS
 var date = new Date();
 var hour = date.getHours();
 var min = date.getMinutes();
 var sec = date.getSeconds();
 if (hour < 10) hour = "0" + hour;
 if (min < 10) min = "0" + min;
 if (sec < 10) sec = "0" + sec;
 return "" + hour + ":" + min + ":" + sec + " ";
}
function wait(sec) {
  return new Promise(function(resolve, reject) {
    setTimeout(function() {
      resolve(sec);  // triggers the then() method
      // resolve(999);  // triggers the then() method
    }, sec*1000);
  });
}
console.log(time(), "Start of timer");
wait(2).then(function(sec) {
  console.log(time(), `End of timer of ${sec} seconds`);
});
