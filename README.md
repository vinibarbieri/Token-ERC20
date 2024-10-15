# 🪙 NKMT - NakamotoCoin

**NKMT (NakamotoCoin)** é um token ERC20 desenvolvido na blockchain, utilizando o padrão ERC20 e implementado com funcionalidades customizadas. Este projeto inclui o contrato inteligente do token, implementado em Solidity, e um frontend em HTML e JavaScript para interação e visualização dos saldos e transações.

## 🌟 Funcionalidades

- 🔹 **Token ERC20**: Implementa as principais funções de um token ERC20 (como `transfer`, `approve`, e `transferFrom`).
- 🔹 **Verificação de Conta**: Usuários podem verificar suas contas para receber uma quantidade inicial de 10 tokens.
- 🔹 **Restrição de Transferência**: As transferências de tokens são limitadas a uma unidade por transação.
- 🔹 **Interface de Frontend**: Uma interface de usuário construída em HTML, CSS (Bootstrap) e JavaScript, permitindo que os usuários conectem suas carteiras, verifiquem saldos, transfiram tokens e vejam o status de verificação de conta.

## 🛠️ Tecnologias Utilizadas

- 📝 **Solidity**: Para o desenvolvimento do contrato inteligente ERC20.
- 🚀 **Hardhat**: Para o desenvolvimento, teste, e deploy do contrato inteligente.
- 🎨 **HTML, CSS e Bootstrap**: Para construir a interface amigável do frontend.
- 📜 **JavaScript e Web3.js**: Para interagir com o contrato inteligente na blockchain.
- 🔐 **MetaMask**: Para conexão e interação com a carteira Ethereum.

## 📋 Pré-requisitos

- Node.js e npm
- Hardhat
- MetaMask (ou outra carteira Ethereum compatível)
- Uma rede de teste Ethereum (Polygon Testnet, Goerli, etc.)

## 🚀 Instalação

### 1. Clonar o Repositório

```bash
git clone https://github.com/vinibarbieri/Token-ERC20.git
cd nkmt-token
```

### 2. Instalar Dependências

Instale as dependências do projeto:

```bash
npm install
```

### 3. Configurar o Hardhat

Se necessário, edite o arquivo `hardhat.config.js` para configurar a rede em que deseja implantar o contrato. Certifique-se de adicionar uma chave privada para a sua conta no arquivo de configuração (use variáveis de ambiente para maior segurança).

### 4. Implantar o Contrato

Para implantar o contrato na rede especificada:

```bash
npx hardhat run scripts/deploy.js --network <network-name>
```

Substitua `<network-name>` pelo nome da rede configurada no `hardhat.config.js`.

### 5. Executar o Frontend

Abra o arquivo `index.html` diretamente no seu navegador ou configure um servidor local para servir a página.

## 💻 Como Usar

1. **Conectar a Carteira** 🔗: Clique no botão "Conectar Carteira" na interface do frontend para conectar sua carteira MetaMask.
2. **Verificar Saldo** 💰: Insira o endereço desejado e clique em "Verificar Saldo" para consultar o saldo de tokens NKMT da conta.
3. **Verificar Conta** ✅: Insira o endereço de uma conta para verificar se já foi autenticada e conceder o bônus inicial de 10 tokens.
4. **Aprovar Conta para Gastar Tokens** ✔️: Insira o endereço de um gastador e a quantidade de tokens a serem aprovados para ele gastar em nome do usuário.
5. **Transferir Tokens** 💸: Insira o endereço do destinatário e clique em "Transferir" para enviar uma unidade de token para ele.

## 📁 Estrutura do Projeto

- **contracts/**: Contém o contrato inteligente `NKMT.sol` em Solidity.
- **scripts/**: Contém o script `deploy.js` para implantar o contrato usando Hardhat.
- **index.html**: Frontend principal em HTML e JavaScript.
- **nkmt.js**: Arquivo JavaScript para interagir com o contrato via Web3.js.
- **hardhat.config.js**: Configurações do Hardhat para redes e contas.

## 🔍 Exemplo de Código

### Exemplo de Função de Transferência no Frontend

```javascript
async function transferToken() {
  const recipient = document.getElementById("recipientAddress").value;
  const amount = web3.utils.toWei("1", "ether"); // Apenas 1 token conforme sua restrição
  const accounts = await web3.eth.getAccounts();
  try {
    await delay(1000);
    await nkmtContract.methods.transfer(recipient, amount).send({ from: accounts[0] });
    document.getElementById("transferResult").innerText = `Transferido 1 NKMT para ${recipient}`;
  } catch (error) {
    console.error("Erro ao transferir:", error);
    alert("Erro ao transferir: " + error.message);
  }
}
```

## 🤝 Contribuição

Contribuições são bem-vindas! Sinta-se à vontade para abrir um problema ou enviar um pull request.

## 📜 Licença

Este projeto está licenciado sob a licença MIT. Consulte o arquivo [LICENSE](LICENSE) para obter mais informações.
