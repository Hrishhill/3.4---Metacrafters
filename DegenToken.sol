// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract WWESalaryToken is ERC20, Ownable {

    constructor() ERC20("WWESalary", "WWE") Ownable(msg.sender) {}

    event SalaryTransfer(address indexed from, address indexed to, uint256 value);
    event SalaryRedeemed(address indexed wrestler, uint256 amount, uint256 tokensRedeemed);

    uint256 private total_Supply;

    struct RedeemedSalary {
        uint256 amount;
        uint256 tokensRedeemed;
    }

    mapping(address => RedeemedSalary[]) private redeemedSalaries;
    uint256 public tokenCost = 1; // 1 WWE token per salary unit

    function totalSupply() public view override returns (uint256) {
        return total_Supply;
    }

    function mintSalary(address to, uint256 amount) public onlyOwner {
        require(to != address(0), "Invalid: Zero address");
        _mint(to, amount);
        total_Supply += amount;
        emit SalaryTransfer(address(0), to, amount);
    }

    function burnSalary(address from, uint256 amount) public {
        require(from != address(0), "Invalid: Zero Address");
        _burn(from, amount);
        total_Supply -= amount;
        emit SalaryTransfer(from, address(0), amount);
    }

    function transferSalary(address sender, address recipient, uint256 amount) public returns (bool) {
        require(sender != address(0), "Invalid sender address");
        require(recipient != address(0), "Invalid recipient address");
        _transfer(sender, recipient, amount);
        emit SalaryTransfer(sender, recipient, amount);
        return true;
    }

    function checkBalance(address account) public view returns (uint256) {
        require(account != address(0), "Invalid: Zero address");
        return balanceOf(account);
    }

    function redeemSalary(uint256 amount) public {
        require(amount > 0, "Redeem amount must be greater than zero");
        uint256 cost = amount * tokenCost;
        require(balanceOf(_msgSender()) >= cost, "Insufficient token balance");

        _burn(_msgSender(), cost);

        redeemedSalaries[_msgSender()].push(RedeemedSalary({
            amount: amount,
            tokensRedeemed: cost
        }));

        emit SalaryRedeemed(_msgSender(), amount, cost);
    }

    function getRedeemedSalaries(address account) public view returns (RedeemedSalary[] memory) {
        require(account != address(0), "Invalid: zero address");
        return redeemedSalaries[account];
    }

    function printRedeemedSalaries(address account) public view returns (string memory) {
        require(account != address(0), "Invalid: zero address");
        RedeemedSalary[] memory items = redeemedSalaries[account];
        require(items.length > 0, "No redeemed salaries found");

        string memory result = "";
        for (uint i = 0; i < items.length; i++) {
            result = string(abi.encodePacked(
                result,
                "Redemption ", uintToString(i + 1), ": ",
                "Amount: ", uintToString(items[i].amount),
                " Tokens Redeemed: ", uintToString(items[i].tokensRedeemed),
                "\n"
            ));
        }
        return result;
    }

    function uintToString(uint256 v) internal pure returns (string memory) {
        if (v == 0) {
            return "0";
        }
        uint256 digits;
        uint256 temp = v;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (v != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(v % 10)));
            v /= 10;
        }
        return string(buffer);
    }
}
