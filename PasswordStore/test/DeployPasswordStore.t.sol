// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { Test, console } from "forge-std/Test.sol";
import { DeployPasswordStore } from "../script/DeployPasswordStore.s.sol";
import { PasswordStore } from "../src/PasswordStore.sol";

contract DeployPasswordStoreTest is Test {
    DeployPasswordStore public passwordDeployer;
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
        bool success = address(passwordStore).call(abi.encodeWithSelector(passwordStore.setPassword.selector, "myNewPassword"));

        //Ensure that setting the password from a non-owner addressfails
        assertEq(success, false);

    }

    function test_owner_can_change_password() public {
    // Deploy a PasswordStore contract using the DeployPasswordStore
    passwordStore = deployPasswordStorer.run();

    // Set an initial password
    string memory initialPassword = "initialPassword";
    passwordStore.setPassword(initialPassword);

    // Change the password to a new one
    string memory newPassword = "newPassword";

    // Encode the function call with the new password
    (bool success, ) = address(passwordStore).call(abi.encodeWithSelector(passwordStore.changePassword.selector, newPassword));

    // Ensure that the function call was successful
    assert(success, "Change password call failed");

    // Get the password from the PasswordStore
    string memory enteredPassword = passwordStore.getPassword();

    // Ensure that the entered password matches the new password
    assertEq(enteredPassword, newPassword);
}


    function test_owner_can_withdraw_funds() public {
        // deploy a PasswordStore contract using the DeployPasswordStore
        passwordStore = passwordDeployer.run();

        // Add some funds to the PasswordStore
        uint256 initialBalance = 10 ether;
        passwordStore.addFunds{ value: initialBalance}();

        // Check the initial balance
        uint256 balance = passwordStore.getBalance();
        assertEq(balance, initialBalance);

        // Withdraw some funds to check
        uint256 withdrawAmount = 5 ether;
        passwordStore.withdrawFunds(withdrawAmount);

        // Check the updated balance
        uint256 newBalance = passwordStore.getBalance();
        assertEq(newBalance, initialBalance - withdrawAmount);
    }
}
