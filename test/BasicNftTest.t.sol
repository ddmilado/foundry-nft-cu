// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {Test, console2} from "forge-std/Test.sol";
import {MintBasicNft} from "../script/Interactions.s.sol";
import {ZkSyncChainChecker} from "lib/foundry-devops/src/ZkSyncChainChecker.sol";

contract BasicNftTest is Test, ZkSyncChainChecker {
    string constant NFT_NAME = "PIZZANISTA! $2 Tuesdays";
    string constant NFT_SYMBOL = "PIZZA";
    BasicNft public basicNft;
    DeployBasicNft public deployer;
    address public deployerAddress;

    string public constant PUG_URI =
        "https://ipfs.io/ipfs/QmfGZ1qrH9KaXbs1VemJxGVoBsBDR61ofNcUsUcRdtFUWk/?filename=PizzanistaTuesdays.json";
    address public constant USER = address(1);

    function setUp() public {
        if (!isZkSyncChain()) {
            deployer = new DeployBasicNft();
            basicNft = deployer.run();
        } else {
            basicNft = new BasicNft();
        }
    }

    function testInitializedCorrectly() public view {
        assert(keccak256(abi.encodePacked(basicNft.name())) == keccak256(abi.encodePacked((NFT_NAME))));
        assert(keccak256(abi.encodePacked(basicNft.symbol())) == keccak256(abi.encodePacked((NFT_SYMBOL))));
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(PUG_URI);

        assert(basicNft.balanceOf(USER) == 1);
    }

    function testTokenURIIsCorrect() public {
        vm.prank(USER);
        basicNft.mintNft(PUG_URI);

        assert(keccak256(abi.encodePacked(basicNft.tokenURI(0))) == keccak256(abi.encodePacked(PUG_URI)));
    }

    // Remember, scripting doesn't work with zksync as of today!
    // function testMintWithScript() public {
    //     uint256 startingTokenCount = basicNft.getTokenCounter();
    //     MintBasicNft mintBasicNft = new MintBasicNft();
    //     mintBasicNft.mintNftOnContract(address(basicNft));
    //     assert(basicNft.getTokenCounter() == startingTokenCount + 1);
    // }

    // can you get the coverage up?
}
