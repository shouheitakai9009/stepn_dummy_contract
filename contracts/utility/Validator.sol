// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;

import { ISneakerData } from "../interface/ISneakerData.sol";

contract Validator {

  modifier validateShoeType(ISneakerData.ShoeType _shoeType) {
    require(
      uint(_shoeType) >= uint(ISneakerData.ShoeType.WAKER) &&
      uint(ISneakerData.ShoeType.TRAINER) >= uint(_shoeType)
    );
    _;
  }

  modifier validateRarity(ISneakerData.Rarity _rarity) {
    require(
      uint(_rarity) >= uint(ISneakerData.Rarity.COMMON) &&
      uint(ISneakerData.Rarity.EPIC) >= uint(_rarity)
    );
    _;
  }
}