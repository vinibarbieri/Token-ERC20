# Development Guide

## Prerequisites

Before setting up the project, ensure you have the following dependencies installed on your system:

- [Node.js](https://nodejs.org/) (Version 18.19.1 or later)
- [npm](https://www.npmjs.com/) or [yarn](https://yarnpkg.com/)
- [Git](https://git-scm.com/)
- [Foundry](https://book.getfoundry.sh/getting-started/installation) (for Solidity development)
- [MetaMask](https://metamask.io/) (or another Ethereum-compatible wallet)
- A testnet Ethereum network (e.g., Polygon Amoy Testnet)

## Installation & Setup

### 1. Clone the Repository
```bash
git clone https://github.com/vinibarbieri/Token-ERC20.git
cd Token-ERC20
```

### 2. Install Dependencies
Ensure you have Foundry installed, then update it:
```bash
foundryup
```

Install additional dependencies:
```bash
forge install
```

### 3. Environment Variables
Create a `.env` file and add your private key:
```bash
echo "PRIVATE_KEY=0xYOUR_PRIVATE_KEY" > .env
```
Ensure you have testnet MATIC in your wallet for deploying.

### 4. Compile the Contracts
To ensure everything is set up correctly, compile the contracts:
```bash
forge build
```

### 5. Run Tests
Execute the test suite to verify everything is working:
```bash
forge test
```

### 6. Deploy to a Testnet
To deploy to Polygon Amoy:
```bash
forge script script/DeployNKMT.s.sol --rpc-url https://polygon-amoy.drpc.org --private-key $PRIVATE_KEY --broadcast
```

## Using the Project

1. **Connect Wallet** 🔗: Use MetaMask to connect to the network.
2. **Interact with the Smart Contract**: Use tools like `cast` or a frontend to interact.
3. **Check Balance** 💰: Query balances using:
```bash
cast call 0xCONTRACT_ADDRESS "balanceOf(address)(uint256)" 0xYOUR_ADDRESS --rpc-url https://polygon-amoy.drpc.org
```

## Troubleshooting
- Ensure your Foundry installation is up to date (`foundryup`).
- Verify your environment variables are correctly set.
- If a transaction fails, check if you have enough test MATIC.

For more details, check the [README.md](README.md) or open an issue in the repository.

---

### Maintainer: Vinicius Barbieri
Contact: your.email@example.com
