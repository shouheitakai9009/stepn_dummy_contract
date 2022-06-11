// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import { ISneakerData } from "./interface/ISneakerData.sol";
import { GenerateRandom } from "./utility/GenerateRandom.sol";

contract SneakerFactory is Ownable, ERC721('STEPN DUMMY', 'STD'), GenerateRandom {

  event NewSneaker(uint identifier, ISneakerData.ShoeType shoeType, ISneakerData.Rarity rarity);

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

  ISneakerData.Sneaker[] private _sneakers;
  uint private _identifier = 0;

  mapping (uint => address) public sneakerToOwner;
  mapping (address => ISneakerData.Sneaker[]) private _ownerToSneakers;

  function _createSneaker(
    ISneakerData.ShoeType _shoeType,
    ISneakerData.Rarity _rarity
  )
    private
  {
    uint identifier = _generateIdentifier();
    uint32 efficiency = _generateStatusBasedOnRarity(_rarity);
    uint32 luck = _generateStatusBasedOnRarity(_rarity);
    uint32 comfort = _generateStatusBasedOnRarity(_rarity);
    uint32 resiliense = _generateStatusBasedOnRarity(_rarity);
    ISneakerData.Sneaker memory _newSneaker = ISneakerData.Sneaker(
      identifier,
      _shoeType,
      _rarity,
      0,
      100,
      0,
      true,
      efficiency,
      luck,
      comfort,
      resiliense,
      efficiency,
      luck,
      comfort,
      resiliense,
      0,
      false,
      0,
      0
    );
    _sneakers.push(_newSneaker);
    _ownerToSneakers[msg.sender].push(_newSneaker);
    sneakerToOwner[identifier] = msg.sender;
    emit NewSneaker(identifier, _shoeType, _rarity);
  }

  function _generateIdentifier()
    private
    returns (uint)
  {
    _identifier++;
    return _identifier;
  }

  function _generateStatusBasedOnRarity(ISneakerData.Rarity _rarity)
    private
    returns (uint32)
  {
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

  function createSneaker(
    ISneakerData.ShoeType _shoeType,
    ISneakerData.Rarity _rarity
  )
    public
    payable
    onlyOwner
    validateShoeType(_shoeType)
    validateRarity(_rarity)
  {
    _createSneaker( _shoeType, _rarity);
  }

  function getSneakers()
    public
    view
    onlyOwner
    returns (ISneakerData.Sneaker[] memory)
  {
    return _sneakers;
  }

  function getOwnerToSneakers(address _owner)
    public
    view
    returns (ISneakerData.Sneaker[] memory)
  {
    return _ownerToSneakers[_owner];
  }
}