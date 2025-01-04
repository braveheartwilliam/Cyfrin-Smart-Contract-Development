// Get funds from users
// Withdraw funds
//Set a minimum funding value in USD

// SPDX-License-Identifier:MTT
pragma solidity ^0.8.24;

// Not necessary but shows functions available using the interface "AggregatorV3Interface" function call (see below)
// 'XXX' at end to prevent duplicate declaration
interface AggregatorV3InterfaceXXXX {
    function decimals() external view returns (uint8);

    function description() external view returns (string memory);

    function version() external view returns (uint256);

    function getRoundData(uint80 _roundId)
        external
        view
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        );

    function latestRoundData()
        external
        view
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        );
}

// alternative to using above

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    uint256 public minimumUSD = 5 * 1e18; // or 5e18

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    function fund() public payable {
        //Allow users to send $
        //Enforce a minimum $ amount to send
        // 1. How do we send ETH to this contract?

        require(getConversionRate(msg.value) >= minimumUSD, "didn't sent enough Wei"); // 1e18 = 1 ETH = 1000000000000000000 wei = 1 * 10**18
        // revert undo actions that have been done, and send the remaining gas back
        // some gas may not have been used and will be returned to function caller

        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }

    function getPrice() public view returns (uint256) {
        // address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // ABI

        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        (, int256 price, , , ) = priceFeed.latestRoundData();
        // price of ETH in terms of USD
        // doesn't include a decimal so 200000000000 is 2000.00000000
        return uint256(price * 1e10);
    }

    function getConversionRate(uint256 ethAmount)
        public
        view
        returns (uint256)
    {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethAmount * ethPrice) / 1e18;
        // 1000000000000000000 * 1000000000000000000 = 1000000000000000000000000000000000000 so need to divide out 18 zeroes
        return ethAmountInUsd;
    }

    function getVersion() public view returns (uint256) {
        return
            AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306)
                .version();
    }

    function withdraw() public {}
}
