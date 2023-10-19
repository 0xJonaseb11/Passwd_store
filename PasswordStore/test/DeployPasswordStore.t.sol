// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { Test, console } from "forge-std/Test.sol";
import { DeployPasswordStore } from "../script/DeployPasswordStore.s.sol";
import { PasswordStore } from "../src/PasswordStore.sol";

contract DeployPasswordStoreTest is Test {
    DeployPasswordStore public deployPasswordStorer;
    PasswordStore public passwordStore;
    address public passwordOwner;

    // Deploy a new PasswordStore contract
    PasswordStore public setPassword = new PasswordStore();

    function setUp() public {
        deployPasswordStorer = new DeployPasswordStore();
        passwordOwner = msg.sender;
    }

    function test_passwordDeployer_can_deploy_password() public {
        // Deploy a PasswordStore contract using the DeployPasswordStore
        passwordStore = deployPasswordStorer.run();

        // Set the password in the deployed PasswordStore
        string memory expectedPassword = "myPassword";
        passwordStore.setPassword(expectedPassword);

        // Get the password from the PasswordStore
        string memory enteredPassword = passwordStore.getPassword();

        // Ensure that the entered password matches the expected password
        assertEq(enteredPassword, expectedPassword);
    }

    function test_non_owner_cannot_deploy_password() public {
        // deploy a PasswordStore contract using the DeployPasswordStore
        passwordStore = passwordDeployer.run();

        // Attempt to set the password from as address that is not the owner
        bool success = address(passwordStore).call(abi.encodeWithSelector(passwordStore.setPassword.selector, "myNewPassword));

        //Ensure that setting the password from a non-owner addressfails
        assertEq(success, false);

    }

    function test_owner_can_change_password() public {
        //deploy a PasswordStore contract using the DeployPasswordStore
        passwordStore = passwordDeployer.run();

        //set the initial password
        string memory initialPassword = "initialPassword";
        passwordStore.setPassword(initialPassword);

        //change the password to a new one
    }
}
