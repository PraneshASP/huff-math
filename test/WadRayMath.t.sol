// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";

/// @notice Interface for the WadRayMath contract
interface IWadRayMath {
    function wadMul(uint256, uint256) external view returns (uint256);

    function wadDiv(uint256, uint256) external view returns (uint256);

    function rayMul(uint256, uint256) external view returns (uint256);

    function rayDiv(uint256, uint256) external view returns (uint256);

    function rayToWad(uint256) external view returns (uint256);

    function wadToRay(uint256) external view returns (uint256);
}

contract WadRayMathTest is Test {
    IWadRayMath public sut;

    /// @dev Setup the testing environment.
    function setUp() public {
        address addr = HuffDeployer.deploy("WadRayMath");

        /// System under test
        sut = IWadRayMath(addr);
    }

    function testDeployment() public {
        assert(address(sut) != address(0));
    }

    function testWadMulEdgeCases() public {
        assertEq(sut.wadMul(0, 1e18), 0);
        assertEq(sut.wadMul(1e18, 0), 0);
        assertEq(sut.wadMul(0, 0), 0);
    }

    function testWadMul() public {
        assertEq(sut.wadMul(2.5e18, 0.5e18), 1.25e18);
        assertEq(sut.wadMul(3e18, 1e18), 3e18);
        assertEq(sut.wadMul(369, 271), 0);
    }

    function testDivWadDown() public {
        assertEq(sut.wadDiv(1.25e18, 0.5e18), 2.5e18);
        assertEq(sut.wadDiv(3e18, 1e18), 3e18);
        assertEq(sut.wadDiv(2, 100000000000000e18), 0);
    }

    function testDivWadDownEdgeCases() public {
        assertEq(sut.wadDiv(0, 1e18), 0);
    }

    function testFailDivWadDownZeroDenominator() public {
        sut.wadDiv(1e18, 0);
    }

    function testRayMulEdgeCases() public {
        assertEq(sut.rayMul(0, 1e27), 0);
        assertEq(sut.rayMul(1e27, 0), 0);
        assertEq(sut.rayMul(0, 0), 0);
    }

    function testRayMul() public {
        assertEq(sut.rayMul(2.5e27, 0.5e27), 1.25e27);
        assertEq(sut.rayMul(3e27, 1e27), 3e27);
        assertEq(sut.rayMul(369, 271), 0);
    }

    function testDivRayDown() public {
        assertEq(sut.rayDiv(1.25e27, 0.5e27), 2.5e27);
        assertEq(sut.rayDiv(3e27, 1e27), 3e27);
        assertEq(sut.rayDiv(2, 100000000000000e27), 0);
    }

    function testDivRayDownEdgeCases() public {
        assertEq(sut.rayDiv(0, 1e27), 0);
    }

    function testFailDivRayDownZeroDenominator() public {
        sut.rayDiv(1e27, 0);
    }

    function testRayToWad() public {
        assertEq(sut.rayToWad(0), 0);
        assertEq(sut.rayToWad(1e27), 1e18);
        assertEq(sut.rayToWad(50000e27), 50000e18);
    }

    function testWadToRay() public {
        assertEq(sut.wadToRay(0), 0);
        assertEq(sut.wadToRay(1e18), 1e27);
        assertEq(sut.wadToRay(50000e18), 50000e27);
    }
}
