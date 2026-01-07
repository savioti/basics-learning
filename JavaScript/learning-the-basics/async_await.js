// Using async/await in JavaScript

// A function that returns a promise which resolves after a given time
function delay(ms) {
    return new Promise((resolve) => {
        setTimeout(() => {
            resolve(`Resolved after ${ms} milliseconds`);
        }, ms);
    });
}

// An async function that uses await to handle the promise
async function performDelay(ms) {
    console.log('Starting delay...');
    try {
        const message = await delay(ms);
        console.log(message); 
    } catch (error) {
        console.error('Error:', error);
    }
}

