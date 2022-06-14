// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;

contract Validator {

  modifier shoeType(ISneakerData.ShoeType _shoeType) {
    require(
      uint(_shoeType) >= uint(ISneakerData.ShoeType.WAKER) &&
      uint(ISneakerData.ShoeType.TRAINER) >= uint(_shoeType)
    );
    _;
  }

  modifier rarity(ISneakerData.Rarity _rarity) {
    require(
      uint(_rarity) >= uint(ISneakerData.Rarity.COMMON) &&
      uint(ISneakerData.Rarity.EPIC) >= uint(_rarity)
    );
    _;
  }
}