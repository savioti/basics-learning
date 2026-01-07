// Example of literal types in TypeScript

// Literal types allow you to specify exact values a variable can hold.
type Direction = 'up' | 'down' | 'left' | 'right';

function move(direction: Direction) {
    console.log(`Moving ${direction}`);
}

move('up');    // Valid
move('down');  // Valid
// move('forward'); // Error: Argument of type '"forward"' is not assignable to parameter of type 'Direction'.

// You can also use numeric literal types
type DiceRoll = 1 | 2 | 3 | 4 | 5 | 6;
function rollDice(roll: DiceRoll) {
    console.log(`You rolled a ${roll}`);
}

rollDice(3); // Valid
// rollDice(7); // Error: Argument of type '7' is not assignable to parameter of type 'DiceRoll'.

// Literal types can be combined with union types
type Status = 'success' | 'error' | 'loading';
function printStatus(status: Status) {
    console.log(`Status: ${status}`);
}

printStatus('success'); // Valid
// printStatus('pending'); // Error: Argument of type '"pending"' is not assignable to parameter of type 'Status'.