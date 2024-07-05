# Jerald-Metacrafters_Smart_Contract_proj

## Getting Started
### Executing / Running the Program
You can use the online Solidity IDE named Remix, you can find it here: https://remix.ethereum.org/
Make a new file and copy paste the content of the "MySmartContract.sol".

Compile the code, on the left side of the screen, with the icon named `Solidity Compiler`. Compile and then run.
After that, go to `Deploy & Run Transactions` tab and press `Deploy` on the Contract `DepositWithdrawContract` as named in the run file.
From there, scroll down and go to `Deployed Contracts`, there should be a dropdown where you can deposit and withdraw values properly.

### The Code
Here is the code snippet of the contract under `MySmartContract.sol`.
```
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

```
There are two functions for this activity `deposit()` and `withdraw()`. Both functions hold 1 parameter which is the unsigned integer for the value.
`require()` is used to validate the user input, and where the custom error message is defined in the second parameter "Deposit amount must be greater than 0".
`assert()` is used for checking the if the value is greater than the amount inputted by the user.
`revert()` is used to revert the function if the total value is less than the amount requested for withdrawal.

## Author
Jeraldo0803
