// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";

/// @notice Interface for the Math contract
interface IMath {
    function addNumbers(uint256, uint256) external view returns (uint256);

    function subNumbers(uint256, uint256) external view returns (uint256);

    function multiplyNumbers(uint256, uint256) external view returns (uint256);

    function divideNumbers(uint256, uint256) external view returns (uint256);

    function abs(uint256, uint256) external view returns (uint256);
}

contract MathTest is Test {
    IMath public math;
    uint256 public constant MAX = type(uint256).max;

    function setUp() public {
        address addr = HuffDeployer.deploy("Math");
        // Hardcoding the deployed address as there are some issues with --ffi and huffc
        math = IMath(addr);
    }

    function testAdd(uint256 a, uint256 b) public {
        // overflow not handled in the contract
        vm.assume(a < MAX / 2 && b < MAX / 2);
        require(math.addNumbers(a, b) == a + b);
    }

    function testSub(uint256 a, uint256 b) public {
        vm.assume(b > a);
        require(math.subNumbers(a, b) == b - a);
    }

    function testMul(uint256 a, uint256 b) public {
        vm.assume((b > 0 && a < MAX / b) || (a > 0 && b < MAX / a));
        require(math.multiplyNumbers(a, b) == a * b);
    }

    function testDiv(uint256 a, uint256 b) public {
        vm.assume(a > 0);
        require(math.divideNumbers(a, b) == b / a);
    }

    function testAbs(uint256 a, uint256 b) public view {
        uint256 _result = a > b ? a - b : b - a;
        require(math.abs(a, b) == _result);
    }
}
