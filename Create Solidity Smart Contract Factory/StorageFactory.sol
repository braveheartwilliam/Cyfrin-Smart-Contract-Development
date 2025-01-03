// SPDX-License-Identifier:MTT
pragma solidity ^0.8.24;

contract SimpleStorage {
	uint256 myFavoriteNumber; // 0
	uint256[] listOfFavoriteNumbers;
	struct Person {
		uint256 favoriteNumber;
		string name;
	}
	Person[] public listOfPeople;
    mapping(string => uint256) public nameToFavoriteNumber;

	function store(uint256 _favoriteNumber) public {
		myFavoriteNumber = _favoriteNumber;
	}

	function retrieve() public view returns (uint256) {
		return myFavoriteNumber;
	}

	function addPerson(string memory _name, uint256 _favoriteNumber) public {
		//listOfPeople.push(_name, _favoriteNumber);
		listOfPeople.push(Person(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
	}


}

contract StorageFactory{
	// // example declaration and structure
	//uint256 public favoriteNumber
	//type visibility name

	SimpleStorage public simpleStorage;
	//  type scope variableName

	

    function createSimpleStorageContract() public{
simpleStorage = new SimpleStorage();    
}


}