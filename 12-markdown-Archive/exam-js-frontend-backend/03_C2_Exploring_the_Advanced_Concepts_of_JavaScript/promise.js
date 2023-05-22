function wwww(sss, k) {
	console.log(`02 ----> function wwww(sss, k) { #-- wwww("${sss}", ${k}) 시작.`);
	return new Promise(
		function(resolve, reject) {
			console.log(`05 ----> ====> return new Promise( function(resolve, reject) { #-- 시작.`);
			var aa="---" + sss + "---";
			var bb=(k) + 999;
			console.log(`08 ----- ===== >>>> var aa="${aa}"; <=== "---" + sss + "---"`);
			console.log(`09 ----- ===== >>>> var bb=${bb}; <=== (k = ${k}) + 999`);
			console.log(`10 ----- ===== >>>> resolve([aa, bb]); <=== [ "${aa}", ${bb} ]`);
			resolve([aa, bb]); // triggers the then() method
			console.log(`12----> ====> return new Promise( function(resolve, reject) { #-- 끝.`);
		}
	);
	console.log(`15 ----> function wwww(sss, k) { #-- 끝.`);
}

console.log("18 ------------------- Start of Promise");

var zz="일이삼사"
var yy=5
console.log(`22 var zz="${zz}";`);
console.log(`23 var yy=${yy};`);
console.log(`24 wwww(zz,yy).then( #-- wwww("${zz}",${yy}) 호출.`);
wwww(zz,yy).then(
	function(txt) {
		console.log(`27 ----> function(txt) { #-- 시작.`);
		console.log(`28 ----> txt [0] = ((${txt [0]}))`);
		console.log(`29 ----> txt [1] = ((${txt [1]}))`);
		console.log(`30 ----> function(txt) { #-- 끝.`);
	}
);
console.log(`33 wwww(zz,yy).then( #-- 호출 종료.`);
