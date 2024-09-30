// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyToken {
    string public name = "Token";
    string public symbol = "TKN";
    uint8 public decimals = 18; // num de decimais para o token
    uint256 public totalSupply;

    // Mapeamento para armazenar saldos e permissões de gasto
    // mapping(endereço => saldo)
    mapping(address => uint256) public balanceOf;
    // mapping(endereço do proprietário => mapping(endereço do gastador => valor permitido))
    mapping(address => mapping(address => uint256)) public allowance;

    // Eventos para registrar transferências e aprovações de tokens
    event Transfer(address indexed from, address indexed to, uint256 value); // Evento para quando tokens são transferidos
    event Approval(address indexed owner, address indexed spender, uint256 value); // Evento para quando uma aprovação de gasto é dada

    constructor() {
        totalSupply = 10 * 10**uint256(decimals); // Total supply é 10 tokens com 18 casas decimais
        balanceOf[msg.sender] = totalSupply; // Deployer recebe todos os tokens
    }

    // Função para transferir tokens de um endereço para o outro.
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(_to != address(0), "Invalid address"); // Verifica se o endereço de destino não é nulo
        require(_value == 1 * 10**uint256(decimals), "Transfers are limited to 1 token at a time"); // Limita as tranferências a 1 token por vez
        require(balanceOf[msg.sender] >= _value, "Insufficient balance"); // Verifica se o remetente tem saldo suficiente

        // Atualiza os saldos do remetente e do destinatário.
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        // Emite o evento de transferência
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    // Função para aprovar que um terceiro gaste tokens em nome do proprietário
    function approve(address _spender, uint256 _value) public returns (bool success) {
        require(_spender != address(0), "Invalid address"); // Verifica se o endereço do gastador não é nulo
        allowance[msg.sender][_spender] = _value; // Define o valor que o gastador pode gastar em nome do proprietário

        // Emite o evento de aprovação
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    // Função para transferir tokens de uma conta usando a permissão de gasto.
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_to != address(0), "Invalid address"); // Verifica se  endereço de destino não é nulo
        require(_value == 1 * 10**uint256(decimals), "Transfers are limited to 1 token at a time"); // Limita as tranferências a 1 token por vez
        require(balanceOf[_from] >= _value, "Insufficient balance"); // Verifica se a conta de origem tem saldo suficiente.
        require(allowance[_from][msg.sender] >= _value, "Allowance exceeded"); // Verifica se a permissão de gasto é suficiente.

        // Atualiza os saldos da conta de origem e de destino.
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        // Reduz a permissão de gasto do gastador.
        allowance[_from][msg.sender] -= _value;

        // Emite o evento de transferência.
        emit Transfer(_from, _to, _value);
        return true;
    }
}
