pragma solidity ^0.4.23;

contract ExternalFunctionTypeTest {
    
    struct Request {
        uint id;
        function (uint,uint) external callback;
    }
    
    
    uint constant MAX_LENGTH = 5;
    
    Request[MAX_LENGTH] queue;
    uint front;
    uint rear;
    bool isEmpty;
    bool isFull;
    
    constructor() public {
          front = 0;
          rear = 0;
          isEmpty = true;
          isFull = false;
    }
    
    function size() public view returns(uint) {
        uint result;
        if (rear > front){
            result = rear - front;
        } else  if(rear > front) {
            result = rear - front + MAX_LENGTH;
        } else {
            result = isEmpty ? 0 : MAX_LENGTH;
        }
        return result;
    }

    function request(uint id, function(uint,uint) external callback) public returns(bool) {
        bool ret = !isFull;
        if (!isFull) {
            queue[rear].id = id;
            queue[rear].callback = callback;
            rear = (rear + 1) % MAX_LENGTH;
            isFull = rear == front;
            isEmpty = false;
        }
        
        return ret;
    }
    
    function process(function(uint) external returns(uint) handler) public returns(bool) {
        bool ret = !isEmpty;
        
        if (!isEmpty) {
            Request storage r = queue[front];
            front = (front + 1) % MAX_LENGTH;
            isFull = false;
            isEmpty = rear == front;
            uint result = handler(r.id);
            r.callback(r.id,result);
        }
        return ret;
    }
    
}


contract Requester {
    
    event PringResult(address msgSender, uint id, uint ret);
    
    ExternalFunctionTypeTest test;
    
    constructor(address externalFunctionTypeTestAddress) public {
        test = ExternalFunctionTypeTest(externalFunctionTypeTestAddress);
    }
    
    function request(uint id) public {
        test.request(id, this.callback);
    }

    function callback(uint id, uint ret) external {
        emit PringResult(msg.sender,id,ret);
    } 
}

contract Processer {
    
   event Handled(address msgSender, uint val);
    
    ExternalFunctionTypeTest test;
    
    constructor(address externalFunctionTypeTestAddress) public {
        test = ExternalFunctionTypeTest(externalFunctionTypeTestAddress);
    }
    
    function process() public {
        test.process(this.handler);
    }
    
    function handler(uint val) public returns(uint) {
        emit Handled(msg.sender,val);
        return val + 1;
    }
}
