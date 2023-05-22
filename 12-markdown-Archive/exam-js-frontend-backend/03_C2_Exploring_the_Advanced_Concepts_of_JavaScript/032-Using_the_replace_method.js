var s = "Hello";
console.log("s =", s);
// search for "Hel" and replace with "abc"
console.log(`s.replace(/Hel/, "abc") => ${s.replace(/Hel/, "abc")}`);
// search for "hel" and replace with "abc"
console.log(`s.replace(/hel/, "abc") => ${s.replace(/hel/, "abc")}`);
// search for hel ignoring upper/lower case and replacing with
// "abc"
console.log(`s.replace(/hel/i, "abc") => ${s.replace(/hel/i, "abc")}`);
// search for H followed by a or b or e followed by l and
// replace with "abc"
console.log(`s.replace(/H[abe]l/, "abc") => ${s.replace(/H[abe]l/, "abc")}`);
// search for He followed by 0 or 1 a followed by l and
// replaced by "abc"
console.log(`s.replace(/Hea?l/, "abc") => ${s.replace(/Hea?l/,
"abc")}`);
// search for He followed by 0 (min) to 1 (max) followed by l
// and replaced by "abc"
console.log(`s.replace(/Hea{0,1}l/, "abc") => ${s.replace(/Hea{0,1}l/, "abc")}`);
// search for He followed by 1 (min) to 2 (max) followed by l
// and replaced by "abc"
console.log(`s.replace(/Hea{1,2}l/, "abc") => ${s.replace(/Hea{1,2}l/, "abc")}`);
