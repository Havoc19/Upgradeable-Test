// SPDX-License-Identifier: MIT

pragma solidity 0.8.16;

interface IPizza{
    function initialize(uint256 _sliceCount) external ;

    function eatSlice() external ;

}