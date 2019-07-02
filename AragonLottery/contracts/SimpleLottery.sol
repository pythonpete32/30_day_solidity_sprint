pragma solidity ^0.5.1;
/*
    simple non reoccuring lottery, it holds 4 state vars
    tickets = array of addresses, each address that sends eth to the contract is stored in this variable. 
    winner = address of the winner
    ticketingCloses = after this time noone can buy a ticket to the lottery
    there is also a constatnt state var TICKET_PRICE, which is obviously the price of one TICKET_PRICE
    
    the logic of the lottery is simple, you can buy a ticket up to the ticketing closing time, adter a set period after the ticketing closes
    someone can call the drawWinner function. the winner can then withdraw their winnings.
    
    Additions: as it stands this lottery is super basic, it dosnt even have events. ofcourse its a minimaly viable, because its just a tutorial to launch
               ground you in the basics before going on to something even more complex. but before i do that im going to add some events and other tweeks 
               to solifiy my solidity! ;p (you see what i done there. LOL)
    
    NOTE: find out why the contracts are giving out of gas errors when im sending transactions using metamask, when im sending transactions using
          web3 there is no problem
    
    
*/
contract SimpleLottery {
    uint public constant TICKET_PRICE = 1e17;
    
    address[] public tickets;
    address public winner;
    uint public ticketingCloses;
    
    event buyTicket(address _from, uint _time); 
    
    constructor (uint duration) public {
        ticketingCloses = now + duration;
    }
    
    function buy () public payable {
        require(msg.value == TICKET_PRICE);
        require(now < ticketingCloses);
        
        tickets.push(msg.sender);
        emit buyTicket(msg.sender, now);
    }
    
    function drawWinner () public {
        require(now > ticketingCloses + 1 minutes);
        require(winner == address(0)); // what is this
        
        // compiler gave me errors and would not compile. so i know that this is giving me 
        // randomness by hashing the previous blocknumber, but what is abi.encode() ?
        bytes32 rand = keccak256(
            abi.encode(blockhash(block.number-1))
        );
        winner = tickets[uint(rand) % tickets.length];
    }
    
    function withdraw () public {
        require(msg.sender == winner);
        msg.sender.transfer(address(this).balance);
    }
    
    function () payable external {
        buy();
    }
}
