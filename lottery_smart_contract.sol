//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract lottery{
    address public manager;
    address payable[] public players;

    constructor(){
        manager = msg.sender;
    }

    receive() payable external{
        require(msg.value == 1 ether);
        players.push(payable(msg.sender));
    }

    function getBalance() public view returns(uint){
        require(msg.sender == manager);
        return address(this).balance;
    }

     function random() internal view returns(uint){
       return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players.length)));
    }

    function pickWinner() public{
        require(msg.sender == manager);
        require(players.length >=3);
        uint r = random();
        address payable winner;
        uint index = r % players.length;
        winner = players[index];
        winner.transfer(getBalance());
    }
}
