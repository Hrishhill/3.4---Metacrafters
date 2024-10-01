### WWE Salary Token Smart Contract 

---

#### Project Overview:

The **WWESalaryToken** smart contract is a unique solution for managing wrestler salaries through tokenization on the Ethereum blockchain. Inspired by WWE contracts, the contract uses ERC20 standards to handle minting, burning, transferring, and redeeming WWE salary tokens. Each wrestler's salary is represented by these tokens, which can be minted by the contract owner (e.g., WWE management) and later redeemed by wrestlers for specific items.

This project is deployed on the **Avalanche C-Chain**, and I’ve demonstrated various functions on **Snowtrace**, where you can see the contract execution details. Below, I’ll outline the key functions and how they work.

---

#### Deployment Details:

- **Network:** Avalanche Fuji
- **Contract Address:** [0x7EA64e9164e5968B1A99c9180A97C2634D8dF725]
- **Snowtrace Executions:** I have executed the following key functions:
  - Minting Salary Tokens
  - Burning Tokens
  - Transferring Salary
  - Redeeming WWE Tokens
  - Viewing Redeemed History

You can track these transactions and see the gas consumption, input/output parameters, and the events emitted during execution on Snowtrace.

---

#### Special Functions Explained:

Here are the most important functions in the contract:

1. **Mint Salary Tokens:**
   - **Function Name:** `mintSalary`
   - **Access:** Only contract owner
   - **Purpose:** Mint WWE salary tokens and assign them to a wrestler (specified by the `to` address).
   - **Parameters:** 
     - `address to`: The wrestler’s address.
     - `uint256 amount`: Number of tokens to mint.
   - **Example Execution:** This function was executed to mint salary tokens for a wrestler at the address `0xabc123` and can be viewed on Snowtrace.

2. **Burn Salary Tokens:**
   - **Function Name:** `burnSalary`
   - **Access:** Only the contract owner can burn tokens.
   - **Purpose:** Reduce the total supply by burning tokens from a wrestler's balance.
   - **Parameters:** 
     - `address from`: Address of the wrestler whose tokens are to be burned.
     - `uint256 amount`: Number of tokens to burn.
   - **Execution History:** This function has been executed multiple times to simulate wrestlers leaving WWE or contract termination.

3. **Transfer Salary Tokens:**
   - **Function Name:** `transferSalary`
   - **Access:** Public (can be called by any user)
   - **Purpose:** Transfer tokens from one wrestler to another.
