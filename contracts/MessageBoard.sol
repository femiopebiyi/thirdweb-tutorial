// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.8;

contract MessageBoard {
    address public owner;
    string[] public messages;

    event NewMessage(address indexed sender, string message);

    constructor() {
        owner = msg.sender;
    }

    function postMessage(string memory message) public {
        messages.push(message);

        emit NewMessage(msg.sender, message);
    }

    function getMessageCount() public view returns (uint256) {
        return messages.length;
    }

    function getMessage(uint256 index) public view returns (string memory) {
        require(index < messages.length, "there is no message here");

        return messages[index];
    }
}
