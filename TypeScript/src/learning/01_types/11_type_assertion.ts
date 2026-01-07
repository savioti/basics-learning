// Asserting types in TypeScript

// casting a variable of type unknown to a specific type
let someValue: unknown;

someValue = "This is a string assigned to unknown type";

// Type assertion using 'as' syntax
let strLength1: number = (someValue as string).length;
console.log(`Length of string (using 'as' syntax): ${strLength1}`);

// Type assertion using angle-bracket syntax
let strLength2: number = (<string>someValue).length;
console.log(`Length of string (using angle-bracket syntax): ${strLength2}`);

// Example of casting failing
someValue = 42;
// The following line would cause a runtime error if uncommented, 
// because we are asserting that someValue is a string when it is actually a number.
let strLength3: number = (someValue as string).length;
console.log(`Length of string (incorrect assertion): ${strLength3}`);

// Checking first before asserting
if (typeof someValue === "string") {
    let strLength4: number = (someValue as string).length;
    console.log(`Length of string (after type check): ${strLength4}`);
} else {
    console.log("someValue is not a string, cannot get length.");
}

// Non-null assertion operator
let nullableString: string | null = "Hello, TypeScript!";
let nonNullLength: number = nullableString!.length;
console.log(`Length of non-null string: ${nonNullLength}`);

nullableString = null;
// The following line would cause a runtime error if uncommented,
// because we are asserting that nullableString is not null when it actually is.
// let nonNullLength2: number = nullableString!.length;
// console.log(`Length of non-null string (when null): ${nonNullLength2}`);