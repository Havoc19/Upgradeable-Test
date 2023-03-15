// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

// Open Zeppelin libraries for controlling upgradability and access.
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
// import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "./Pizza.sol";

contract Pizza3 is Pizza {


   ///@dev decrements the slices when called
   function refillSlice() external {
       slices += 2;
   }
   function pizzaVersion() external pure returns (uint256) {
       return 3;
   }

}

// Pizza Contract Deployed At :  0xA55444c5f682095E1b017E14eE8E74bEf4A8221c
// Pizza Factory Contract Deployed At :  0xBB11dc87400f64A602c2d078FB57d0322eFF82A5