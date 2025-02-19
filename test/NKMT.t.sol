// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../lib/forge-std/src/Test.sol";
import "../src/NKMT.sol";

contract NKMTTest is Test {
    NKMT private nkmt;
    address private owner;
    address private user1;
    address private user2;

    function setUp() public {
        owner = address(this);
        user1 = address(0x1);
        user2 = address(0x2);
        
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
}
