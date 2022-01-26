pragma solidity >=0.7.0 <0.9.0;

//Contract which allows only creator to create new coins
//Anyone can send coins to each other

contract Coin {
    address public minter;
    mapping(address => uint) public balances;

    event Sent(address from, address to, uint amount);

    constructor() {
        minter = msg.sender;
    }

    //Make new coins
    //Send them to address
    //Only owner can send these coins
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        balances[receiver] += amount;
    }

    error insufficientBalance(uint requested, uint available);

    //Send any amount of coins
    //To existing address

    function send(address receiver, uint amount) public {
        // require amount to be greater than x = true
        if(amount > balances[msg.sender])
        revert insufficientBalance({
            requested: amount,
            available: balances[msg.sender]
        });
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
    }

}

    

