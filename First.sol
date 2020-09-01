//first specifiy which version of solidity you're using
pragma solidity ^0.5.10;

// not broadcasted to the blockchain, not a transaction since state of the contract (variables) arent changed and computation is done in local machine
// transaction is created to update the blockchain

contract First {
	uint public x = 3;
	function foo(uint y, uint z) public pure returns(uint) {
		return y+z;
	}
}

//transaction created since x value changes
//default

contract First {
	uint public x = 3;
	function foo(uint y) public returns(uint) {
		x = y;
		return x;
	}
}

//doesnt change state of the blockchain, only needs to know state of the blockchain 

contract First {
	uint public x = 3;
	function foo() public view returns(uint) {
		return x+2;
	}
}

//arrays init to 0, maps use hashmap backend implementation

contract First {
	uint public x = 3;
	uint[3] public lis;
	function foo(uint i, uint val) public {
		lis[i]=val;
	}
}

contract First {
	uint public x = 3;
	mapping(uint => uint) public data;
	function foo(uint i, uint val) public {
		data[i]=val;
	}
}

//payments - payable in order to make it accept that money
//msg keyword for message that the transaction contains

contract First {
	uint public donation = 0;
	uint[3] public lis;
	function foo() public payable {
		donation+=msg.value; //amt of money transferred to this func
		msg.sender; //address of person who transferred the money
	}
}

//to send money, use accounts (from truffle build)

$ accounts[0]
....
$ accounts[9]

let instance = await First.deployed();
instance.foo({sender: accounts[1], value: 100})

//gwei = smallest unit of ether, 10^-18

$ instance.donation();
// 100


***** diff between C and solidity ******
+ no std inputs or outputs
+ impossible to check if code completes execution or not in sol, how do you check if denial of service attack takes place?
=> gas -> every sec that you use to cpmpute my code, i pay money/gas. if time exceeds the gas i'm paying, cde is thrown out
=> code needs small comp complexity
+ every program should be completely deterministic
=> no concept of time in ethereum, only current block number
=> precision also depends on computer hardware etc, not deterministic
=> no floating point no's in eth, always int. make calcs in long ints, multiply by 10^18 for some amount of precision
+ uint preferred

*****************

// once a contract is deployed, it cannot be changed

//revert is like an assertion check, transaction goes through if it holds

contract First {
	uint public donation = 0;
	uint[3] public lis;
	function foo() public payable {
		revert(msg.value > 10); //transaction is aborted if the revert condition is false
		donation+=msg.value; 
	}
}

//rejected transaction will be broadcasted