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
    bool putOn;
    uint32 baseEfficiency;
    uint32 baseLuck;
    uint32 baseComfort;
    uint32 baseResiliense;
    uint32 pointNum;
  }
}