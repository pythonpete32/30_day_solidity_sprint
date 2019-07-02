pragma solidity ^0.5.0 - 0.7.0;

contract Crud {
    
    struct User {
        uint id;
        string name;
    }
    
    User[] public Users;
    uint public nextId;
    
    function createUser(string memory _name) public {
        Users.push(User(nextId, _name));
        nextId ++;
    }
    
    // string is a complex type so we have to specify a memory location?
    function readUser(uint _id) view public returns(uint, string memory){
        for(uint i = 0; i < Users.length; i++){
            if(Users[i].id == _id){
                return(Users[i].id, Users[i].name);
            }
        }
    }
    
    function updateUser(uint _id, string memory _name) public {
        Users[_id].name = _name;
    }
    
    function deleteUser(uint _id) public {
        delete Users[_id];
    }
}