// SPDX-License-Identifier: MIT

/**
 * @title IndexSwap for the Index
 * @author Velvet.Capital
 * @notice This contract is used by the user to invest and withdraw from the index
 * @dev This contract includes functionalities:
 *      1. Invest in the particular fund
 *      2. Withdraw from the fund
 */

pragma solidity 0.8.16;

interface IPizza{
    function initialize(uint256 _sliceCount) external ;

    function eatSlice() external ;

    function upgradeTo(address newImplementation) external;
}