// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract VerifiedERC20Token {
    // Atributos privados do contrato
    string private constant _name = "Dojo";
    string private constant _symbol = "DOJO";
    uint256 private _totalSupply;

    error NoBalance();
    error InvalidAddress();
    error AccountAlreadyVerified();

    // Mapeamento para armazenar os saldos de cada endereço
    mapping(address => uint256) public _balance;

    // Inicializa o contrato com o nome e o simbolo do token
    constructor() {
        _balance[msg.sender] = 10;
    }

    // Função para retornar o saldo de uma conta
    function balanceOf(address account) public view returns (uint256) {
        return _balance[account];
    }

    // Função para retornar o total de tokens em circulação
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    // Função para transferir tokens para outra conta
    function transfer(address to, uint256 amount) public returns (bool) {
        address owner = msg.sender;

        if (_balance[owner] < amount) {
            revert NoBalance();
        }
        if (to == address(0)) {
            revert InvalidAddress();
        }

        // Atualiza os saldos
        _balance[owner] -= amount;
        _balance[to] += amount;

        return true;
    }

    // Mapeamento para rastrear contas verificadas
    mapping(address => bool) private _verifiedAccounts;

    // Mapeamento para garantir que os tokens iniciais sejam atribuídos apenas uma vez
    mapping(address => bool) private _initialTokensGranted;

    // Função para marcar uma conta co mo verificada
    function verifyAccount(address account) public {
        if (_verifiedAccounts[account]) {
            revert AccountAlreadyVerified();
        }

        _verifiedAccounts[account] = true;

        // Atribui 10 tokens para a conta se ainda não recebeu
        if (!_initialTokensGranted[account]) {
            _balance[account] += 10 * (10 ** uint256(18)); // 18 decimais
            _initialTokensGranted[account] = true;

            // Atualiza o totalSuply
            _totalSupply += 10 * (10 ** uint256(18));
        }


    }

    // Função para verificar se uma conta está verificada
    function isVerified(address account) public view returns (bool) {
        return _verifiedAccounts[account];
    }

    
}
