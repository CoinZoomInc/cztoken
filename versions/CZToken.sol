pragma solidity ^0.4.24;
import "zos-lib/contracts/migrations/Migratable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-solidity/contracts/token/ERC20/PausableToken.sol";
import "openzeppelin-solidity/contracts/token/ERC20/BurnableToken.sol";



contract CZToken is Migratable, ERC20, PausableToken, BurnableToken {

  // ERC20 BASIC DATA

  string public  name;
  string public  symbol;
  uint8 public  decimals;
  uint256 public INITIAL_SUPPLY;
  uint256 private totalSupply_;
  uint256 public counter;




  function initialize(string _name, string _symbol, uint8 _decimals) isInitializer("CZToken", "1.0.0") public {

        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        INITIAL_SUPPLY = 1000000000 * (10 ** 18);
        owner = msg.sender;
        totalSupply_ = INITIAL_SUPPLY;
        balances[msg.sender] = INITIAL_SUPPLY;
        counter = _counter;

      }

}
