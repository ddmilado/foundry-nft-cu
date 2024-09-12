// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {DeployPizzanistaNft} from "../script/DeployPizzanistaNft.s.sol";
import {PizzanistaNft} from "../src/PizzanistaNft.sol";
import {Test, console2} from "forge-std/Test.sol";
import {MintPizzanistaNft} from "../script/Interactions.s.sol";
import {ZkSyncChainChecker} from "lib/foundry-devops/src/ZkSyncChainChecker.sol";

contract PizzanistaNftTest is Test, ZkSyncChainChecker {
    string constant NFT_NAME = "PIZZANISTA! $2 Tuesdays";
    string constant NFT_SYMBOL = "PIZZA";
    PizzanistaNft public pizzanistaNft;
    DeployPizzanistaNft public deployer;
    address public deployerAddress;

    string public constant PUG_URI =
        "https://ipfs.io/ipfs/QmfGZ1qrH9KaXbs1VemJxGVoBsBDR61ofNcUsUcRdtFUWk/?filename=PizzanistaTuesdays.json";
    address public constant USER = address(1);

    function setUp() public {
        if (!isZkSyncChain()) {
            deployer = new DeployPizzanistaNft();
            pizzanistaNft = deployer.run();
        } else {
            pizzanistaNft = new PizzanistaNft();
        }
    }

    function testInitializedCorrectly() public view {
        assert(keccak256(abi.encodePacked(pizzanistaNft.name())) == keccak256(abi.encodePacked((NFT_NAME))));
        assert(keccak256(abi.encodePacked(pizzanistaNft.symbol())) == keccak256(abi.encodePacked((NFT_SYMBOL))));
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        pizzanistaNft.mintNft(PUG_URI);

        assert(pizzanistaNft.balanceOf(USER) == 1);
    }

    function testTokenURIIsCorrect() public {
        vm.prank(USER);
        pizzanistaNft.mintNft(PUG_URI);

        assert(keccak256(abi.encodePacked(pizzanistaNft.tokenURI(0))) == keccak256(abi.encodePacked(PUG_URI)));
    }

    // Remember, scripting doesn't work with zksync as of today!
    // function testMintWithScript() public {
    //     uint256 startingTokenCount = pizzanistaNft.getTokenCounter();
    //     MintPizzanistaNft mintPizzanistaNft = new MintPizzanistaNft();
    //     mintPizzanistaNft.mintNftOnContract(address(pizzanistaNft));
    //     assert(pizzanistaNft.getTokenCounter() == startingTokenCount + 1);
    // }

    // can you get the coverage up?
}
