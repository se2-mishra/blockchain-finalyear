// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract Ownable {

    address private _owner;
    address private _successor;

    event OwnershipTransferred(address indexed oldOwner, address indexed newOwner);

    constructor() {
        _transferOwnership(msg.sender);
    }

    function owner() public view virtual returns (address) {
        return _owner;
    }

    modifier onlyOwner() {
        require(owner() == msg.sender, "Ownable: caller is not the owner");
        _;
    }

    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Invalid owner address");
        _transferOwnership(newOwner);
    }

    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }

    function proposeOwner(address newOwner) external onlyOwner {
        require(newOwner != address(0), "Invalid address");
        emit OwnershipTransferred(owner(), newOwner);
        _successor = newOwner;
    }

    // function acceptOwnership() public {
    //     require(msg.sender == _successor, "Only successor can accept ownership");
    //     address oldOwner = owner();
    //     _transferOwnership(_successor);
    //     _successor = address(0); // Reset successor after ownership transfer
    //     emit OwnershipTransferred(oldOwner, _successor);
    // }

    // function successor() public view returns (address) {
    //     return _successor;
    // }
}
