// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";

/// @notice Interface for the WadRayMath contract
interface IWadRayMath {
    function wadMul(uint256, uint256) external view returns (uint256);
}

contract WadRayMathTest is Test {
    IWadRayMath public sut;
    uint256 public constant MAX = type(uint256).max;
    uint256 public constant MIN = type(uint256).min;

    function setUp() public {
        address addr = HuffDeployer.deploy("WadRayMath");

        /// System under test
        sut = IWadRayMath(addr);
    }

    function testDeployment() public {
        assert(address(sut) != address(0));
    }

    function testWadMul_ShouldReturnZero_WhenOneOfTheInputsAreZero() public {
        uint256 result = sut.wadMul(0, 1);
        assertEq(result, 0);
        result = sut.wadMul(1, 0);
        assertEq(result, 0);
        result = sut.wadMul(0, 0);
        assertEq(result, 0);
    }
}
