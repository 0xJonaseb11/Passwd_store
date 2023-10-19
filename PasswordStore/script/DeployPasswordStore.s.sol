// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console2} from "forge-std/Script.sol";
import {PasswordStore} from "../src/PasswordStore.sol";

contract DeployPasswordStore is Script {
    function run() public returns (PasswordStore) {
        vm.startBroadcast();
        PasswordStore passwordStore = new PasswordStore();
        passwordStore.setPassword("myPassword");
        vm.stopBroadcast();
        return passwordStore;
    }
}

import { Script, console2 } from "forge-std/Script.sol";
import { PasswordStore } from "../src/PasswordStore.sol";

contract DeployPasswordStore is Script {
    function run() public returns(PasswordStore) {
        vm.startBroadcast();
        PasswordStore passwordStore = new PasswordStore();
        PasswordStore.setPassword("myPassword");
        vm.stopBroadcast();

        return passwordStore;
    }
}
