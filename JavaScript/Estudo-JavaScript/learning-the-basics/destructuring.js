// Atribuition via destructuring

// Object
const user = {
  firstName: 'Alice',
  age: 30,
  city: 'Wonderland'
};

// Destructuring assignment
const { firstName, age, city } = user;

console.log(firstName); // Alice
console.log(age);  // 30
console.log(city); // Wonderland

// Get only age
const { age: userAge } = user;
console.log(userAge); // 30

// Nested destructuring
const product = {
  id: 1,
  details: {
    name: 'Laptop',
    price: 1500
  }
};

const { details: { name, price } } = product;

console.log(name);  // Laptop
console.log(price); // 1500

// Array
const numbers = [10, 20, 30];
const [first, second, third] = numbers;

console.log(first);  // 10
console.log(second); // 20
console.log(third);  // 30

// Get only the first and second numbers
const [num1, num2] = numbers;

console.log(num1); // 10
console.log(num2); // 20

// Ignore the first number and get the rest
const [, ...restNumbers] = numbers;

console.log(restNumbers); // [20, 30]

// Ignore some items
const [n1, , n3] = numbers;

console.log(n1); // 10
console.log(n3); // 30