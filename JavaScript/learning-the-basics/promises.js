// Example of promises in JavaScript

// A function that returns a promise which resolves after a given time
function delay(ms) {
    return new Promise((resolve) => {
        setTimeout(() => {
            resolve(`Resolved after ${ms} milliseconds`);
        }, ms);
    });
}

// Using the promise
console.log('Starting delay...');
delay(1000)
    .then((message) => {
        console.log(message); // Logs: Resolved after 2000 milliseconds
    })
    .catch((error) => {
        console.error('Error:', error);
    });

// Simulating a API call with a promise
function fetchData() {
    return new Promise((resolve, reject) => {
        const success = true; // Change to false to simulate an error
        setTimeout(() => {
            if (success) {
                resolve({ data: 'Sample data from API' });
            } else {
                reject('Failed to fetch data');
            }
        }, 2000);
    });
}

// Using the fetchData promise
fetchData()
    .then((response) => {
        console.log('Data received:', response.data);
    })
    .catch((error) => {
        console.error('Error:', error);
    });

// Promise methods
// Using Promise.all to wait for multiple promises
Promise.all([delay(500), delay(1000), delay(1500)])
    .then((messages) => {
        console.log('All promises resolved:', messages);
    })
    .catch((error) => {
        console.error('Error in Promise.all:', error);
    });

// Using Promise.race to get the first resolved promise
Promise.race([delay(500), delay(1000), delay(1500)])
    .then((message) => {
        console.log('First promise resolved:', message);
    })
    .catch((error) => {
        console.error('Error in Promise.race:', error);
    });

// Using Promise.resolve to create a resolved promise
const resolvedPromise = Promise.resolve('This promise is already resolved');

resolvedPromise.then((message) => {
    console.log(message);
});

// Using Promise.reject to create a rejected promise
const rejectedPromise = Promise.reject('This promise is already rejected');

rejectedPromise.catch((error) => {
    console.error(error);
});