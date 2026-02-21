// SPDX-License-Identifier: MIT
pragma solidity <0.7.0;

contract Bomb {
    function explode() external {
        selfdestruct(msg.sender);
    }
}