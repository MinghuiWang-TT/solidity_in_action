pragma solidity ^0.4.23;

contract LiteralTest {
    
    event IntValue(int value);
    event StringValue(string value);

    function testRationalLiteral() public {
        // Next line compiles even the 2**8 - 2**6 - 2**6 is 127 whitch is greater than the biggest positive number of int8 
        int8 x = (2**8 - 2**6 - 2**6 -1); 
        //Next line should get a error since the final result is greater than 127
        //int8 x = (2**8 - 2**6 - 2**6); 
        emit IntValue(x);

    }
    
    function testHexLiteral() public  {
        //Value of the event is "ABCDE..."
        emit StringValue(hex"414243444546474849");
    }
    
}
