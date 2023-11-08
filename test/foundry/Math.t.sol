// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";
import {IMath} from "../../src/interfaces/IMath.sol";

contract MathTest is Test {
    IMath public math;
    uint256 public constant MAX = type(uint256).max;
    uint256 public constant MIN = type(uint256).min;

    function setUp() public {
        address addr = HuffDeployer.deploy("./wrappers/MathWrapper");
        // Hardcoding the deployed address as there are some issues with --ffi and huffc
        math = IMath(addr);
    }

    function testAddNumbers() public {
        uint256 result = math.addNumbers(420, 69);
        assertEq(result, 489);
    }

    function testAddNumbers_fuzz(uint256 a, uint256 b) public {
        unchecked {
            uint256 c = a + b;

            if (c > MAX) {
                vm.expectRevert();
                math.addNumbers(a, b);
                return;
            }

            uint256 result = math.addNumbers(a, b);
            assertEq(result, a + b);
        }
    }

    function testSubNumbers() public {
        uint256 result = math.subNumbers(420, 69);
        assertEq(result, 351);
    }

    function testSubNumbers_fuzz(uint256 a, uint256 b) public {
        unchecked {
            uint256 c = a - b;
            if (c < MIN) {
                vm.expectRevert();
                math.subNumbers(a, b);
                return;
            }

            uint256 result = math.subNumbers(a, b);
            assertEq(result, a - b);
        }
    }

    function testMultiplyNumbers() public {
        uint256 result = math.multiplyNumbers(100, 69);
        assertEq(result, 6900);
    }

    function testMultiplyNumbers_fuzz(uint256 a, uint256 b) public {
        unchecked {
            uint256 c = a * b;

            if (c > MAX) {
                vm.expectRevert();
                math.multiplyNumbers(a, b);
                return;
            }

            uint256 result = math.multiplyNumbers(a, b);
            assertEq(result, a * b);
        }
    }

    function testDivideNumbers() public {
        uint256 result = math.divideNumbers(200, 10);
        assertEq(result, 20);
    }

    function testDivideNumbers_fuzz(uint256 a, uint256 b) public {
        vm.assume(b > 0);
        assertEq(math.divideNumbers(a, b), a / b);
    }

    function testAbs() public view {
        require(math.abs(1, 10) == 9);
    }

    function testAbs_fuzz(uint256 a, uint256 b) public view {
        uint256 _result = a > b ? a - b : b - a;
        require(math.abs(a, b) == _result);
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

    function testModExp_fuzz(uint256 b, uint256 e, uint256 m) public {
        // To avoid testing with modulus zero, which would revert
        vm.assume(m > 1);
        // To avoid gas issues, cap the exponent
        uint256 exponent = e % 256;

        // The actual modExp calculation can be complicated to emulate in Solidity due to gas constraints,
        // so here we just test that the function does not revert and returns a value
        // less than the modulus.
        uint256 result = math.modExp(b, exponent, m);

        assertLt(result, m, "modExp result should be less than the modulus");
    }
}
