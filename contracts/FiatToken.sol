// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.0;

// import "./Ownable.sol";

// contract FiatToken is Ownable {
//     string public name;
//     string public symbol;
//     string public currency;
//     uint8 public decimals;

//     address public masterMinter;

//     mapping(address => uint256) public balanceOf;
//     mapping(address => mapping(address => uint256)) public allowance;
//     mapping(address => bool) public isMinter;
//     mapping(address => uint256) public minterAllowance;

//     uint256 public totalSupply;

//     event Transfer(address indexed from, address indexed to, uint256 value);
//     event Approval(address indexed owner, address indexed spender, uint256 value);
//     event Mint(address indexed minter, address indexed to, uint256 amount);
//     event Burn(address indexed burner, uint256 amount);
//     event MinterConfigured(address indexed minter, uint256 minterAllowedAmount);
//     event MinterRemoved(address indexed oldMinter);
//     event MasterMinterChanged(address indexed newMasterMinter);
//     event NewOwnerProposed(address indexed previousOwner, address indexed newOwner);
//     event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

//     constructor(
//         string memory _name,
//         string memory _symbol,
//         string memory _currency,
//         uint8 _decimals,
//         address _masterMinter,
//         address _owner
//     ) Ownable() {
//         name = _name;
//         symbol = _symbol;
//         currency = _currency;
//         decimals = _decimals;
//         masterMinter = _masterMinter;
//         transferOwnership(_owner);
//     }

//     function transferOwnership(address newOwner) public virtual override onlyOwner {
//         require(newOwner != address(0), "Invalid owner address");
//         address oldOwner = owner();
//         super.transferOwnership(newOwner);
//         emit NewOwnerProposed(oldOwner, newOwner);
//     }

//     function acceptOwnership() public {
//         require(msg.sender == successor(), "Only successor can accept ownership");
//         address oldOwner = owner();
//         super.acceptOwnership();
//         emit OwnershipTransferred(oldOwner, owner());
//     }

//     function proposeMasterMinter(address newMasterMinter) external onlyOwner {
//         require(newMasterMinter != address(0), "Invalid address");
//         emit MasterMinterChanged(newMasterMinter);
//         masterMinter = newMasterMinter;
//     }

//     function configureMinter(address minter, uint256 minterAllowedAmount) external onlyOwner {
//         require(minter != address(0), "Invalid address");
//         emit MinterConfigured(minter, minterAllowedAmount);
//         isMinter[minter] = true;
//         minterAllowance[minter] = minterAllowedAmount;
//     }

//     function removeMinter(address minter) external onlyOwner {
//         require(isMinter[minter], "Not a minter");
//         emit MinterRemoved(minter);
//         isMinter[minter] = false;
//         delete minterAllowance[minter];
//     }

//     function mint(address to, uint256 amount) external returns (bool) {
//         require(isMinter[msg.sender], "Not a minter");
//         require(to != address(0), "Invalid address");
//         require(totalSupply + amount >= totalSupply, "Integer overflow");
//         require(balanceOf[to] + amount >= balanceOf[to], "Integer overflow");

//         totalSupply += amount;
//         balanceOf[to] += amount;
//         emit Mint(msg.sender, to, amount);
//         emit Transfer(address(0), to, amount);
//         return true;
//     }

//     function burn(uint256 amount) external {
//         require(amount <= balanceOf[msg.sender], "Insufficient balance");
//         require(amount <= totalSupply, "Insufficient total supply");

//         totalSupply -= amount;
//         balanceOf[msg.sender] -= amount;
//         emit Burn(msg.sender, amount);
//         emit Transfer(msg.sender, address(0), amount);
//     }

//     function approve(address spender, uint256 amount) external returns (bool) {
//         allowance[msg.sender][spender] = amount;
//         emit Approval(msg.sender, spender, amount);
//         return true;
//     }

//     function transfer(address to, uint256 amount) external returns (bool) {
//         _transfer(msg.sender, to, amount);
//         return true;
//     }

//     function transferFrom(address from, address to, uint256 amount) external returns (bool) {
//         require(amount <= allowance[from][msg.sender], "Exceeds allowance");
//         _transfer(from, to, amount);
//         allowance[from][msg.sender] -= amount;
//         return true;
//     }

//     function _transfer(address from, address to, uint256 amount) internal {
//         require(to != address(0), "Invalid address");
//         require(balanceOf[from] >= amount, "Insufficient balance");

//         balanceOf[from] -= amount;
//         balanceOf[to] += amount;
//         emit Transfer(from, to, amount);
//     }
// }
