// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;

interface ISneakerData {
  enum ShoeType {
    WAKER,
    JOGGER,
    RUNNER,
    TRAINER
  }
  enum Rarity {
    COMMON,
    UNCOMMON,
    RARE,
    EPIC
  }
  struct Sneaker {
    uint identifier;
    ShoeType shoeType;
    Rarity rarity;
    uint8 level;
    uint8 durability;
    uint8 mintCount;
    bool putOn;
    uint32 baseEfficiency;
    uint32 baseLuck;
    uint32 baseComfort;
    uint32 baseResiliense;
    uint32 efficiency;
    uint32 luck;
    uint32 comfort;
    uint32 resiliense;
    uint32 pointNum;
    bool minted;
    uint mintedFromIdentifier1;
    uint mintedFromIdentifier2;
  }
}