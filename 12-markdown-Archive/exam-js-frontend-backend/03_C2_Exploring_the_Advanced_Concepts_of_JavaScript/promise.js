function wwww(sss, k) {
	return new Promise(
		function(resolve, reject) {
			var aa="---" + sss + "---";
			var bb=(k) + 999;
			console.log(`    aa ${aa};`);
			console.log(`    bb ${bb} = (k ${k}) + 999;`);
			resolve([aa, bb]); // triggers the then() method
		}
	);
}

console.log("------------------- Start of Promise");

var zz="일이삼사"
var yy=5
console.log(`var zz="일이삼사"`);
console.log(`var yy=5`);
wwww(zz,yy).then(
	function(txt) {
		console.log(`End of Promise of txt [0] = ((${txt [0]}))`);
		console.log(`End of Promise of txt [1] = ((${txt [1]}))`);
	}
);
