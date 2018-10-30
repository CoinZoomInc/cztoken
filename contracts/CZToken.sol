pragma solidity ^0.4.24;

import "zos-lib/contracts/migrations/Migratable.sol";
import "openzeppelin-zos/contracts/lifecycle/Pausable.sol";
import "openzeppelin-zos/contracts/ownership/Ownable.sol";
import "openzeppelin-zos/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-zos/contracts/token/ERC20/StandardBurnableToken.sol";


contract CZToken is Migratable, Pausable, StandardBurnableToken {

    string public name;
    string public symbol;
    uint8 public decimals;

    function initialize(address _sender, string _name, string _symbol, uint8 _decimals) 
    public 
    isInitializer("CZToken", "0.1") 
    {
        require(_sender != address(0), "Null address not allowed.");
        require(bytes(_name).length > 0, "Name should be provided.");
        require(bytes(_name).length > 0, "Symbol should be provided.");
        require(_decimals >= 0, "Decimals should be a non-negative integer quantity.");

      // setting the owner's address
        Pausable.initialize(_sender);

        // token parameters initialization
        name = _name;
        symbol = _symbol;
        decimals = _decimals;

        // calculating total supply value
        uint256 _totalSupplyValue = 1000000000 * (10 ** uint256 (decimals));
        
        // setting token's total supply
        totalSupply_ = _totalSupplyValue;

        // updating the token balance of the owner
        balances[_sender] = balances[_sender].add(_totalSupplyValue);
    }

    function() public payable {
        revert("This contract does not support recieving ether.");
    }

    function transfer(address _to, uint256 _value) 
    public 
    whenNotPaused 
    returns (bool) 
    {
        return super.transfer(_to, _value);
    }

    function transferFrom(address _from, address _to, uint256 _value) 
    public 
    whenNotPaused 
    returns (bool) 
    {
        return super.transferFrom(_from, _to, _value);
    }

    function approve(address _spender, uint256 _value) 
    public 
    whenNotPaused 
    returns (bool) 
    {
        return super.approve(_spender, _value);
    }

    function increaseApproval(address _spender, uint _addedValue) 
    public 
    whenNotPaused 
    returns (bool success) 
    {
        return super.increaseApproval(_spender, _addedValue);
    }

    function decreaseApproval(address _spender, uint _subtractedValue) 
    public 
    whenNotPaused 
    returns (bool success) 
    {
        return super.decreaseApproval(_spender, _subtractedValue);
    }
}