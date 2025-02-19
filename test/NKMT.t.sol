// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../lib/forge-std/src/Test.sol";
import "../src/NKMT.sol";

contract NKMTTest is Test {
    NKMT private nkmt;
    address private owner;
    address private user1;
    address private user2;
    address private user3;

    function setUp() public {
        owner = address(this);
        user1 = address(0x1);
        user2 = address(0x2);
        user3 = address(0x3);
        
        nkmt = new NKMT(1000 * 10**18); // Inicializa com 1000 tokens
    }

    function testInitialSupply() public view {
        assertEq(nkmt.totalSupply(), 1000 * 10**18, "Total supply should match");
    }

    function testBalanceOfOwner() public view {
        assertEq(nkmt.balanceOf(owner), 1000 * 10**18, "Owner should have initial supply");
    }

    function testVerifyAccount() public {
        nkmt.verifyAccount(user1);
        assertTrue(nkmt.isVerified(user1), "User1 should be verified");
    }

    function testOnlyOneTokenTransfer() public {
        nkmt.verifyAccount(user1);
        vm.prank(owner);
        nkmt.transfer(user1, 1 * 10**18);

        assertEq(nkmt.balanceOf(user1), 11 * 10**18, "User1 should receive 1 token + 10 from verification");
    }

    function test_RevertWhen_TransferMoreThanOneToken() public {
        nkmt.verifyAccount(user1);
        
        vm.prank(owner);
        vm.expectRevert(NKMT.OnlyOneTokenAllowed.selector);
        nkmt.transfer(user1, 2 * 10**18);
    }

    function testApproveAndTransferFrom() public {
        nkmt.verifyAccount(user1);
        nkmt.verifyAccount(user2);

        vm.prank(owner);
        nkmt.approve(user1, 1 * 10**18);
        
        vm.prank(user1);
        nkmt.transferFrom(owner, user2, 1 * 10**18);

        assertEq(nkmt.balanceOf(user2), 11 * 10**18, "User2 should receive 1 token + 10 from verification");
    }

    function testMultipleTransfers() public {
        nkmt.verifyAccount(user1);
        vm.prank(owner);
        nkmt.transfer(user1, 1 * 10**18);
        vm.prank(user1);
        nkmt.transfer(user2, 1 * 10**18);

        assertEq(nkmt.balanceOf(user1), 10 * 10**18, "User1 should have 10 tokens left");
        assertEq(nkmt.balanceOf(user2), 11 * 10**18, "User2 should receive 1 token + 10 from verification");
    }

    function testFailTransferMoreThanApproved() public {
        nkmt.verifyAccount(user1);
        vm.prank(owner);
        nkmt.approve(user1, 1 * 10**18);
        
        vm.prank(user1);
        vm.expectRevert();
        nkmt.transferFrom(owner, user2, 2 * 10**18); // Deve falhar
    }

    function testFailTransferWithoutApproval() public {
        nkmt.verifyAccount(user1);
        vm.prank(user1);
        vm.expectRevert();
        nkmt.transferFrom(owner, user2, 1 * 10**18); // Deve falhar pois `approve` não foi chamado
    }

    function testFailVerifyAlreadyVerifiedAccount() public {
        nkmt.verifyAccount(user1);
        vm.expectRevert(NKMT.AccountAlreadyVerified.selector);
        nkmt.verifyAccount(user1);
    }

    function testBalanceOfUnverifiedAccount() public view {
        assertEq(nkmt.balanceOf(user3), 0, "User3 should have 0 tokens");
    }

    function testFailTransferToZeroAddress() public {
        nkmt.verifyAccount(user1);
        vm.prank(owner);
        vm.expectRevert(NKMT.InvalidAddress.selector);
        nkmt.transfer(address(0), 1 * 10**18);
    }

    function testFailTransferFromInsufficientBalance() public {
        nkmt.verifyAccount(user1);
        vm.prank(user1);
        vm.expectRevert();
        nkmt.transferFrom(user2, user3, 1 * 10**18); // user2 não tem saldo para transferir
    }

    function testTotalSupplyAfterMultipleVerifications() public {
        nkmt.verifyAccount(user1);
        nkmt.verifyAccount(user2);
        nkmt.verifyAccount(user3);

        assertEq(nkmt.totalSupply(), 1030 * 10**18, "Total supply should increase by 30 after 3 verifications");
    }

    function testFailTransferFromAccountWithoutBalance() public {
        vm.prank(user1);
        vm.expectRevert();
        nkmt.transferFrom(user3, user2, 1 * 10**18); // user3 não tem saldo
    }

    function testUserReceivesVerificationBonusOnlyOnce() public {
        nkmt.verifyAccount(user1);
        uint256 firstBalance = nkmt.balanceOf(user1);

        nkmt.verifyAccount(user1); // Tentar verificar novamente
        uint256 secondBalance = nkmt.balanceOf(user1);

        assertEq(firstBalance, secondBalance, "User should not receive bonus twice");
    }
}
