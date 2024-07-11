# Jerald-Metacrafters_Smart_Contract_proj

## Getting Started
### Executing / Running the Program
- You can use the online Solidity IDE named Remix, you can find it here: https://remix.ethereum.org/
- Make a new file and copy paste the content of the `TransactionContract.sol`.

- Compile the code, on the left side of the screen, with the icon named `Solidity Compiler`. Compile and then run.
- After that, go to `Deploy & Run Transactions` tab and press `Deploy` on the Contract `TransactionContract` as named in the run file.
- From there, scroll down and go to `Deployed Contracts`, here is where you can deposit and withdraw, and also check the MAX_TRANSACTION_AMOUNT and the MAX_DAILY_AMOUNT.

Here is the code snippet of the contract under `TransactionContract.sol`.
```
contract TransactionContract {
    uint public value;

    // Maximum deposit/withdrawal per transaction
    uint public constant MAX_TRANSACTION_AMOUNT = 1000;
    // Maximum total deposit/withdrawal per day
    uint public constant MAX_DAILY_AMOUNT = 10000;

    // Store daily totals
    mapping(uint => uint) public dailyTotals;

    // Struct to store transaction data
    struct Transaction {
        uint amount;
        uint timestamp;
    }

    function _getCurrentDay() private view returns (uint) {
        return block.timestamp / 1 days;
    }

    function deposit(uint _value) public {
        // Require valid deposit amount
        require(_value > 0 && _value <= MAX_TRANSACTION_AMOUNT, "Invalid deposit amount");

        uint currentDay = _getCurrentDay();
        // Check daily limit
        require(dailyTotals[currentDay] + _value <= MAX_DAILY_AMOUNT, "The daily deposit limit has been reached");

        value += _value;
        dailyTotals[currentDay] += _value;
    }

    function withdraw(uint _amount) public {
        assert(value >= _amount);

        // Require valid withdrawal amount
        if (_amount <= 0 || _amount > MAX_TRANSACTION_AMOUNT) {
            revert("Invalid withdrawal amount");
        }

        //require(_amount > 0 && _amount <= MAX_TRANSACTION_AMOUNT, "Invalid withdrawal amount");

        uint currentDay = _getCurrentDay();
        // Check daily limit
        require(dailyTotals[currentDay] + _amount <= MAX_DAILY_AMOUNT, "The daily withdrawal limit has been reached");

        value -= _amount;
        dailyTotals[currentDay] += _amount;
    }
}
```
- There are two functions for this activity `deposit()` and `withdraw()`. Both functions hold 1 parameter which is the unsigned integer for the value.
- The `_getCurrentDay()` uses the Unix block.timestamp.
- `require()` is used to validate the user input, and where the custom error message is defined in the second parameter "Deposit amount must be greater than 0".
- `assert()` is used for checking the if the value is greater than the amount inputted by the user.
- `revert()` is used to revert the function if the total value is less than the amount requested for withdrawal.

## Author
Jeraldo0803
