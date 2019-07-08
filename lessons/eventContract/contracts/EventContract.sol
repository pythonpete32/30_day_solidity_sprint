pragma solidity ^0.5.0 - 0.7.0;

/*
  Event contract models an event company. there are two classes of users
  1. event organiser: this is the contract owner, the owner can
    A. create events. events have the following properties
     - name
     - date
     - price
     - number of tickets
  2. customers: anyone can be a customer, customers can
    A. buy a tickets
    B. sell a ticket to anyone else
*/

contract EventContract {
  struct Event {
    string name;
    uint date;
    uint price;
    uint maxTickets;
    uint nextTicket;
    mapping (uint => address) tickets;
  }

  address owner;
  uint nextEvent;
  mapping (uint => Event) events;

  constructor () public {
    owner = msg.sender;
    nextEvent = 0;
  }

  function createEvent(string calldata _name, uint _date, uint _price, uint _maxTickets) external onlyOwner() {
    Event memory newEvent = Event ({name : _name, date : now + _date, price: _price, maxTickets : _maxTickets, nextTicket : 0});
    events[nextEvent] = newEvent;
    nextEvent ++;
  }
  
  function buyTicket(uint _event) external payable {
      require(events[_event].nextTicket < events[_event].maxTickets, "no more tickets left");
      require(msg.value == events[_event].price, "pay the correct price");
      require(now < events[_event].date, "event has already finished");
      
      uint nextTicket = events[_event].nextTicket;
      events[_event].tickets[nextTicket] = msg.sender;
      events[_event].nextTicket ++;
  }
  
  function transferTicket(uint _event, uint _ticket, address _to) external {
      require(msg.sender == events[_event].tickets[_ticket], "you do not own this ticket");
      require(now < events[_event].date, "Cannot transfer ticket, event has already finished");
      
      events[_event].tickets[_ticket] = _to;
  }

  modifier onlyOwner() {
    require(msg.sender == owner, "only owner of this contract can call this function");
    _;
  }

}
