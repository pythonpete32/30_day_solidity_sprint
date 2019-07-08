pragma solidity ^0.5.0 - 0.7.0;

contract ComplexStorage {
    
    // creates a public getter with the same name but it only returns the first variable
    uint[] public ids;
    
    function add(uint _id) public {
        ids.push(_id);
    }
    
    // so why do i have to specify a location for the return here?
    function getIds() public view returns(uint[] memory) {
       return ids;
    }
    
    // but i do not have to specify one here?
    // what about the complexity makes this nessasary?
    // further more where exactily is memory, is this memory that gets lost after each execution of the function?
    function getId(uint _id) public view returns(uint) {
        return ids[_id];
    }
    
    function length() public view returns(uint) {
        return ids.length;
    }
}