pragma solidity ^0.5.0 - 0.7.0;
/*
    strings are very limited in solidity, they cant even be concatonated. im going to make a contract that contains some helper functions for strings
*/
contract Strings {
    
    function lengthOf(string memory _str) public pure returns (uint) {
        // cant directly get the length of a string, i need to cast it into a bytes array first
        bytes memory str = bytes(_str);
        return str.length;
    }

    function concatString(string memory _str1, string memory _str2) public pure returns (string memory) {
        // again we need to cast strings as bytes arrays to do the manipulations then cast them back into strings
        bytes memory str1 = bytes(_str1);
        bytes memory str2 = bytes(_str2);
        string memory len = new string(str1.length + str2.length);
        
        // convoluted but i need to get the length of both the strings, add them together and create a new bytes array.
        bytes memory str = bytes(len);
        
        uint j = 0;
        for (uint i = 0; i < str1.length; i++) {
            str[j] = str1[i];
            j++;
        }
        for (uint i = 0; i < str2.length; i++) {
            str[j] = str2[i];
            j++;
        } 
        
	    return string(str);
    }
    
}
