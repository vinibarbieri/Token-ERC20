// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "lib/forge-std/src/Script.sol";
import "../src/NKMT.sol";

contract DeployNKMT is Script {
    function run() external {
        vm.startBroadcast();

        // Deploy do contrato com um supply inicial de 1000 tokens
        NKMT nkmt = new NKMT(1000 * 10 ** 18);

        console.log("Contrato implantado em:", address(nkmt));

        vm.stopBroadcast();
    }
}
