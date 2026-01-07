// Array functions

// filter example
const numbers = [1, 2, 3, 4, 5, 6];
const evenNumbers = numbers.filter(num => num % 2 === 0);
console.log('Even Numbers:', evenNumbers); // [2, 4, 6]

// map example
const stringfiedNumbers = numbers.map(num => `${num}`);
console.log('Stringified Numbers:', stringfiedNumbers); // ['1', '2', '3', '4', '5', '6']

// reduce example
const sum = numbers.reduce((accumulator, current) => accumulator + current, 0);
console.log('Sum of Numbers:', sum); // 21