// Endereço do contrato e carregamento da ABI
const contractAddress = "0x33bA288B3dE8aEf29152DE4780dC8c52c6618934"; // Substitua pelo endereço real do contrato
let web3;
let nkmtContract;

async function initWeb3() {
    if (window.ethereum) {
        web3 = new Web3(window.ethereum);
        try {
            await window.ethereum.request({ method: 'eth_requestAccounts' });
            console.log("Conexão com MetaMask bem-sucedida");
            
            // Carrega a ABI do arquivo JSON
            const response = await fetch("./NKMT.json");
            const contractJson = await response.json();
            const contractABI = contractJson.abi;

            // Inicializa o contrato
            nkmtContract = new web3.eth.Contract(contractABI, contractAddress);
        } catch (error) {
            console.error("Erro ao conectar com MetaMask:", error);
        }
    } else {
        alert("Por favor, instale o MetaMask para continuar.");
    }
}

async function getBalance() {
    if (!web3 || !nkmtContract) {
        console.error("Web3 ou contrato não inicializado");
        return;
    }

    const accounts = await web3.eth.getAccounts();
    if (accounts.length === 0) {
        alert("Por favor, conecte sua conta MetaMask.");
        return;
    }

    try {
        const balance = await nkmtContract.methods.balanceOf(accounts[0]).call();
        document.getElementById("balance").innerText = web3.utils.fromWei(balance, 'ether') + " NKMT";
        console.log("Saldo atualizado:", balance);
    } catch (error) {
        console.error("Erro ao obter saldo:", error);
    }
}

async function transferToken() {
    if (!web3 || !nkmtContract) {
        console.error("Web3 ou contrato não inicializado");
        return;
    }

    const accounts = await web3.eth.getAccounts();
    const recipient = document.getElementById("recipient").value;

    if (!web3.utils.isAddress(recipient)) {
        alert("Por favor, insira um endereço Ethereum válido.");
        return;
    }

    try {
        const tx = await nkmtContract.methods.transfer(recipient, web3.utils.toWei("1", "ether")).send({ from: accounts[0] });
        console.log("Transferência bem-sucedida:", tx);
        alert("Transferência bem-sucedida!");
        getBalance();
    } catch (error) {
        console.error("Erro ao transferir:", error);
        alert("Erro ao transferir: " + error.message);
    }
}

// Inicializar Web3 ao carregar a página
window.addEventListener('load', () => {
    initWeb3().then(() => {
        getBalance();
    });
});
