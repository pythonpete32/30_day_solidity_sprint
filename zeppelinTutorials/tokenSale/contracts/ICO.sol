pragma solidity ^0.5.0 - 0.7.0;

import "openzeppelin-solidity/contracts/crowdsale/Crowdsale.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";

contract ICO is Crowdsale {
  constructor(
    uint256 _rate,
    address payable _wallet,
    ERC20 _token
    )
    public
    Crowdsale(_rate, _wallet, _token){}
}
