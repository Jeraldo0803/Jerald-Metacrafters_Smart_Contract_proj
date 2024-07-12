# Jerald-Metacrafters_Smart_Contract_proj

## Getting Started
### Executing / Running the Program
- You can use the online Solidity IDE named Remix, you can find it here: https://remix.ethereum.org/
- Make a new file and copy paste the content of the `CrowdfundingContract.sol`.

- Compile the code, on the left side of the screen, with the icon named `Solidity Compiler`. Compile and then run.
- After that, go to `Deploy & Run Transactions` tab and press `Deploy` on the Contract `CrowdfundingContract` as named in the run file.
- From there, scroll down and go to `Deployed Contracts`, you can select the currentTime, the total contributions of the address of the owner (or others), and more.
- To contribute, type a value on the upper part of the Deployed Contracts pane, make sure to put a positive value of more than 0.
- Once you have typed a value, click on the red `contribute` button to continue the transaction, it should work and the contributions within the correct address should increase or change.

Here is the code snippet of the contract under `CrowdfundingContract.sol`.
```

contract CrowdfundingContract {
    address payable public owner;
    uint256 public goalAmount = 10 ether;
    uint256 public currentTime = block.timestamp;
    uint256 public deadline = block.timestamp + 30 days;
    mapping(address => uint256) public contributions;
    bool public campaignActive = true;

    constructor() {
        owner = payable(msg.sender);
        assert(goalAmount > 0);
    }

    function contribute() public payable {
        require(campaignActive, "Campaign is no longer active.");
        require(block.timestamp <= deadline, "Deadline has passed.");

        if (msg.value <= 0) {
          revert("Contribution must be greater than 0");
        }

        // Update the total contributions
        contributions[msg.sender] += msg.value;

        // Check if the goal has been reached
        require(contributions[msg.sender] < goalAmount, "Goal reached. No more contributions accepted.");

        // Transfer funds to the owner
        owner.transfer(msg.value);

        emit ContributionMade(msg.sender, msg.value);
    }

    event ContributionMade(address contributor, uint256 amount);

    function deactivateCampaign() public {
        require(msg.sender == owner, "Only the owner can deactivate the campaign.");
        campaignActive = false;
    }
}

```
- There `contribute()` is a payable function that takes the value inputted by the user on the top left of the Contract Deployment pane.
- The `currentTime` uses the Unix block.timestamp, while the `deadline` increases it by 30 days, which makes the deadline happen thirty days after the contract is deployed.
- `require()` is used a lot on this activity, especially for checking if the campaign is active, or if the deadline has been reached.
- `assert()` is used to check if the goalAmount is more than 0 in the constructor, this ensures that the Crowdfunding contract has values in it.
- `revert()` is used to revert the contribution if the value input is not a positive integer.

## Author
Jeraldo0803
