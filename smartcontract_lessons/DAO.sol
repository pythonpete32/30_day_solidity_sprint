pragma solidity ^0.5.0 - 0.7.0;

/**
 * DAO contract:
 * 1. Collects investors money (ether) [x]
 * 2. Keep track of investor contributions with shares [x]
 * 3. Allow investors to transfer shares [x]
 * 4. allow investment proposals to be created and voted [x]
 * 5. execute successful investment proposals (i.e send money)
 */

contract DAO {
    
    struct Proposal {
        uint id;
        string name;
        address payable investmentTo;
        uint ammount;
        uint votes;
        uint end;
        bool executed;
    }
    
    // mapping of investor addresses to a mapping of proposal Ids
    mapping (address => mapping (uint => bool)) public hasVoted;
    mapping (uint => Proposal) public proposals;
    mapping (address => bool) public investors;
    mapping (address => uint) public shares;
    
    // used to determine voter weight
    uint public totalShares;
    uint public avalableFunds;
    uint public contributionEnd;
    uint public nextProposalId;
    uint public proposalTime;
    uint public quorum;
    address public owner;
    
    constructor (uint _time,uint _proposalTime, uint _quorum) public {
        require(_quorum > 0 && _quorum <= 1);
        contributionEnd = now + _time;
        owner = msg.sender;
        nextProposalId = 0;
        proposalTime = _proposalTime;
        quorum = _quorum;
        
    }
    
    function contribute () payable external {
        require(now < contributionEnd, "To late to invest");
        investors[msg.sender] = true;
        shares[msg.sender] = msg.value;
        totalShares += msg.value;
        avalableFunds += msg.value;
    }
    
    function transferShare (address _to, uint _ammount) external onlyInvestor() {
        require(shares[msg.sender] >= _ammount, "Not enough shares to transfer");
        shares[msg.sender] -= _ammount;
        shares[_to] += _ammount;
        investors[_to] = true;
    }
    
    function redeamShares(uint _ammount) external payable onlyInvestor() {
        require(shares[msg.sender] >= _ammount, "you do not have enough shares");
        require(avalableFunds >= _ammount, "not enough funds in the dao");
        
        shares[msg.sender] -= _ammount;
        msg.sender.transfer(_ammount);
    }
    
    // there is a problem with this functuion, if the proposal is not executed the avalableFunds needs to be added back.
    function createProposal(string calldata _name, address payable _to, uint _ammount) external onlyInvestor() {
        require(avalableFunds > _ammount, "not enough funds in DAO to execute this proposal");
        
        proposals[nextProposalId] = Proposal(nextProposalId, _name, _to, _ammount, 0, now+proposalTime, false);
        avalableFunds -= _ammount;
        nextProposalId ++;
    }
    
    function vote(uint _id) external onlyInvestor() {
        require(now <= proposals[_id].end, "time has passed");
        require(hasVoted[msg.sender][_id] == false);
        
        hasVoted[msg.sender][_id] = true;
        proposals[_id].votes += shares[msg.sender];
    }
    
    // this is not working as expected. the compiler is saying i can change the functuion to pure when i am changing
    // state variables
    function executeProposal(uint _id) external {
        require(now > proposals[_id].end, "cannot execute proposal before end time");
        require(proposals[_id].executed == false, "proposal has already been executed");
        require(proposals[_id].votes >= (quorum * totalShares), "Quorum not met");
        require(avalableFunds >= proposals[_id].ammount, "not enough funds");
        
        proposals[_id].executed == true;
        address(proposals[_id].investmentTo).transfer(proposals[_id].ammount);
        
    }
    
    
    modifier onlyInvestor(){
        require(investors[msg.sender] == true, "you are not an investor");
        _;
    }
    
    modifier onlyOwner(){
        require(msg.sender == owner, "you are not the owner");
        _;
    }    
}