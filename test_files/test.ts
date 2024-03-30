type Human = { name: string; age: number };

const arr: Human[] = [
  { name: "A", age: 123 },
  { name: "B", age: 6 },
  { name: "D", age: 12 },
  { name: "Change", age: 12 },
];
((value) => {
  value.name;
});
const k = "asd";
for (let i = 0; i < k.length; i++) {
  const element = k[i];
}
console.table(arr[0]);
let res = arr.flat().map(x => x.age)
