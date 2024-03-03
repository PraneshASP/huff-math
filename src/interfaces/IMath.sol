// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

/// @notice Interface for the Math contract
interface IMath {
    function addNumbers(uint256, uint256) external view returns (uint256);

    function subNumbers(uint256, uint256) external view returns (uint256);

    function multiplyNumbers(uint256, uint256) external view returns (uint256);

    function divideNumbers(uint256, uint256) external view returns (uint256);

    function abs(uint256, uint256) external view returns (uint256);

    function modExp(uint256, uint256, uint256) external view returns (uint256);
}
