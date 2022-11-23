var s = "Hello";
console.log("s =", s);
// search for "Hel"
console.log(`s.match(/Hel/) = ${s.match(/Hel/)}`);
// search for "hel"
console.log(`s.match(/hel/) = ${s.match(/hel/)}`);
// search for "hel" ignoring upper/lower case
console.log(`s.match(/hel/i) = ${s.match(/hel/i)}`);
// search for H followed by a or b or e followed by l
console.log(`s.match(/H[abe]l/) = ${s.match(/H[abe]l/)}`);
// search for He followed by 0 or 1 a followed by l
console.log(`s.match(/Hea?l/) = ${s.match(/Hea?l/)}`);
// search for He followed by 0 (min) to 1 (max) followed by l
console.log(`s.match(/Hea{0,1}l/) = ${s.match(/Hea{0,1}l/)}`);
// search for He followed 1 (min) to 2 (max) followed by l
console.log(`s.match(/Hea{1,2}l/) = ${s.match(/Hea{1,2}l/)}`);
