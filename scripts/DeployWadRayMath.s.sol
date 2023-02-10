// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Script.sol";

import {IWadRayMath} from "../src/interfaces/IWadRayMath.sol";

contract DeployWadRayMath is Script {
    function run() public returns (IWadRayMath wadRayMath) {
        wadRayMath = IWadRayMath(
            HuffDeployer.broadcast("wrappers/WadMathWrapper")
        );
        console2.log(
            "WadRayMathWrapper contract deployed to: ",
            address(wadRayMath)
        );
    }
}
