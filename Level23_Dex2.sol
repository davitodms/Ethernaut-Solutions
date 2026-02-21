// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FakeToken is ERC20 {
    constructor() ERC20("Fake", "FTK") {
        // Mint 400 token ke diri sendiri saat deploy
        _mint(msg.sender, 400);
    }
}