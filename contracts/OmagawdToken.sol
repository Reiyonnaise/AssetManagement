// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract OmagawdToken is ERC20 {
    constructor() ERC20("Omagawd", "OMGD") {
        _mint(msg.sender, 1000000 * 10 ** decimals()); 
    }
}
