// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

pragma solidity ^0.7.3;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Operator is ERC20 {
    IERC20 public collateral;
    uint256 price = 1;

    constructor(address _collateral) ERC20("Collateral Backed Token", "CBT") {
        collateral = IERC20(_collateral);
    }

    function deposit(uint256 collateralAmount) external {
        collateral.transferFrom(msg.sender, address(this), collateralAmount);
        _mint(msg.sender, collateralAmount * price);
    }

    function withdraw(uint256 tokenAmount) external {
        require(balanceOf(msg.sender) >= tokenAmount, "balance too low");
        _burn(msg.sender, tokenAmount);
        collateral.transfer(tokenAmount / price);
    }
}
