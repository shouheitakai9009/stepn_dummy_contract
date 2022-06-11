// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;

contract GenerateRandom {

  uint private nonce = 0;

  function _generateRandomNumber(uint8 max, uint8 min) internal returns (uint32) {
    uint randomnumber = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, nonce)));
    nonce++;
    return uint32(randomnumber % (max - min) + min);
  }
}