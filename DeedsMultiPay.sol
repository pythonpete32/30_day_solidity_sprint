pragma solidity ^0.5.0;

contract Deed {
    /*
    this deed contract splits up the the ammount the beneficiary is allowed to withdraw up into a number of equal pieces
    */
    address public owner;
    address payable public beneficiary;
    uint public earliest; 
    uint public ammount;
    uint constant public PAYOUT = 10;
    uint constant public INTERVAL = 10;
    uint public paid_payouts;
    
    // fromNow = seconds from now in unix time
    constructor (address payable _beneficiary, uint fromNow) public payable {
        owner = msg.sender;
        beneficiary = _beneficiary;
        earliest = now + fromNow;
        ammount = msg.value / PAYOUT;
        paid_payouts = 0;
    }
    
    function executeDeed() public{
        require(paid_payouts < PAYOUT, "You have withdrawn your limit");
        require(msg.sender == beneficiary, "only beneficiary can execute this transaction");
        require(earliest <= now, "too early");
        
        uint elegable_payouts = (now - earliest / INTERVAL);
        uint due_payouts = elegable_payouts - paid_payouts;
        beneficiary.transfer(due_payouts);
        paid_payouts ++;
    }
}