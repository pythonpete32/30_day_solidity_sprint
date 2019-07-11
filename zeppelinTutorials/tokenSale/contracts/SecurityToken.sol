pragma solidity ^0.5.0 - 0.7.0;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Detailed.sol";


contract SecurityToken is ERC20, ERC20Detailed {

constructor(string memory _name, string memory _symbol, uint8 _decimals, uint256 _ammount)
    public
    ERC20Detailed(_name, _symbol, _decimals){
      // why nul function
      uint toMint = _ammount.mul(10**uint256(_decimals));
      _mint(msg.sender, toMint);
    }

}
