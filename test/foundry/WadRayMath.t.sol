// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";
import {IWadRayMath} from "../../src/interfaces/IWadRayMath.sol";

contract WadRayMathTest is Test {
    IWadRayMath public sut;

    /// @dev Setup the testing environment.
    function setUp() public {
        sut = IWadRayMath(
            HuffDeployer.deploy("../test/foundry/wrappers/WadRayMathWrapper")
        );
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

    function testDivWad() public {
        assertEq(sut.wadDiv(1.25e18, 0.5e18), 2.5e18);
        assertEq(sut.wadDiv(3e18, 1e18), 3e18);
        assertEq(sut.wadDiv(2, 100000000000000e18), 0);
    }

    function testDivWadEdgeCases() public {
        assertEq(sut.wadDiv(0, 1e18), 0);
    }

    function testFailDivWadZeroDenominator() public {
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

    function testExpWad() public {
        assertEq(sut.wadExp(-42139678854452767551), 0);

        assertEq(sut.wadExp(-3e18), 49787068367863942);
        assertEq(sut.wadExp(-2e18), 135335283236612691);
        assertEq(sut.wadExp(-1e18), 367879441171442321);

        assertEq(sut.wadExp(-0.5e18), 606530659712633423);
        assertEq(sut.wadExp(-0.3e18), 740818220681717866);

        assertEq(sut.wadExp(0), 1000000000000000000);

        assertEq(sut.wadExp(0.3e18), 1349858807576003103);
        assertEq(sut.wadExp(0.5e18), 1648721270700128146);

        assertEq(sut.wadExp(1e18), 2718281828459045235);
        assertEq(sut.wadExp(2e18), 7389056098930650227);
        assertEq(
            sut.wadExp(3e18),
            20085536923187667741
            // True value: 20085536923187667740.92
        );

        assertEq(
            sut.wadExp(10e18),
            220264657948067165169_80
            // True value: 22026465794806716516957.90
            // Relative error 9.987984547746668e-22
        );

        assertEq(
            sut.wadExp(50e18),
            5184705528587072464_148529318587763226117
            // True value: 5184705528587072464_087453322933485384827.47
            // Relative error: 1.1780031733243328e-20
        );

        assertEq(
            sut.wadExp(100e18),
            268811714181613544841_34666106240937146178367581647816351662017
            // True value: 268811714181613544841_26255515800135873611118773741922415191608
            // Relative error: 3.128803544297531e-22
        );

        assertEq(
            sut.wadExp(135305999368893231588),
            578960446186580976_50144101621524338577433870140581303254786265309376407432913
            // True value: 578960446186580976_49816762928942336782129491980154662247847962410455084893091
            // Relative error: 5.653904247484822e-21
        );
    }

    function testLnWad() public {
        assertEq(sut.wadLn(1e18), 0);

        // Actual: 999999999999999999.8674576…
        assertEq(sut.wadLn(2718281828459045235), 999999999999999999);

        // Actual: 2461607324344817917.963296…
        assertEq(sut.wadLn(11723640096265400935), 2461607324344817918);
    }

    function testLnWadSmall() public {
        // Actual: -41446531673892822312.3238461…
        assertEq(sut.wadLn(1), -41446531673892822313);

        // Actual: -37708862055609454006.40601608…
        assertEq(sut.wadLn(42), -37708862055609454007);

        // Actual: -32236191301916639576.251880365581…
        assertEq(sut.wadLn(1e4), -32236191301916639577);

        // Actual: -20723265836946411156.161923092…
        assertEq(sut.wadLn(1e9), -20723265836946411157);
    }

    function testLnWadBig() public {
        // Actual: 135305999368893231589.070344787…
        assertEq(sut.wadLn(2**255 - 1), 135305999368893231589);

        // Actual: 76388489021297880288.605614463571…
        assertEq(sut.wadLn(2**170), 76388489021297880288);

        // Actual: 47276307437780177293.081865…
        assertEq(sut.wadLn(2**128), 47276307437780177293);
    }
}
