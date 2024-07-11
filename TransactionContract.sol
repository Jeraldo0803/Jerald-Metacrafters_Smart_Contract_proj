//SPDX-License-Identifier: MIT License
pragma solidity ^0.8.13;

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

        uint currentDay = _getCurrentDay();
        // Check daily limit
        require(dailyTotals[currentDay] + _amount <= MAX_DAILY_AMOUNT, "The daily withdrawal limit has been reached");

        value -= _amount;
        dailyTotals[currentDay] += _amount;
    }
}
