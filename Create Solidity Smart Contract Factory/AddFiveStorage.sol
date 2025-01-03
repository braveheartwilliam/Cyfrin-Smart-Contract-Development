// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {SimpleStorage} from "../Create Solidity Smart Contract/SimpleStorage.sol";

contract AddFiveStorage is SimpleStorage {
    // overrides -- "virtual" "override"
    // "virtual" must be added to the original function after public

    function store(uint256 _newNumber) public override {
        myFavoriteNumber = _newNumber +5;
    }
}
