pragma solidity 0.8.0;


import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";


contract Allowance is Ownable {
    event AllowanceChanged(address indexed _forWho, address indexed _fromWhoe, uint _oldAmount, uint _newAmount);

    mapping(address => uint) public allowance;
    
    modifier ownerOrAllowed(uint _amt) {
        require(address(msg.sender) == owner() || allowance[msg.sender] >= _amt , "You are not allowed");
        _;
    }
    
    function addAllowance(address _who, uint _amount) public onlyOwner {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);

        allowance[_who] = _amount;
    }

    function reduceAllowance(address _user, uint _amt) internal {
        emit AllowanceChanged(_user, msg.sender, allowance[_user], allowance[_user]-_amt);
        allowance[_user]-=_amt;
    }
}