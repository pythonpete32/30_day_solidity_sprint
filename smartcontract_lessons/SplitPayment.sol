pragma solidity ^0.5.0;

contract SplitPayment {
    // this contract takes two arrays, one of addresses and the other of uints
    // it sends the value of the uint to the address matched by the index
    
    address public owner;
    
    constructor() public {
        owner = msg.sender;
    }
    
    // i need to get alot more comfortable with the order of declarations as well as with the various modifiers, visibilities and memory locations
    // i coudnt create the function signature without looking back at the tutorial. not good
    function pay(address payable[] memory _to, uint[] memory _ammount) public payable isOwner{
        require(_to.length == _ammount.length, "addresses and ammounts arrays need to be the same length");
        for(uint i = 0; i < _to.length; i++){
            address(_to[i]).transfer(_ammount[i]);
        }
    }
    
    modifier isOwner() {
        require(msg.sender == owner, "you are not the owner of this contract");
        _;
    }
}