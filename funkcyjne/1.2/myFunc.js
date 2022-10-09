const myFunc = (x, y) => {
    return (z => (w => z + 2 * w))(x * y);
}

console.log(myFunc(3, 5)(2))
