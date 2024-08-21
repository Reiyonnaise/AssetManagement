// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract AssetManager {
    IERC20 public omagawdToken;

    struct Asset {
        string name;
        string ipfsHash; 
        uint256 value;   
        address owner;
    }

    mapping(uint256 => Asset) public assets;
    uint256 public assetCount;

    constructor(address _omagawdToken) {
        omagawdToken = IERC20(_omagawdToken);
    }

    function createAsset(string memory _name, string memory _ipfsHash, uint256 _value) public {
        assets[assetCount] = Asset(_name, _ipfsHash, _value, msg.sender);
        assetCount++;
    }

    function buyAsset(uint256 _assetId, uint256 _amount) public {
        Asset storage asset = assets[_assetId];
        require(omagawdToken.balanceOf(msg.sender) >= _amount, "Insufficient balance");
        require(_amount >= asset.value, "Insufficient funds");

        omagawdToken.transferFrom(msg.sender, asset.owner, _amount);

        asset.owner = msg.sender;
    }

    function getAsset(uint256 _assetId) public view returns (string memory, string memory, uint256, address) {
        Asset memory asset = assets[_assetId];
        return (asset.name, asset.ipfsHash, asset.value, asset.owner);
    }
}
