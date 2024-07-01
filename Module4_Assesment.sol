// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract GamerToken {

    uint256 public totalSupply;
    address public owner;
    string public token_name = "DEGEN";
    string public token_symbol = "DGN";
    uint8 public tokenDecimals = 18;

    constructor() {
        owner = msg.sender;
    }

    mapping(address => uint256) public balances;

    // Mint function
    function mint(address recipient, uint256 amount) public {
        require(msg.sender == owner, "Only the owner can mint tokens.");
        require(amount > 0, "Amount must be greater than 0.");

        balances[recipient] += amount;
        totalSupply += amount;
    }

    // Burn function
    function burn(address account, uint256 amount) public {
        require(amount <= balances[account], "Amount exceeds balance.");

        balances[account] -= amount;
        totalSupply -= amount;
    }

    // Transfer function
    function transfer(address recipient, uint256 amount) public {
        require(amount <= balances[msg.sender], "Amount exceeds balance.");
        require(recipient != address(0), "Cannot transfer to the zero address.");

        balances[msg.sender] -= amount;
        balances[recipient] += amount;
    }

    // Redeem function
    function redeem(address account, uint256 amount, uint256 item) public { 
        require(amount <= balances[account], "Amount exceeds balance");

        if (item == 1) {
            require(amount >= 50, "Insufficient tokens for Item 1");
            burn(account, amount);
        } else if (item == 2) {
            require(amount >= 100, "Insufficient tokens for Item 2");
            burn(account, amount);
        } else if (item == 3) {
            require(amount >= 200, "Insufficient tokens for Item 3");
            burn(account, amount);
        } else {
            revert("Invalid item");
        }
    } 
}
