console.log(time(), "Before setTimeout()");

setTimeout(function() {
        console.log(time(), "In the callback function");
    }, 5000); // 5000 = 5 seconds

console.log(time(), "After setTimeout()");

function time() {
 // return time as HH:MM:SS
 var date = new Date();
 var y4 = date.getFullYear();
 var mm = date.getMonth() + 1;
 var dd = date.getDate();
 if (mm < 10) mm = "0" + mm;
 if (dd < 10) dd = "0" + dd;
 var hour = date.getHours();
 var min = date.getMinutes();
 var sec = date.getSeconds();
 if (hour < 10) hour = "0" + hour;
 if (min < 10) min = "0" + min;
 if (sec < 10) sec = "0" + sec;
 return "" + y4 + "-" + mm + "-" + dd + " " + hour + ":" + min + ":" + sec + " ";
}
