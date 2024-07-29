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
    uint256 public goalAmount = 100000;
    uint256 public currentTime = block.timestamp;
    uint256 public deadline = block.timestamp + 30 days;
    mapping(address => uint256) public contributions;
    uint256 public totalContributions = 0;
    bool public campaignActive = true;

    constructor() {
        owner = payable(msg.sender);
        assert(owner == msg.sender);
        assert(goalAmount > 0);
        assert(deadline == block.timestamp + 30 days);
    }
    
    function contribute() public payable {
        require(campaignActive, "Campaign is no longer active.");
        require(block.timestamp <= deadline, "Deadline has passed.");

        if (totalContributions > goalAmount) {
            revert("Goal has been reached, no new contributions are accepted.");
        }

        if (msg.value <= 0) {
          revert("Contribution must be greater than 0");
        }
        // Update the total contributions
        contributions[msg.sender] += msg.value;
        totalContributions += msg.value;

        // Transfer funds to the owner
        owner.transfer(msg.value);

        emit ContributionMade(msg.sender, msg.value);

        // Check if the goal has been reached
        if (totalContributions >= goalAmount) {
            emit GoalReached(totalContributions);
        }
    }

    event ContributionMade(address contributor, uint256 amount);
    event GoalReached(uint256 totalContributions);

    function deactivateCampaign() public {
        require(msg.sender == owner, "Only the owner can deactivate the campaign.");
        campaignActive = false;
    }

    function reactivateCampaign() public {
        require(msg.sender == owner, "Only the owner can reactivate the campaign.");
        campaignActive = true;
    }

    function isGoalReached() public view returns (bool) {
    return totalContributions >= goalAmount;
    }
}
```
- There `contribute()` is a payable function that takes the value inputted by the user on the top left of the Contract Deployment pane.
- The `currentTime` uses the Unix block.timestamp, while the `deadline` increases it by 30 days, which makes the deadline happen thirty days after the contract is deployed.
- `require()` is used a lot on this activity, especially for checking if the campaign is active, or if the deadline has been reached.
- `assert()` is used to strictly check if the defined value within it is true or false, it is done mostly on the constructor or when the contract is being initialized.
- `revert()` is used to revert the contribution if the value input is not a positive integer.

## Author
Jeraldo0803
