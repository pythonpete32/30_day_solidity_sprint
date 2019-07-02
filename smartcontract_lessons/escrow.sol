pragma solidity ^0.5.0;
/*
    state: 
    - lawyer, address
    - payee, address
    - payer, address
    - ammount, uint256
    
    behaviour:
    - lawyer creates a contract specifying other vars
    - payee is able to deposit upto ammount
    - lawyer is able to send funds to either payee if total ammount is in contract
    - lawyer is able to send funds back to payee
    - anyone can view the balance of the contract
*/
contract Escrow {
    
    address public lawyer;
    address payable public payer;
    address payable public payee;
    uint public ammount;
    
    constructor(address payable _payer, address payable _payee, uint _ammount) public {
        lawyer = msg.sender;
        payer = _payer;
        payee = _payee;
        ammount = _ammount ;
    }
    
    function deposit() external payable {
        require(msg.sender == lawyer, "Only payer can send funds to this contract");
        require(address(this).balance <= msg.value,"You sent too much ETH to the contract");
    }
    
    function refund() external {
        payer.transfer(address(this).balance);
    }
    
    function sendFunds() external {
        require(msg.sender == lawyer, "Only payer can send funds to this contract");
        require(address(this).balance == ammount,"the payer has not sent enough eth to conplete the sale");     
        payee.transfer(address(this).balance);
    }
    
    function balanceOf() external view returns(uint) {
        return address(this).balance;
    }
    
    function() external payable {
        this.deposit();
    }
    
}