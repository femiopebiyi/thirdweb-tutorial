// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.8;

import {ContractMetadata} from "@thirdweb-dev/contracts/extension/ContractMetadata.sol";

contract ProfileStatus is ContractMetadata {
    struct Status {
        string statusMessage;
        bool exists;
    }

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    mapping(address => Status) userStatus;
    event StatusCreated(address indexed wallet, string status);
    event StatusUpdated(address indexed wallet, string newStatus);

    function createStatus(string memory initialStatus) public {
        require(!userStatus[msg.sender].exists, "status already exists");

        userStatus[msg.sender] = Status({
            statusMessage: initialStatus,
            exists: true
        });

        emit StatusCreated(msg.sender, initialStatus);
    }

    function updateStatus(string memory newStatus) public {
        require(userStatus[msg.sender].exists, "status does not exist");
        userStatus[msg.sender].statusMessage = newStatus;

        emit StatusUpdated(msg.sender, newStatus);
    }

    function getStatus(address wallet) public view returns (string memory) {
        require(userStatus[wallet].exists, "status does not exist");

        string memory currentStatus = userStatus[wallet].statusMessage;
        return currentStatus;
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
