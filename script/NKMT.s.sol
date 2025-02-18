// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/NKMT.sol";

contract DeployNKMT is Script {
    function run() external {
        vm.startBroadcast();

        // Define o supply inicial para 1000 tokens
        NKMT nkmt = new NKMT(1000 * 10**18);

        vm.stopBroadcast();
    }
}
