// SPDX-License-Identifier:MTT
pragma solidity ^0.8.24;

//import "../Create Solidity Smart Contract/SimpleStorage.sol";

import {SimpleStorage} from "../Create Solidity Smart Contract/SimpleStorage.sol";

// Use "Named Imports" as above

contract StorageFactory {
    // // example declaration and structure
    //uint256 public favoriteNumber
    //type visibility name

    //SimpleStorage public simpleStorage;

    SimpleStorage[] public listOfSimpleStorageContracts;

    //  type scope variableName

    function createSimpleStorageContract() public {
        //simpleStorage = new SimpleStorage();
        SimpleStorage newSimpleStorageContract = new SimpleStorage();
        listOfSimpleStorageContracts.push(newSimpleStorageContract);
    }

    function sfStore(
        uint256 _simpleStorageIndex,
        uint256 _newSimpleStorageNumber
    ) public {
        // Address
        //ABI  - Application Binary Interface (technically a lie, you just need the function selector)
        //SimpleStorage mySimpleStorage = listOfSimpleStorageContracts[
        //     _simpleStorageIndex
        // ];
        //mySimpleStorage.store(_newSimpleStorageNumber);
        listOfSimpleStorageContracts[_simpleStorageIndex].store(
            _newSimpleStorageNumber
        );
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        //SimpleStorage mySimpleStorage = listOfSimpleStorageContracts[
        //     _simpleStorageIndex
        //];

        //return mySimpleStorage[
        //           _simpleStorageIndex
        //      ].retrieve();

        return listOfSimpleStorageContracts[_simpleStorageIndex].retrieve();
    }
}
