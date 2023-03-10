// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

// Open Zeppelin libraries for controlling upgradability and access.
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
// import "@openzeppelin/contracts/proxy/ERC1967Proxy";

contract Pizza is Initializable, UUPSUpgradeable, OwnableUpgradeable {
   uint256 public slices;

      ///@dev no constructor in upgradable contracts. Instead we have initializers
    ///@param _sliceCount initial number of slices for the pizza
   function initialize(uint256 _sliceCount) public initializer {
       slices = _sliceCount;

      ///@dev as there is no constructor, we need to initialise the OwnableUpgradeable explicitly
       __Ownable_init();
   }

   ///@dev required by the OZ UUPS module
   function _authorizeUpgrade(address) internal override onlyOwner {}

   ///@dev decrements the slices when called
   function eatSlice() public {
       require(slices > 1, "no slices left");
       slices -= 1;
   }
}

// Pizza Contract Deployed At :  0xA55444c5f682095E1b017E14eE8E74bEf4A8221c
// Pizza Factory Contract Deployed At :  0xBB11dc87400f64A602c2d078FB57d0322eFF82A5