// SPDX-License-Identifier:MTT
pragma solidity ^0.8.24;

contract FallbackExample{
   uint256 public result;

   receive() external payable { // called when no data only funds when called
    result = 1;
   }
   fallback() external payable{  //called when data but no matching function to process
    result=2;
   }
}