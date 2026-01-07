// Type never in TypeScript

// The 'never' type represents values that never occur.
// It is used to indicate that a function never returns (e.g., it always throws an error or has an infinite loop).
// Example 1: A function that always throws an error
function throwError(message: string): never {
    throw new Error(message);
}

// Example 2: A function with an infinite loop
// function infiniteLoop(): never {
//     while (true) {
//         // Loop forever
//     }
// }

// Example 3: Using 'never' in exhaustive type checking
type Shape = 
    | { kind: 'circle'; radius: number }
    | { kind: 'square'; sideLength: number };

function getArea(shape: Shape): number {
    switch (shape.kind) {
        case 'circle':
            return Math.PI * shape.radius ** 2;
        case 'square':
            return shape.sideLength ** 2;
        default:
            // The following line ensures that all cases are handled
            const _exhaustiveCheck: never = shape;
            return _exhaustiveCheck;
    }
}

// Example usage
try {
    throwError("This is an error!");
} catch (e) {
    console.error(e);
}

// Note: The infiniteLoop function is not called here to avoid an actual infinite loop.

const myCircle: Shape = { kind: 'circle', radius: 5 };
console.log(`Area of circle: ${getArea(myCircle)}`);