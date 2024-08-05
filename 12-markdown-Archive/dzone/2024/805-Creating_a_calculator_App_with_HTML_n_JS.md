## Step-By-Step Guide To Creating a Calculator App With HTML and JS (With Factor Calculator Example)

Learn to Create a Calculator Application through HTML, CSS and JS. This guide will walk you through the steps to build a simple yet functional calculator.
By David Jones user avatar David Jones · Jul. 30, 24 · Tutorial https://dzone.com/articles/step-by-step-guide-to-creating-a-calculator-app?utm_source=Sailthru&utm_medium=email&utm_campaign=DZone_Daily_Digest_08.04.24_Spotlight_Sisense&utm_term=dzone-daily-digest-active

Creating a calculator app is a great way to practice and understand the basics of `HTML`, `CSS`, and `JavaScript`. This guide will walk you through the steps to build a simple yet functional calculator. By the end of this tutorial, you will have a fully operational calculator that can perform basic arithmetic operations.

Calculators are essential tools, and building one is an excellent project for learning web development. This guide will cover the following:

1. Setting up the development environment
1. Creating the HTML structure
1. Styling with CSS
1. Adding JavaScript functionality

Follow along and create your own calculator app. By doing so, you’ll gain hands-on experience in building interactive web applications.

### Setting Up the Development Environment

Before we start coding, ensure you have the necessary tools:

- Text editor: `Visual Studio Code` (VS Code) is recommended.
- Web browser: Chrome, Firefox, or any modern web browser.

Create a new folder for your project and open it in your text editor.

### Creating the HTML Structure

First, we need to set up the basic HTML structure for our calculator. Create a new file named `index.html` and add the following code:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Simple Calculator</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="calculator">
        <input type="text" class="calculator-screen" value="" disabled />
        <div class="calculator-keys">
            <button type="button" class="operator" value="+">+</button>
            <button type="button" class="operator" value="-">-</button>
            <button type="button" class="operator" value="*">×</button>
            <button type="button" class="operator" value="/">÷</button>
            <button type="button" value="7">7</button>
            <button type="button" value="8">8</button>
            <button type="button" value="9">9</button>
            <button type="button" value="4">4</button>
            <button type="button" value="5">5</button>
            <button type="button" value="6">6</button>
            <button type="button" value="1">1</button>
            <button type="button" value="2">2</button>
            <button type="button" value="3">3</button>
            <button type="button" value="0">0</button>
            <button type="button" class="decimal" value=".">.</button>
            <button type="button" class="all-clear" value="all-clear">AC</button>
            <button type="button" class="equal-sign operator" value="=">=</button>
        </div>
    </div>

</body>
</html>
```

This HTML code creates the structure of the calculator, including the display screen and buttons for numbers, operators, and special functions.

### Styling With CSS

Next, we’ll add some styling to make our calculator look better. Create a new file named `style.css` and add the following code:

```CSS
body {
    font-family: 'Arial', sans-serif;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    background-color: #f0f0f0;
}

.calculator {
    border-radius: 5px;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
}

.calculator-screen {
    width: 100%;
    height: 80px;
    border: none;
    background-color: #252525;
    color: #fff;
    font-size: 2.2em;
    text-align: right;
    padding: 10px;
    box-sizing: border-box;
}

.calculator-keys button {
    height: 60px;
    width: 25%;
    border: 1px solid #d4d4d2;
    background-color: #fff;
    font-size: 1.2em;
    transition: background-color 0.3s;
}

.calculator-keys button.operator {
    background-color: #f5923e;
    color: #fff;
}

.calculator-keys button.equal-sign {
    height: calc(100% * 2 / 5);
    background-color: #2e86de;
    color: #fff;
}

.calculator-keys button:hover {
    background-color: #eaeaea;
}

.calculator-keys button.operator:hover {
    background-color: #ff9f47;
}

.calculator-keys button.equal-sign:hover {
    background-color: #4a90e2;
}
```

This CSS code provides basic styling for the calculator, making it visually appealing and user-friendly.

### Adding JavaScript Functionality

Finally, we need to add JavaScript to make our calculator functional. Create a new file named `script.js` and add the following code:

```JavaScript
const calculator = {
    displayValue: '0',
    firstOperand: null,
    waitingForSecondOperand: false,
    operator: null,
};

function inputDigit(digit) {
    const { displayValue, waitingForSecondOperand } = calculator;

    if (waitingForSecondOperand === true) {
        calculator.displayValue = digit;
        calculator.waitingForSecondOperand = false;
    } else {
        calculator.displayValue = displayValue === '0' ? digit : displayValue + digit;
    }
}

function inputDecimal(dot) {
    if (calculator.waitingForSecondOperand === true) return;

    if (!calculator.displayValue.includes(dot)) {
        calculator.displayValue += dot;
    }
}

