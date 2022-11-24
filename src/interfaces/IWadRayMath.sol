// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

/// @notice Interface for the WadRayMath contract
interface IWadRayMath {
    function wadMul(uint256, uint256) external view returns (uint256);

    function wadDiv(uint256, uint256) external view returns (uint256);

    function rayMul(uint256, uint256) external view returns (uint256);

    function rayDiv(uint256, uint256) external view returns (uint256);

    function rayToWad(uint256) external view returns (uint256);

    function wadToRay(uint256) external view returns (uint256);

    function wadExp(int256) external pure returns (int256);

    function wadLn(int256) external pure returns (int256);
}
