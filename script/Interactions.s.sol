// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {PizzanistaNft} from "../src/PizzanistaNft.sol";
import {MoodNft} from "../src/MoodNft.sol";

contract MintPizzanistaNft is Script {
    string public constant PUG_URI =
        "https://ipfs.io/ipfs/QmfGZ1qrH9KaXbs1VemJxGVoBsBDR61ofNcUsUcRdtFUWk/?filename=PizzanistaTuesdays.json";

    function run() external {
        address mostRecentlyDeployedPizzanistaNft = DevOpsTools.get_most_recent_deployment("PizzanistaNft", block.chainid);
        mintNftOnContract(mostRecentlyDeployedPizzanistaNft);
    }

    function mintNftOnContract(address pizzanistaNftAddress) public {
        vm.startBroadcast();
        PizzanistaNft(pizzanistaNftAddress).mintNft(PUG_URI);
        vm.stopBroadcast();
    }
}

contract MintMoodNft is Script {
    function run() external {
        address mostRecentlyDeployedMoodNft = DevOpsTools.get_most_recent_deployment("MoodNft", block.chainid);
        mintNftOnContract(mostRecentlyDeployedMoodNft);
    }

    function mintNftOnContract(address moodNftAddress) public {
        vm.startBroadcast();
        MoodNft(moodNftAddress).mintNft();
        vm.stopBroadcast();
    }
}

contract FlipMoodNft is Script {
    uint256 public constant TOKEN_ID_TO_FLIP = 0;

    function run() external {
        address mostRecentlyDeployedMoodNft = DevOpsTools.get_most_recent_deployment("MoodNft", block.chainid);
        flipMoodNft(mostRecentlyDeployedMoodNft);
    }

    function flipMoodNft(address moodNftAddress) public {
        vm.startBroadcast();
        MoodNft(moodNftAddress).flipMood(TOKEN_ID_TO_FLIP);
        vm.stopBroadcast();
    }
}
