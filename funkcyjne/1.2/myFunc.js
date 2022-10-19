const myFunc = (x, y) => {
  return (z => (w => z + 2 * w))(x * y);
};

const anotherFunc = (x, y) => {
  return (a => (x * y) + 2 * a);
};

const sinFunc = (x) => {
  return (a => a * a + a + x)(Math.sin(x));
};

const sum = (x) => {
  if (x.length == 0) {
    return 0;
  }

  return x[0] + sum(x.slice(1));
};

const product = (x) => {
  if (x.length == 0) {
    return 1;
  }

  return x[0] * product(x.slice(1));
}

const _min = (x, curr_min) => {
  if (x.length == 0) {
    return curr_min;
  }

  if (x[0] < curr_min) {
    curr_min = x[0];
  }

  return _min(x.slice(1), curr_min);
}

const min = (x) => {
  return _min(x, x[0]);
}

const _max = (x, curr_max) => {
  if (x.length == 0) {
    return curr_max;
  }

  if (x[0] > curr_max) {
    curr_max = x[0];
  }

  return _max(x.slice(1), curr_max);
}

const max = (x) => {
  return _max(x, x[0]);
}

const sumSquares = (n) => {
  if (n == 0) {
    return 0;
  }

  return n * n + sumSquares(n - 1);
}

const ackermann = (m, n) => {
  if (m == 0) {
    return n + 1;
  }

  if (m > 0 && n == 0) {
    return ackermann(m - 1, 1);
  }

  return ackermann(m - 1, ackermann(m, n - 1));
};

const _ackermann_mem = (table, m, n) => {
  if (m == 0) {
    return n + 1;
  }

  if (table.length <= m) {
    for (let i = table.length; i <= m; i++) {
      table.push([]);
    }
  }

  if (table[m].length <= n) {
    for (let j = table[m].length; j <= n; ++j) {
      if (m > 0 && j == 0) {
        table[m][j] = _ackermann_mem(table, m - 1, 1);
      } else {
        table[m][j] = _ackermann_mem(table, m - 1, _ackermann_mem(table, m, j - 1));
      }
    }
  }

  return table[m][n];
};

const ackermann_mem = (m, n) => {
  let table = [];

  const result = _ackermann_mem(table, m, n);

  console.log(table);

  return result;
};

console.log(myFunc(3, 5)(2));
console.log(anotherFunc(3, 5)(2));
console.log(sinFunc(1));
console.log(sum([1, 2, 3, 4]));
console.log(product([1, 2, 3, 4]));
console.log(min([5, 2, 3, 4]));
console.log(max([1, 2, 3, 4]));
console.log(sumSquares(10));
console.log(ackermann(3, 10));
console.log(ackermann_mem(3, 22));
