# 🪙 NKMT - NakamotoCoin

**NKMT (NakamotoCoin)** is an ERC20 token developed on the blockchain, using the ERC20 standard and implemented with customized functionalities. This project includes the smart contract written in Solidity and a basic frontend for interaction.

## 🌟 Features

- 🔹 **ERC20 Token**: Implements the main ERC20 functions (`transfer`, `approve`, `transferFrom`).
- 🔹 **Account Verification**: Users can verify their accounts to receive an initial amount of 10 tokens.
- 🔹 **Transfer Restriction**: Token transfers are limited to one unit per transaction.
- 🔹 **Testnet Deployment**: The contract can be deployed on the **Polygon Amoy Testnet**.
- 🔹 **MetaMask Integration**: Users can connect their wallets to interact with the contract.

## 🛠️ Technologies Used

- 📝 **Solidity**: For the development of the ERC20 smart contract.
- 🚀 **Foundry**: For testing, development, and contract deployment.
- 🔐 **MetaMask**: For connecting and interacting with the Ethereum-compatible wallet.

## 📋 Prerequisites

- [Node.js](https://nodejs.org/)
- [Foundry](https://book.getfoundry.sh/getting-started/installation)
- [MetaMask](https://metamask.io/)
- An Ethereum testnet (e.g., **Polygon Amoy Testnet**)

## 🚀 Installation & Setup

### 1️⃣ Clone the Repository
```bash
git clone https://github.com/vinibarbieri/Token-ERC20.git
cd Token-ERC20
```

### 2️⃣ Install Dependencies
```bash
foundryup
forge install
```

### 3️⃣ Configure Environment Variables
Create a `.env` file and add your private key:
```bash
echo "PRIVATE_KEY=0xYOUR_PRIVATE_KEY" > .env
```

### 4️⃣ Compile the Contracts
```bash
forge build
```

### 5️⃣ Run Tests
```bash
forge test
```

### 6️⃣ Deploy to Polygon Amoy Testnet
```bash
forge script script/DeployNKMT.s.sol --rpc-url https://polygon-amoy.drpc.org --private-key $PRIVATE_KEY --broadcast
```

## 💻 How to Use

1. **Connect Wallet** 🔗: Connect your MetaMask wallet to the Polygon Amoy network.
2. **Check Balance** 💰: Use a block explorer or run:
```bash
cast call 0xCONTRACT_ADDRESS "balanceOf(address)(uint256)" 0xYOUR_ADDRESS --rpc-url https://polygon-amoy.drpc.org
```
3. **Transfer Tokens** 💸: Use a frontend or `cast send` for transactions.

## 📁 Project Structure

- **`src/`**: Contains the `NKMT.sol` smart contract.
- **`test/`**: Includes tests to validate contract functionalities.
- **`script/`**: Deployment script for testnet deployment.
- **`foundry.toml`**: Foundry configuration file.

## 🔍 Code Example

### Token Transfer in Frontend
```javascript
async function transferToken() {
  const recipient = "0x...";
  const amount = web3.utils.toWei("1", "ether");
  const accounts = await web3.eth.getAccounts();
  await nkmtContract.methods.transfer(recipient, amount).send({ from: accounts[0] });
}
```

## 🤝 Contributing

Contributions are welcome! To contribute:
1. Fork this repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes and commit (`git commit -m "Description of changes"`).
4. Push to your branch (`git push origin feature-branch`).
5. Open a Pull Request.

## 📜 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

📩 For questions or suggestions, contact **Vinicius Barbieri**.

