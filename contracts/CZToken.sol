pragma solidity ^0.4.24;
import "zos-lib/contracts/migrations/Migratable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-solidity/contracts/token/ERC20/PausableToken.sol";
import "openzeppelin-solidity/contracts/token/ERC20/BurnableToken.sol";
// import "openzeppelin-solidity/contracts/token/ERC20/DetailedERC20.sol";



contract CZToken is Migratable, ERC20, PausableToken, BurnableToken {

  // ERC20 BASIC DATA

  string public  name;
  string public  symbol;
  uint8 public  decimals;
  uint256 public INITIAL_SUPPLY;
  uint256 private totalSupply_;
  uint256 public counter;
  mapping(uint256 => address) public history;



  function initialize(string _name, string _symbol, uint8 _decimals, uint8 _counter) isInitializer("CZToken", "1.0.0") public {

        name = _name; // 'COINZOOM';
        symbol = _symbol; // 'ZOOM';
        decimals = _decimals; // 18;
        INITIAL_SUPPLY = 1000000000 * (10 ** 18);
        owner = msg.sender;
        totalSupply_ = INITIAL_SUPPLY;
        balances[msg.sender] = INITIAL_SUPPLY;
        counter = _counter;

      }



      function increment() public {
        counter += 1;
        history[counter] = msg.sender;
   }

      function incrementByTwo() public {
        counter += 2;
        history[counter] = msg.sender;
   }
   

}
