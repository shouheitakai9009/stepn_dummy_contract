// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import { ISneakerData } from "./interface/ISneakerData.sol";
import { GenerateRandom } from "./utility/GenerateRandom.sol";
import { Validator } from "./utility/Validator.sol";

contract SneakerFactory is
  ERC721("Stepn dummu sneaker", "SDS"),
  Ownable,
  GenerateRandom,
  Validator
{
  using Counters for Counters.Counter;

  // @dev 変数宣言
  ISneakerData.Sneaker[] private _sneakers;
  Counters.Counter private _tokenIds;
  mapping (uint256 => address) public sneakerToOwner;
  mapping (address => ISneakerData.Sneaker[]) private _ownerToSneakers;

  // @dev Event宣言
  event NewSneaker(uint256 tokenId, ISneakerData.ShoeType shoeType, ISneakerData.Rarity rarity);

  function _createSneaker(ISneakerData.ShoeType _shoeType, ISneakerData.Rarity _rarity) private {

    uint256 newTokenId = _tokenIds.current(); // Unique Token ID
    uint32 efficiency = _generateStatusBasedOnRarity(_rarity);
    uint32 luck = _generateStatusBasedOnRarity(_rarity);
    uint32 comfort = _generateStatusBasedOnRarity(_rarity);
    uint32 resiliense = _generateStatusBasedOnRarity(_rarity);

    // @dev Original new sneaker instance
    ISneakerData.Sneaker memory _newSneaker = ISneakerData.Sneaker(newTokenId, _shoeType, _rarity, 0, 100, 0, true, efficiency, luck, comfort, resiliense, efficiency, luck, comfort, resiliense, 0, false, 0, 0);

    _sneakers.push(_newSneaker);
    _ownerToSneakers[msg.sender].push(_newSneaker);
    sneakerToOwner[newTokenId] = msg.sender;
    emit NewSneaker(newTokenId, _shoeType, _rarity);
    _tokenIds.increment();
  }

  function _generateStatusBasedOnRarity(ISneakerData.Rarity _rarity) private returns (uint32) {
    if (_rarity == ISneakerData.Rarity.COMMON) {
      return GenerateRandom._generateRandomNumber(10, 1);
    } else if (_rarity == ISneakerData.Rarity.UNCOMMON) {
      return _generateRandomNumber(18, 8);
    } else if (_rarity == ISneakerData.Rarity.RARE) {
      return _generateRandomNumber(35, 15);
    } else if (_rarity == ISneakerData.Rarity.EPIC) {
      return _generateRandomNumber(63, 28);
    }
    return uint32(0);
  }

  function createSneaker(ISneakerData.ShoeType _shoeType, ISneakerData.Rarity _rarity)
    public
    payable
    onlyOwner
    validateShoeType(_shoeType)
    validateRarity(_rarity)
  {
    _createSneaker( _shoeType, _rarity);
  }

  function getSneakers() public view onlyOwner returns (ISneakerData.Sneaker[] memory) {
    return _sneakers;
  }

  function getOwnerToSneakers(address _owner) public view returns (ISneakerData.Sneaker[] memory) {
    return _ownerToSneakers[_owner];
  }
}