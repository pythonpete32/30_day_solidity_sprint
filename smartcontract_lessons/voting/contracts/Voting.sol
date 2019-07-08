pragma solidity ^0.5.0 - 0.7.0;
pragma experimental ABIEncoderV2;

/*
A.
    1. the admin will create a ballot with choices
    2. courum
    3. time limit
B. 
    1. admin will aprove a list of voters(Choices[] memory result)
    2. voters will vote for the ballot
    3. admin will excute function to reveal the result
*/
contract Voting {

    
    struct Choices {
        uint id;
        string name;
        uint votes;
    }
    
    struct Ballot {
        uint id;
        string name;
        Choices[] choices;
        uint end;
    }
    
    uint nextBallotId;
    uint nextChoiceId;
    address admin;
    mapping (address => bool) public voters;
    mapping (uint => Ballot) public ballots;
    mapping (address => mapping (uint => bool)) public hasVoted;
    
    constructor () public {
        admin = msg.sender;
        
    }
    
    // calldata is used when ?
    function addVoters(address[] calldata _voters) external isAdmin(){
        for (uint i = 0; i < _voters.length; i++){
            voters[_voters[i]] = true;
        }
    }
    
    /*
    we cant cast a memory array to a storage array?(i get this but memory is still a bit of a fuzy concept for me)
    so we are going to do something weird, we are making refrence to something that dosnt exist and assigning it a value ?!?!?
    */
    function createBallot(string memory _name, string[] memory _choices, uint ofset) public isAdmin(){
        ballots[nextBallotId].id = nextBallotId;
        ballots[nextBallotId].name = _name;
        ballots[nextBallotId].end = now + ofset;
        for(uint i = 0; i < _choices.length; i++){
            ballots[nextBallotId].choices[i] = Choices(nextChoiceId, _choices[i], 0);
            nextChoiceId ++;
        }
        nextBallotId++;
    }
    
    /*
    
    */
    function vote(uint _ballotId, uint _choiceId) external {
        require(voters[msg.sender] == true,'You are not an approved voter');
        require(hasVoted[msg.sender][_ballotId] == false,"You can only vote once");
        require(now < ballots[_ballotId].end,"The time limit has elapsed on this ballot");
        
        hasVoted[msg.sender][_ballotId] = true;
        ballots[_ballotId].choices[_choiceId].votes ++;
    }
    
    function showResults(uint _ballotId) view external returns (Choices[] memory result) {
        require(now >= ballots[_ballotId].end, "cannot see result until the ballot has closed");
        return ballots[_ballotId].choices;
    }
    
    modifier isAdmin(){
        require(msg.sender == admin,"Only Admin can execute this function");
        _;
    }
}