/*
 .-.-. .-.-. .-.-. .-.-. .-.-. .-.-. 
( D .'( E .'( S .'( I .'( R .'( E .' 
 `.(   `.(   `.(   `.(   `.(   `.(   
                by sandman.finance                                     
 */
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.6;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract DesireLockerLiquidity is Ownable {
    using SafeERC20 for IERC20;

    uint256 public immutable UNLOCK_END_BLOCK;

    event Claim(IERC20 desireToken, address to);


    /**
     * @notice Constructs the Desire contract.
     */
    constructor(uint256 blockNumber) {
        UNLOCK_END_BLOCK = blockNumber;
    }

    /**
     * @notice claimSanManLiquidity
     * claimdesireToken allows the desire Team to send desire Liquidity to the new delirum kingdom.
     * It is only callable once UNLOCK_END_BLOCK has passed.
     * Desire Liquidity Policy: https://docs.desire.farm/token-info/desire-token/liquidity-lock-policy
     */

    function claimSanManLiquidity(IERC20 desireLiquidity, address to) external onlyOwner {
        require(block.number > UNLOCK_END_BLOCK, "Desire is still dreaming...");

        desireLiquidity.safeTransfer(to, desireLiquidity.balanceOf(address(this)));

        emit Claim(desireLiquidity, to);
    }
}