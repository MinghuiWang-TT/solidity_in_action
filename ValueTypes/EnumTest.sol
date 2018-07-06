pragma solidity ^0.4.23;

contract EnumTest {
    
    event UintValue(uint value);
    event EnumValue(Status status);
    
    enum Status {ACTIVE,SUSPENDED}
    
    function enumTest() public {
        Status s1 = Status.ACTIVE;
        //0 will be emited
        emit UintValue(uint(s1));
        
        Status s2 = Status(1);
        //1 will be emited
        emit EnumValue(s2);
        
        //Next line will get an compile time error for 2 is out of range
        //Status s2 = Status(2);
        
        uint x = 4 - 4;
        Status s3 = Status(x);
        //0 will be emited
        emit EnumValue(s3);

        // x = 4 - 2;
        //The next line will get an run time error for x is out of range
        // Status s4 = Status(x);
    }
    
}
