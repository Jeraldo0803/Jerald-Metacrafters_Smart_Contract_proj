// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract DepositWithdrawContract {
  uint public value;

  function deposit(uint _value) public {
    require(_value > 0, "Deposit amount must be greater than 0");
    value += _value;
  }

  function withdraw(uint _amount) public {
    assert(value >= _amount);
    if (value < _amount) {
      revert("Insufficient balance to withdraw");
    }

    value -= _amount;
  }
}
