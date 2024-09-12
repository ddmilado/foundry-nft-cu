// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Script} from "forge-std/Script.sol";
import {PizzanistaNft} from "../src/PizzanistaNft.sol";
import {console} from "forge-std/console.sol";

contract DeployPizzanistaNft is Script {
    uint256 public DEFAULT_ANVIL_PRIVATE_KEY = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;
    uint256 public deployerKey;

    function run() external returns (PizzanistaNft) {
        vm.startBroadcast();
        PizzanistaNft pizzanistaNft = new PizzanistaNft();
        vm.stopBroadcast();
        return pizzanistaNft;
    }
}
