// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IERC20.sol";

contract NKMT is IERC20 {
    string public _name = "NakamotoCoin";
    string public _symbol = "NKMT";
    uint8 public _decimals = 18;
    uint256 public totalSupply;
    address public owner;

    uint256 private constant VERIFICATION_BONUS = 10 * 10**18;
    uint256 private constant ONE_TOKEN = 1 * 10**18;

    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) private allowances;
    mapping(address => bool) private _verifiedAccounts;
    mapping(address => bool) private _initialTokensGranted;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    error AccountAlreadyVerified();
    error NotOwner();
    error InvalidAddress();
    error OnlyOneTokenAllowed();
    error InsufficientBalance();
    error TransferAmountExceedsAllowance();
    
    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert NotOwner();
        }
        _;
    }

    constructor(uint256 initialSupply) {
        owner = msg.sender;
        totalSupply = initialSupply;
        balances[msg.sender] = initialSupply;

        emit Transfer(address(0), msg.sender, initialSupply);
    }

    function balanceOf(address account) public view returns (uint256) {
        return balances[account];
    }

    function verifyAccount(address account) public {
        if (_verifiedAccounts[account]) {
            revert AccountAlreadyVerified();
        }

        _verifiedAccounts[account] = true;

        if (!_initialTokensGranted[account]) {
            balances[account] += VERIFICATION_BONUS;
            _initialTokensGranted[account] = true;

            totalSupply += VERIFICATION_BONUS;
        }
    }

    function isVerified(address account) public view returns (bool) {
        return _verifiedAccounts[account];
    }

    function transfer(address recipient, uint256 amount) public returns (bool) {
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool) {
        uint256 currentAllowance = allowances[sender][msg.sender];
        if (currentAllowance < amount) {
            revert TransferAmountExceedsAllowance();
        }

        _transfer(sender, recipient, amount);
        _approve(sender, msg.sender, currentAllowance - amount);
        return true;
    }

    function approve(address spender, uint256 amount) public returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }

    function _transfer(address sender, address recipient, uint256 amount) internal {
        if (sender == address(0) || recipient == address(0)) {
            revert InvalidAddress();
        }
        if (!_verifiedAccounts[recipient]) {
            verifyAccount(recipient);
        }

        uint256 senderBalance = balances[sender];
        if (senderBalance < amount) {
            revert InsufficientBalance();
        }
        if (amount != ONE_TOKEN) {
            revert OnlyOneTokenAllowed();
        }

        balances[sender] = senderBalance - amount; // Reintrance protection here
        balances[recipient] += amount;

        emit Transfer(sender, recipient, amount);
    }

    function _approve(address _owner, address spender, uint256 amount) internal {
        if (_owner == address(0) || spender == address(0)) {
            revert InvalidAddress();
        }

        allowances[_owner][spender] = amount;

        emit Approval(_owner, spender, amount);
    }

    function allowance(address _owner, address spender) public view returns (uint256) {
        return allowances[_owner][spender];
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }
}
