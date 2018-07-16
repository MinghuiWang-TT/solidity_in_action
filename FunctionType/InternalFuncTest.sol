pragma solidity ^0.4.23;

contract InternalFuncTest {
    
    uint state1;
    uint stete2;
    
    event Error(bytes32 message);
    
    
    function caculate(uint p1, uint p2,bool flag) public returns(uint) {
        //The next line will get a compile error since this.add would be consideed as a external function 
        //caculate(p1,p2,flag? this.add : this.sub);
       return caculate(p1,p2,flag? add : sub);
    }
    
    function caculate(uint p1, uint p2, function (uint,uint) returns(uint) func ) internal returns(uint){
        return func(p1,p2);
    }
    
    function add(uint p1, uint p2) public returns(uint) {  
        uint sum = p1 + p2;
        if (sum < p1 || sum < p2){
            emit Error('overflow');
            return 0;
        }
        
        return sum;
    }

    function sub(uint p1, uint p2) public returns(uint) {  
        return p2 < p1 ? p1 -p2 : p2 - p1;
    }

}
