const f = (x, y) => {
  return (a => (b => a * a + b))(Math.pow(x, y));
};

console.log(f(2, 3)(4));
console.log(f(4, 7)(3));
console.log(f(1, 5)(2));
console.log(f(12, 1)(1));

const fSimplified = (x, y) => {
  return (b => Math.pow(x, 2 * y) + b);
};

console.log(fSimplified(2, 3)(4));
console.log(fSimplified(4, 7)(3));
console.log(fSimplified(1, 5)(2));
console.log(fSimplified(12, 1)(1));