function handleOperator(nextOperator) {
    const { firstOperand, displayValue, operator } = calculator;
    const inputValue = parseFloat(displayValue);

    if (operator && calculator.waitingForSecondOperand)  {
        calculator.operator = nextOperator;
        return;
    }

    if (firstOperand == null && !isNaN(inputValue)) {
        calculator.firstOperand = inputValue;
    } else if (operator) {
        const result = performCalculation[operator](firstOperand, inputValue);

        calculator.displayValue = String(result);
        calculator.firstOperand = result;
    }

    calculator.waitingForSecondOperand = true;
    calculator.operator = nextOperator;
}

const performCalculation = {
    '/': (firstOperand, secondOperand) => firstOperand / secondOperand,
    '*': (firstOperand, secondOperand) => firstOperand * secondOperand,
    '+': (firstOperand, secondOperand) => firstOperand + secondOperand,
    '-': (firstOperand, secondOperand) => firstOperand - secondOperand,
    '=': (firstOperand, secondOperand) => secondOperand
};

function resetCalculator() {
    calculator.displayValue = '0';
    calculator.firstOperand = null;
    calculator.waitingForSecondOperand = false;
    calculator.operator = null;
}

function updateDisplay() {
    const display = document.querySelector('.calculator-screen');
    display.value = calculator.displayValue;
}

updateDisplay();

const keys = document.querySelector('.calculator-keys');
keys.addEventListener('click', (event) => {
    const { target } = event;
    if (!target.matches('button')) {
        return;
    }

    if (target.classList.contains('operator')) {
        handleOperator(target.value);
        updateDisplay();
        return;
    }

    if (target.classList.contains('decimal')) {
        inputDecimal(target.value);
        updateDisplay();
        return;
    }

    if (target.classList.contains('all-clear')) {
        resetCalculator();
        updateDisplay();
        return;
    }

    inputDigit(target.value);
    updateDisplay();
});
```

This JavaScript code handles the functionality of the calculator, including inputting digits, performing calculations, and updating the display.

### Basic Factor Calculator Example

Let's create an example of a calculator that computes the factors of a given number using HTML, CSS, and JavaScript. This factors calculator will take a number input from the user and display all the factors of that number.

#### HTML Structure

First, create the basic HTML structure for the factors calculator. Create a new file named `factors.html` and add the following code:

```HTML
<!DOCTYPE html>
<html lang="en">
<head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Factors Calculator</title>
        <link rel="stylesheet" href="factors.css">
</head>
<body>
        <div class="calculator">
        <h1>Factors Calculator</h1>
        <input type="number" id="numberInput" placeholder="Enter a number" />
        <button id="calculateButton">Calculate Factors</button>
        <div id="result"></div>
        </div>
        <script src="factors.js"></script>
</body>
```

#### CSS Styling

Next, add some styling to make the factors calculator look better. Create a new file named `factors.css` and add the following code:

```CSS
css
body {
        font-family: 'Arial', sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        background-color: #f0f0f0;
        margin: 0;
}
.calculator {
        text-align: center;
        border-radius: 5px;
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
        padding: 20px;
        background-color: #fff;
}
#numberInput {
        width: 200px;
        height: 40px;
        font-size: 1.2em;
        margin-bottom: 10px;
        padding: 5px;
}
#calculateButton {
        height: 40px;
        width: 200px;
        font-size: 1.2em;
        background-color: #2e86de;
        color: #fff;
        border: none;
        cursor: pointer;
        transition: background-color 0.3s;
}
#calculateButton:hover {
        background-color: #4a90e2;
}
```

#### JavaScript Functionality

Finally, add the JavaScript code to handle the calculation of factors. Create a new file named `factors.js` and add the following code:

```JavaScript
javascript
document.getElementById('calculateButton').addEventListener('click', function() {
        const numberInput = document.getElementById('numberInput').value;
        const resultDiv = document.getElementById('result');
        if (numberInput === '' || isNaN(numberInput)) {
                resultDiv.innerHTML = 'Please enter a valid number.';
                return;
        }
        const number = parseInt(numberInput);
        const factors = calculateFactors(number);
        resultDiv.innerHTML = `Factors of ${number}: ${factors.join(', ')}`;
});
function calculateFactors(number) {
        const factors = [];
        for (let i = 1; i <= number; i++) {
                if (number % i === 0) {
                        factors.push(i);
                }
        }
return factors;
}
```

#### Putting It All Together

Now you have all the files needed for the factors calculator. The HTML file provides the structure, the CSS file styles the calculator, and the JavaScript file adds the functionality to compute and display the factors of the input number.

When you open `factors.html` in a web browser, you should see an input field to enter a number and a button to calculate the factors. Upon entering a number and clicking the "`Calculate Factors`" (Live Exampler) button, the calculator will display all the factors of the entered number.

This project helps you understand how to integrate HTML, CSS, and JavaScript to create a functional web application. Feel free to customize the calculator further to enhance its features and appearance. If you have any questions or improvements, please share your thoughts!

### Conclusion

By following this guide, you have created a fully functional calculator app using HTML, CSS, and JavaScript. This project helps you understand the basics of web development and provides a foundation for more complex applications. Feel free to customize and expand your calculator to include additional features and improve its functionality.

If you have any questions or want to share your version of the calculator, please leave a comment below. Happy coding!

