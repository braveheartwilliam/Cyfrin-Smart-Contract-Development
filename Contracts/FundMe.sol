// Get funds from users
// Withdraw funds
//Set a minimum funding value in USD

// SPDX-License-Identifier:MTT
pragma solidity ^0.8.24;

// Not necessary but shows functions available using the interface "AggregatorV3Interface" function call (see below)
// 'XXX' at end to prevent duplicate declaration

import {PriceConverter} from "./PriceConverter.sol";
error NotOwner();

contract FundMe {
    using PriceConverter for uint256; // converts all data to uint256

    //uint256 public minimumUSD = 5 * 1e18; // or 5e18

    uint256 public constant MINIMUM_USD = 5 * 1e18; // SAVES GAS

    address[] public funders;
    uint256 public priceVersion = PriceConverter.getVersion();
    mapping(address => uint256) public addressToAmountFunded;
    address public immutable i_owner;

    constructor() {
        i_owner = msg.sender; // original establishment of contract on blockchain by creator that deployed the contract
    }

    function fund() public payable {
        //msg.value.getConversionRate() -- uses msg.value as the input to the function getConversionRate

        // require(getConversionRate(msg.value) >= minimumUSD, "didn't sent enough Wei"); // 1e18 = 1 ETH = 1000000000000000000 wei = 1 * 10**18
        require(
            msg.value.getConversionRate() >= MINIMUM_USD,
            "didn't sent enough Wei"
        ); // 1e18 = 1 ETH = 1000000000000000000 wei = 1 * 10**18
        funders.push(msg.sender);
        //addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
        addressToAmountFunded[msg.sender] += msg.value;
    }
    

    function withdraw() public onlyOwner {
        // for loop
        //require(msg.sender == owner); --- instead use a Solidity "modifier" ( see below)
        for (
            /* starting index, ending index, step amount*/
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        funders = new address[](0);

        // Ways to send ETH from a contract
        // //1. transfer - AUTOMATICALLY REVERTS IF TRANSFER FAILS
        // //msg.sender is type address
        // // payable(mesg.sender) is type payable
        // payable(msg.sender).transfer(address(this).balance);

        // //2. Send - DOES NOT AUTOMATICALLY REVER IF SEND FAILS; MUST CHECK FOR FAILURE AND REVERT IN CODE
        //bool sendSuccess = payable(msg.sender).send(address(this).balance);
        //require(sendSuccess, "Send failure");

        //3. call (call any function in Solidity without having the ABI) ** MAY BE RECOMMENDED OPTION STILL

        //(bool callSuccess, bytes memory dataReturned) = payable(msg.sender).call{value: address(this).balance}("");
        // Don't need dataReturned so can ignore by not referencing.
        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(callSuccess, "call failed");
    }

    modifier onlyOwner() {
        //require(msg.sender == i_owner, "Sender is not owner"); // message sender must be owner

        //The following replaces above and uses less gas.  Note: NotOwner defined outside of contract with type "error"
        if (msg.sender == i_owner) {
            revert NotOwner();
        }

        _; // if is the owner, execute the remainder of the code in the function
    }

    receive() external payable {
        fund();
    }
    fallback() external payable {
        fund();
    }
}