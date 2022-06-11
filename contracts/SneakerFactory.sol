// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;

import "@openzeppelin/contracts/access/Ownable.sol";
import { ISneakerData } from "./interface/ISneakerData.sol";
import { GenerateRandom } from "./utility/GenerateRandom.sol";

contract SneakerFactory is Ownable, GenerateRandom {

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

  mapping (uint => address) public sneakerToOwner;
  mapping (address => ISneakerData.Sneaker[]) private _ownerToSneakers;

  function _createSneaker(
    uint _identifier,
    ISneakerData.ShoeType _shoeType,
    ISneakerData.Rarity _rarity
  )
    private
  {
    ISneakerData.Sneaker memory _newSneaker = ISneakerData.Sneaker(
      _identifier,
      _shoeType,
      _rarity,
      0,
      100,
      true,
      _generateStatusBasedOnRarity(_rarity),
      _generateStatusBasedOnRarity(_rarity),
      _generateStatusBasedOnRarity(_rarity),
      _generateStatusBasedOnRarity(_rarity),
      0
    );
    _sneakers.push(_newSneaker);
    _ownerToSneakers[msg.sender].push(_newSneaker);
    sneakerToOwner[_identifier] = msg.sender;
    emit NewSneaker(_identifier, _shoeType, _rarity);
  }

  function _generateIdentifier(string memory _str)
    private
    pure
    returns (uint)
  {
    uint rand = uint(keccak256(abi.encode(_str)));
    return rand % (10 ** 16);
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
    string memory _name,
    ISneakerData.ShoeType _shoeType,
    ISneakerData.Rarity _rarity
  )
    public
    payable
    onlyOwner
    validateShoeType(_shoeType)
    validateRarity(_rarity)
  {
    uint identifier = _generateIdentifier(_name);
    _createSneaker(identifier, _shoeType, _rarity);
  }

  function getSneakers()
    public
    view
    onlyOwner
    returns (ISneakerData.Sneaker[] memory)
  {
    return _sneakers;
  }

  function getOwnerToSneakers()
    public
    view
    onlyOwner
    returns (ISneakerData.Sneaker[] memory)
  {
    return _ownerToSneakers[msg.sender];
  }
}