// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IPFSHandlerV2 {
    function storeData(string memory _data) external returns (bytes32);
    function retrieveData(bytes32 _hash) external view returns (string memory);
}
