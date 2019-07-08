pragma solidity ^0.5.0 - 0.7.0;
/*
    before doing the second part of the tutorial, im going to finish this contract watching the video.
    i have followed the basic pattern, which is:
    1. create a tx struct. 
    1a. for each tx create a tx from struct and store it in a mapping
    1b. the mapping is indexed by nextId which is incrememted at the end of the function that creates the Tx
    
    I will complete the contract by:
    2. creating a function for signers to sign a Tx
    3. creating a function to send a Tx with sufficent quorum
    
    - this contract will automaticaly send the tx when quorum is met
    - this contract will emit events when 
        A. a tx is created
        B. a tx is signed
        C. a tx is sent
    
    it is not possible to tell who has signed the tx with the current struct. will change this.
*/
contract MultiSig {
    address[] public signers;
    uint public quorum;
    uint nextId;
    
    struct Tx {
        uint id;
        uint ammount;
        uint approvals;
        address[] signatures;
        address payable to;
        bool sent;
    }
    
    // to create a tx, multiple parties have to contribute async before it is sent.
    // therefore the state of the tx needs to persist. we will store these in a mapping.
    // we will use a mapping so we can have multiple transactions with the same ammounts going to the same address
    mapping (uint => Tx) txs;

    constructor (address[] memory _signers, uint _quorum) public payable{
        signers = _signers;
        quorum = _quorum;
    }
    
    function createTx(uint _ammount, address payable _to) external isSigner {
        address[] memory _signtures;
        _signtures[0] = msg.sender;
        txs[nextId] = Tx(nextId, _ammount, 1, _signtures, _to, false);
        
        // if only one signer is required to send a transaction,send it straight away
        if (quorum < 2){
            sendTx(nextId);
        }
        
        nextId ++;
        
    }
    
    function signTx(uint _id) external isSigner{
        txs[_id].signatures.push(msg.sender);
        txs[_id].approvals ++;
        
        if (txs[_id].approvals == quorum){
            sendTx(_id);
        }
    }
    
    function sendTx(uint _id) public isSigner{
        require(address(this).balance >= txs[_id].ammount, "Not enough Ether to send ");
        require(txs[_id].approvals >= quorum);
        require(txs[_id].sent == false);
        
        txs[_id].to.transfer(txs[_id].ammount);
        txs[_id].sent = true;
    }
    
    modifier isSigner() {
        bool test = false;
        for(uint i = 0; i < signers.length; i++){
            if (signers[i] == msg.sender){
                test = true;
                break;
            }
        }
        require (test == true, "message sender is not a signer of this MultiSig");
        _;
    }
}