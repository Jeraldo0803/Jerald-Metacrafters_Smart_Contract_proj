// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

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
