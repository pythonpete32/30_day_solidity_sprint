pragma solidity ^0.5.0;

contract Deed {
    /*
     this contract is owned by a benefactor. on creation the benefactor deposits a balance of ether into the contract
     he/she has authorised a lawyer to send the balance to a beneficiary after a predefined time incase they are not able to
     # Required
     - benefactor = owner
     - lawyer = address, only allowed to send balance to beneficiary if
            time  > earliest date
     - beneficiary = address, reciever of the funds
    */
    address public owner;
    address public lawyer;
    address payable public beneficiary;
    uint public earliest; 
    
    // fromNow = seconds from now in unix time
    constructor (address _lawyer, address payable _beneficiary, uint fromNow) public {
        owner = msg.sender;
        lawyer = _lawyer;
        beneficiary = _beneficiary;
        earliest = now + fromNow;
    }
    
    function executeDeed() public{
        require(msg.sender == lawyer, "only lawyer can execute this transaction");
        require(earliest <= now,"too early");
        beneficiary.transfer(address(this).balance);
    }
}