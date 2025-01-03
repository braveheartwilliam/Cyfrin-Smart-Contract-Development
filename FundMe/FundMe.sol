// Get funds from users
// Withdraw funds
//Set a minimum funding value in USD

// SPDX-License-Identifier:MTT
pragma solidity ^0.8.24;

contract FundMe{
    function fund() public payable {
        //Allow users to send $
        //Enforce a minimum $ amount to send
        // 1. How do we send ETH to this contract?
        require(msg.value > 1e18, "didn't sent enough Wei"); // 1e18 = 1 ETH = 1000000000000000000 wei = 1 * 10**18

    }

    function withdraw() public {}
}