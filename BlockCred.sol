// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FaceBlock {
    struct Credential {
        string imageHash; // Hash of the encoded image
        string credential; // Embedded credential
        address owner; // Owner address
    }

    mapping(uint256 => Credential) public credentials;
    uint256 public credentialCount;

    event CredentialStored(uint256 indexed id, string imageHash, string credential, address indexed owner);

    function storeCredential(string memory _imageHash, string memory _credential) public {
    // Validate inputs
    require(bytes(_imageHash).length > 0, "Image hash cannot be empty");
    require(bytes(_credential).length > 0, "Credential cannot be empty");

    // Store the credential
    credentials[credentialCount] = Credential(_imageHash, _credential, msg.sender);

    // Emit event
    emit CredentialStored(credentialCount, _imageHash, _credential, msg.sender);

    // Increment credential count
    credentialCount++;
}


    function getCredential(uint256 _id) public view returns (string memory, string memory, address) {
        Credential memory cred = credentials[_id];
        return (cred.imageHash, cred.credential, cred.owner);
    }
}
