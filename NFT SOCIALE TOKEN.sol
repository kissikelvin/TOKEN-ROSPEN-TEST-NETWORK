/*
Implements EIP20 token standard: https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md
.*/


pragma solidity ^0.4.21;

import "./EIP20Interface.sol";


contract NFTSOCIALE is EIP20Interface {

    uint256 constant private MAX_UINT256 = 2**256 - 1;
    mapping (address => uint256) public balances;
    mapping (address => mapping (address => uint256)) public allowed;
    /*
    NOTE:
    The following variables are OPTIONAL vanities. One does not have to include them.
    They allow one to customise the token contract & in no way influences the core functionality.
    Some wallets/interfaces might not even bother to look at this information.
    */
    string public name;                   //fancy name: eg Simon Bucks
    uint8 public decimals;                //How many decimals to show.
    string public symbol;                 //An identifier: eg SBX

    function NFTSOCIALE(
        uint256 _initialAmount,
        string _tokenName,
        uint8 _decimalUnits,
        string _tokenSymbol
    ) public {
        balances[msg.sender] = _initialAmount;               // Give the creator all initial tokens
        totalSupply = _initialAmount;                        // Update total supply
        name = _tokenName;                                   // Set the name for display purposes
        decimals = _decimalUnits;                            // Amount of decimals for display purposes
        symbol = _tokenSymbol;                               // Set the symbol for display purposes
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balances[msg.sender] >= _value);
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value); //solhint-disable-line indent, no-unused-vars
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        uint256 allowance = allowed[_from][msg.sender];
        require(balances[_from] >= _value && allowance >= _value);
        balances[_to] += _value;
        balances[_from] -= _value;
        if (allowance < MAX_UINT256) {
            allowed[_from][msg.sender] -= _value;
        }
        emit Transfer(_from, _to, _value); //solhint-disable-line indent, no-unused-vars
        return true;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value); //solhint-disable-line indent, no-unused-vars
        return true;
    }

    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }
}


///HOW TO CREATE YOUR OWN CRYPTOCURRENCY?
/// 1. INSTALL METAMASK
///    a. CREATE AN ACCOUNT AND SWITCH IT OVER TO TESTNET
/// 2. GO OVER TO ROSPEN
///    a. RECEIVE THE TOKENS AFTER A WHILE
/// 3. GO OVER TO CONSENSYS GITHUB ACCOUNT
///    a. CHECK 'TOKENS: ETHEREUM TOKENS CONTRACT' REPOSITORY
///    b. CONTRACTS -> EIP20 -> SOLIDITY CONTRACTS
///    C. IMPORT THE CONTRACT TO REMIX
/// 4. RUN AND DEPLOY YOUR OWN CRYPTOCCURENCY!!!
/// 5. CHECK YOUR TRANSACTIONS AT: ROPSTEN.ETHERSCAN.IO



/// 6. GET FREE ETHER ON https://faucet.metamask.io/ OR https://faucet.ropsten.be/
/// 7. CREATE ANOTHER FILE NAME 'EIP20INERFACE'
/// 8. GO TO DEPLOY & RUN TRANSACTIONS AND SWITCH THE ENVIRONMENT TO 'INJECTED WEB3'
/// 9. MAKE SURE TO ENTER THE METRICS DESIRED FOR YOUR TOKEN BEFORE 'TRANSACTING'.
/// 10.ONCE CONTRACT IS DEPLOYED IT WILL APPEAR UNDER TRANSACTIONS RECORDED
/// 11. TO CHECK BALANCE COPY THE METAMASK ADDRESS FROM THE WALLET: "0xC795C8AAb6e3c6421A5d6c3b53dE3B02a98caFb5"
/// 12. HIT 'CALL' TO RETURN THE INITIAL AMAOUNT OF TOKEN UINT256:....
/// 13. CHECK TRANSACTION AND CONTRACT ON https://ropsten.etherscan.io/ 