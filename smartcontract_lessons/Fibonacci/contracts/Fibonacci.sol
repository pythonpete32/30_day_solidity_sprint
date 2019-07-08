pragma solidity ^0.5.0;

contract Fibonacci {
    function fib(uint x) public pure returns (uint) {
        uint a = 0;
        uint b = 1;
        for (uint i = 0; i < x; i++){
            uint c = a + b;
            a = b;
            b = c; 
            
        }
        return b;
        
    }
}