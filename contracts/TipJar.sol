// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;

import {ContractMetadata} from "@thirdweb-dev/contracts/extension/ContractMetadata.sol";

contract TipJar is ContractMetadata {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    event TipReceived(address indexed tipper, uint256 amount);
    event TipWithdrawn(address indexed owner, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner can call this function");
        _;
    }

    function tip() public payable {
        require(msg.value > 0, "You must send a tip to use this function");

        emit TipReceived(msg.sender, msg.value);
    }

    function withdrawTip() public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "there is no tip");

        payable(owner).transfer(balance);

        emit TipWithdrawn(owner, balance);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function _canSetContractURI()
        internal
        view
        virtual
        override
        returns (bool)
    {
        return msg.sender == owner;
    }
}
