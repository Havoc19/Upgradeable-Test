// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
// import "@openzeppelin/contracts-upgradeable/proxy/ERC1967/ERC1967UpgradeUpgradeable.sol";
import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";
import "./IPizza.sol";
import "../contracts/ProxyFactory.sol";

contract PizzaFactory is ProxyFactory{
    address public pizzaAddress;

    // mapping (address => uint) name;

    constructor(address _impl){
        pizzaAddress = _impl;
    }

    function createPizza(uint _sliceCount)  public returns(address){
        address pizza = deployBeaconProxy(pizzaAddress,bytes(""));

        // pizza.initialize(_sliceCount);
        IPizza(pizza).initialize(_sliceCount);
        return pizza;
    }
}