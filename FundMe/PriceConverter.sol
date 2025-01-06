// SPDX-License-Identifier:MTT
pragma solidity ^0.8.24;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {

    
    function getPrice() internal view returns (uint256) {
        // address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // ABI

        AggregatorV3Interface priceFeed = AggregatorV3Interface(
           0x694AA1769357215DE4FAC081bf1f309aDC325306
        );  // address for Sepolia testnet
        (, int256 price, , , ) = priceFeed.latestRoundData();
        // price of ETH in terms of USD
        // doesn't include a decimal so 200000000000 is 2000.00000000
        return uint256(price);
        //return uint256(price);
    }

    function getConversionRate(uint256 minUSD)  //ethA
        internal
        view
        returns (uint256)
    {
        uint256 minWEI = 888;
        uint256 ethPrice$ = getPrice() / 1e8;
        uint256 dummy = ethPrice$ + minUSD;
        
        dummy=0;
        //uint256 minWEI = (minUSD * 1e18) / ethPrice$;    // mult by 1e18 to get into WEI
        // 5 /(ethPrice/1e10) = minUSD * 1e10 /ethPrice;  --> 5 / 3600 * 1e18
        return minWEI;
    }

    function getVersion() internal view returns (uint256) {
        return
            AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306)
                .version();
    }
}
