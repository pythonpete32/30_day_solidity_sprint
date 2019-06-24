pragma solidity ^0.5.0 - 0.7.0;

contract CrudRefactor {
     
    
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
    

    function readUser(uint _id) view public returns(uint, string memory){
        uint i = findUser(_id);
        return(Users[i].id, Users[i].name);
    }
    
    function updateUser(uint _id, string memory _name) public {
        Users[_id].name = _name;
    }
    
    function deleteUser(uint _id) public {
        uint i = findUser(_id);
        delete Users[i];
    }
    
    // this seems redundant to me, but its part of the lesson. the old delete function was my own the original had this loop in 
    // update: as expected, the methods that use this helper function increase gas costs over the original
    function findUser(uint _id) view internal returns(uint){
        for(uint i = 0; i < Users.length; i++){
            if(Users[i].id == _id){
                return i;
            }
        }        
    }
}