// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";
import {IMath} from "../../src/interfaces/IMath.sol";

contract MathForkTest is Test {
    IMath public math;

    function setUp() public {
        vm.createSelectFork(vm.envString("RPC_URL"));
        math = IMath(0x999581D8C0BADA05502945fF3e490f41aE9e4102);
    }

    function testAddNumbers() public {
        uint256 result = math.addNumbers(420, 69);
        assertEq(result, 489);
    }

    function testSubNumbers() public {
        uint256 result = math.subNumbers(420, 69);
        assertEq(result, 351);
    }

    function testMultiplyNumbers() public {
        uint256 result = math.multiplyNumbers(100, 69);
        assertEq(result, 6900);
    }

    function testDivideNumbers() public {
        uint256 result = math.divideNumbers(200, 10);
        assertEq(result, 20);
    }

    function testAbs() public view {
        require(math.abs(1, 10) == 9);
    }

    function testModExp() public {
        // Example test: 2^3 % 5 should equal 3
        uint256 base = 2;
        uint256 exponent = 3;
        uint256 modulus = 5;
        uint256 expected = 3;

        uint256 result = math.modExp(base, exponent, modulus);
        assertEq(result, expected, "modExp did not return the expected value");
    }
}
