// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

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
