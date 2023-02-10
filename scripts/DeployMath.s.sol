// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Script.sol";

import {IMath} from "../src/interfaces/IMath.sol";

contract DeployMath is Script {
    function run() public returns (IMath math) {
        math = IMath(HuffDeployer.broadcast("wrappers/MathWrapper"));
        console2.log("MathWrapper contract deployed to: ", address(math));
    }
}
