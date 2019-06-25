pragma solidity ^0.5.0;

/* 
so if you ever look back at this this contract and think WTF! remember 
you watched the video the night before and wanted to impliment the 
contract on your own without copying the code from the course so there was a whole bunch of
experimentation and errors. all the comments were primarily for yourself at the time
*/

contract BasicWallet {
    /* 
    - set a owner of the wallet
    - create a deposit function
    - create a transfer function
    - return balance
    - guard the sensitive function with a access modifier
    */ 
    
    address owner;
    
    // this is my implimentation the tutorial uses the next one down
    constructor() public {
        owner = msg.sender;
    }
    
    /*
    // this is the tutorial version. ill just stick to mine for now
    constructor(address _owner) public {
        owner = _owner;
    }
    */
    
    // tutorial didnt use a modifier, it used require in the transfer function. the benefit of that approach was an usefull error could be generated
    // how would i genetate that kind of error here?
    // Update: simply add the error message as the second argument
    modifier isOwner() {
        require(msg.sender == owner, "You are not the owner of this wallet");
        _;
    }
    
    // so im flying blind here, i dont think i need to use the functions argument to send eth, but what do i put in the function body?
    // maybe emit an event, how do i do that?
    function deposit() public payable {
        
    }
    
    // this is not giving me any compile errors but it wont deploy? 
    function balance() public view returns(uint){
        return address(this).balance;
    }
    
    
    // tempory fallback function to accept eth for testing
    function () external payable {
        
    }
    
        
    // i think this might be the offending function which is strange because it ran compiled and deployed before
    // update: this is so strange! now ive moved the function to the bottom of the contract, its deploying! 
    //      im going to depricate this for the function in the tutorial
    // update: transactions are hanging anyway, before they send there giving some error about not being able to estimate gas
    /*
    function transfer(address payable _to, uint _ammount) public{
        if (address(this).balance > _ammount){
            this.transfer(_to,_ammount);
        }
        revert('enouth eth to complete the transaction');
    }
    */
    
    // note: tutorial didnt do sanity check just used the _to to transfer the funds
    // update: so the reason why is because its completely unnessasary. if you try to send more eth than you have, obviously its going to fail 
    function transfer(address payable _to, uint _ammount) public isOwner{
        address(_to).transfer(_ammount);
    }
}