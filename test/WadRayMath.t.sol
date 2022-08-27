// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "foundry-huff/HuffDeployer.sol";
import "foundry-huff/HuffConfig.sol";
import "forge-std/Test.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";

/// @notice Interface for the WadRayMath contract
interface IWadRayMath {
    function wadMul(uint256, uint256) external view returns (uint256);

    function wadDiv(uint256, uint256) external view returns (uint256);
}

contract WadRayMathTest is Test {
    IWadRayMath public sut;

    HuffConfig public huffDepl;

    /// @dev Setup the testing environment.
    function setUp() public {
        uint256 WAD = 1e18;

        huffDepl = HuffDeployer.config();

        bytes memory args = (abi.encode(WAD));

        sut = IWadRayMath(huffDepl.with_args(args).deploy("WadRayMath"));
    }

    // function setUp() public {
    //     address addr = HuffDeployer.deploy("WadRayMath");

    //     /// System under test
    //     sut = IWadRayMath(addr);
    // }

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
}
