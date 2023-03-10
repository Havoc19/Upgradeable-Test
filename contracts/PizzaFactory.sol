// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import "./IPizza.sol";

contract PizzaFactory{
    address public pizzaAddress;

    constructor(address _impl){
        pizzaAddress = _impl;
    }

    function createPizza(uint _sliceCount)  public returns(address){
        ERC1967Proxy pizza = new ERC1967Proxy(pizzaAddress,abi.encodeWithSelector(IPizza.initialize.selector,_sliceCount));
        // pizza.initialize(_sliceCount);
        return address(pizza);
    }
    // abi.encodeCall(SmartWallet(payable(address(0))).initialize, (_defaultAdmin, _name, _symbol, _contractURI, _trustedForwarders, _royaltyRecipient, _royaltyBps))
}