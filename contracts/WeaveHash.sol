// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Ownable.sol";

contract WeaveHash is Ownable {
    // Struct to store hash data
    struct DataHash {
        uint256 id;
        string hash;
        string metadata;
    }
    
    // Event emitted when a new hash is added
    event NewHash(address indexed sender, uint256 id, string hash, string metadata);
    
    // State variables
    uint256 public Count;
    mapping(uint256 => DataHash) public hashes;
    mapping(uint256 => bool) public hashExists;

    // Constructor
    constructor() Ownable() {}
    
    // Function to read the hash data
    function readHash(uint256 id) external view returns (DataHash memory) {
        require(hashExists[id], "Hash with given id does not exist");
        return hashes[id];
    }
    
    // Function to read all hash data
    function readHashes() external view returns (string[] memory) {
        string[] memory allHashes = new string[](Count);
        for (uint256 i = 0; i < Count; i++) {
            allHashes[i] = hashes[i].hash;
        }
        return allHashes;
    }
    
    // Function to store a new hash
    function storeHash(uint256 id, string memory hash, string memory metadata) external onlyOwner {
        require(!hashExists[id], "Hash with given id already exists");
        hashes[id] = DataHash(id, hash, metadata);
        hashExists[id] = true;
        Count++;
        emit NewHash(msg.sender, id, hash, metadata);
    }
    
    // Function to reset all hashes
    function resetHashes() external onlyOwner {
        for (uint256 i = 0; i < Count; i++) {
            delete hashes[i];
            hashExists[i] = false;
        }
        Count = 0;
    }
}
