# cztoken
CoinZoom Upgradeable Utility Token
Developing Upgradeable ERC20 Smart Contract

First make sure that you have Node.JS and npm installed in your system, then after that let’s install zos globally, > $ npm install --global zos

And now let’s create a blank node Js project with

$ mkdir SampleUpgradeableTokenContract > $ cd SampleUpgradeableTokenContract > $ npm init --y

Now let’s zos initialize this project as zos project, > $ zos init SampleUpgradeableTokenContract

Installing zos-lib and zeppelin-zos npm modules > $ npm install zos-lib openzeppelin-zos

Linking the standard openzeppelin library with you project, very important step if you want to use openzeppelin smart contracts in contracts in your project > $ zos link openzeppelin-zos

Now let’s write an upgradeable ERC20 smart contract

pragma solidity ^0.4.24;

import "zos-lib/contracts/migrations/Migratable.sol"; import "openzeppelin-zos/contracts/token/ERC20/StandardBurnableToken.sol";

contract UpgradeableERC20 is Migratable, StandardBurnableToken {

string public name; string public symbol; uint8 public decimals;

function initialize(address _sender, string _name, string _symbol, uint8 _decimals) public isInitializer("UpgradeableERC20", "0.1") { require(_sender != address(0), "Null address not allowed."); require(bytes(_name).length > 0, "Name should be provided."); require(bytes(_name).length > 0, "Symbol should be provided."); require(_decimals >= 0, "Decimals should be a non-negative integer quantity.");

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

function() public payable { revert("This contract does not support receiving ether."); } }

The migratable smart contract that we have extended from the zos-lib is the one responsible for handling the upgradeable life cycle of our smart contract by maintaining the version of smart contract in each update, internally zeppelin-os maintains a proxy contracts which has this smart contract set in the setter of the proxy contract and each time we update or existing smart contract the address of the new smart contract gets set in the setter of the proxy contract and all the state of this old smart contract gets migrated over to new updated one whereas the address of the proxy contract remains we are able to interact with it without needing to change the interating contracts address.

Now let’s discuss how we can deploy this upgradeable Smart contract.

Add the contract to the project by > $ zos add UpgradeableERC20

Push the standard library onto your ethereum network if you haven’t already (Note:- Ropsten testnet and the mainnet already have ths library pushed on them so no need to push it there.)

> $ zos push --deploy-stdlib -- network <nameOfYourNetwork>
Now initialize your smart contract by giving the initializer arguments

> $ zos create UpgradeableERC20 --init initialize --args <yourEthereumAccountAddress>,<tokenName>,TOK,18 --network <nameOfYourNetwork>
This will create an upgradeable ERC20 smart contract with

Token name: Token symbol: TOK Token Decimals: 18

At this you point you have a fully operational ERC20 smart contract.

If you want to add any functionality or remove bug just do that change and use following commands to push and register that change a an update:

> $ zos push --network <nameOfYourNetwork>
Now update the contract

> $ zos update <tokenNamePrevioslyProvided> --network <nameOfYourNetwork>
Conclusion: This way we have made our ERC20 smart contract an upgradeable one, now when ever we need to make an update we can do that in fly.
