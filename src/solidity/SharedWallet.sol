pragma solidity 0.8.0;

import './Allowance.sol';



contract SharedWallet is Allowance{


    event MoneySend(address indexed _beneficiary, uint _amt);

    event MoneyRecieved(address indexed _from, uint _amt);


    constructor() payable  {
    }

    function renounceOwnership() public override view onlyOwner {
        revert("Can't renounce ownerhsip here");
    }


    function withdraw(address payable _to, uint _amt) public ownerOrAllowed(_amt) {

        require(_amt <=address(this).balance, "There is not enough funds in the smart contract");

        if(address(msg.sender) != owner()) {
             reduceAllowance(msg.sender, _amt);
        }
         emit MoneySend(_to, _amt); 
        _to.transfer(_amt);
       
    }

    

    fallback() external payable {
        emit MoneyRecieved(msg.sender, msg.value);
    }

    receive() external payable {
        emit MoneyRecieved(msg.sender, msg.value);
    }
    
    

    
}