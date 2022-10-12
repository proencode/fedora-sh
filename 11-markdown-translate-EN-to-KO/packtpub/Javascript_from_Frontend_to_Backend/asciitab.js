var qq = process.argv[2];
// console.log( "split('').sort().reverse().join('') = " + qq.split('').sort().reverse().join('') );
var rr = qq.split('').sort();
for (var i = 1; i < rr.length; i++) {
    if (rr[i - 1] == " ") { // space 는 삭제한다.
        delete rr[i - 1];
    } else
    if (rr[i - 1] == rr[i]) {
        delete rr[i - 1]; // rr.splice (i - 1, 1) 로 되지 않음.
    }
}
var inputSort = rr.join('');
console.log( "inputSort = " + inputSort );

var pswdbar = new Array();
var findbar = new Array();
for (var i = 32; i < 128; i++) {
    pswdbar [i] = " " + String.fromCharCode (i); // "ABC" 출처: https://codingsalon.tistory.com/74 [코딩쌀롱:티스토리]
    findbar [i] = "--";
}

for (var k = 0; k < inputSort.length; k++) {
    // pswdbar [inputSort.charCodeAt (k)] = " ." // 있는글자이므로 " ." 으로 표시한다. // https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Global_Objects/String/charCodeAt
    findbar [inputSort.charCodeAt (k)] = "_" + inputSort [k]; // 있는글자이므로 해당글자를 써준다.
}

for (var i = 32; i < 128; i += 32) {
    console.log( "From: " + i + " To: " + (i + 32 - 1) );

    var strbar = ""
    for (var k = i; k < i + 16; k++) {
        strbar += pswdbar [k];
    }
    strbar += "    "
    for (var k = i + 16; k < i + 32; k++) {
        strbar += pswdbar [k];
    }
    console.log( strbar );

    strbar = ""
    for (var k = i; k < i + 16; k++) {
        strbar += findbar [k];
    }
    strbar += "    "
    for (var k = i + 16; k < i + 32; k++) {
        strbar += findbar [k];
    }
    console.log( strbar );
    console.log( "" );
}
