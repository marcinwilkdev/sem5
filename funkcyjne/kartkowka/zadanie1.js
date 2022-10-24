const myLength = (x) => {
  return myLengthReq(x, 0);
}

const myLengthReq = (x, len) => {
  if (typeof x[0] === "undefined") {
    return len;
  }

  return myLengthReq(x.slice(1), len + 1);
}

console.log(myLength([]));
console.log(myLength([1, 2, 3]));
console.log(myLength([1, 2, 3, 4, 5]));
