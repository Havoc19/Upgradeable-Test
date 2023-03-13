// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "./IPizza.sol";

contract PizzaFactory{
    address public pizzaAddress;

    // mapping (address => uint) name;

    constructor(address _impl){
        pizzaAddress = _impl;
    }

    function createPizza(uint _sliceCount)  public returns(address){
        ERC1967Proxy pizza = new ERC1967Proxy(pizzaAddress,abi.encodeWithSelector(IPizza.initialize.selector,_sliceCount));
        // pizza.initialize(_sliceCount);
        return address(pizza);
    }

    function upgrade(address proxy,address _newImpl) public {
        IPizza(proxy).upgradeTo(_newImpl);
    }
}