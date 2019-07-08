pragma solidity ^0.5.0 - 0.7.0;

contract StateMachine {
    enum State {
        PENDING,
        ACTIVE,
        CLOSED
    }

    uint public amount;
    uint public interest;
    uint public end;
    address payable public borrower;
    address payable public lender;
    State public state;

    constructor (uint _amount, uint _interest, uint _end, address payable _borrower, address payable _lender) public payable {
        amount = _amount;
        interest = _interest;
        end = _end;
        borrower = _borrower;
        lender = _lender;
        state = State.PENDING;
    }

    function fund() payable external {
        require(msg.sender == lender, 'only lender can lend');
        require(address(this).balance == amount, 'can only lend the exact amount');
        borrower.transfer(amount);
        _stateTransition(this.state);

    }

    function reimburse() payable external {
        require(msg.sender == borrower, 'only borrower can reimburse');
        require(msg.value == amount + interest, 'borrower need to reimburse exactly amount + interest');
        lender.transfer(amount + interest);
        _stateTransition(this.state);
    }

    // my initial implimentation of the state transition function
    function _stateTransition(State _state) internal {
        require(_state != State.CLOSED, "loan cannot be opened once closed");
        if(_state == State.PENDING){
          state = State.ACTIVE;
        }
        state = State.CLOSED;
    }
}
