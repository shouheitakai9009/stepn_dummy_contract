// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import { IUserData } from "./interface/IUserData.sol";
import { Validator } from "./utility/Validator.sol";

contract UserFactory is
  Ownable,
  Validator
{
  using Counters for Counters.Counter;

  // @dev 変数宣言
  Counters.Counter private _userIds;
  mapping (uint256 => IUserData.User) private _userMetadata;

  // @dev Event宣言
  event NewUser(uint256 userId);

  function createUser(
    string memory _name,
    uint8 _male,
    string memory _email,
    string memory _password,
    uint8 _avatorId
  ) public payable {
    uint256 newUserId = _userIds.current();
    IUserData.User memory newUser = IUserData.User(newUserId, _name, _male, _email, _password, _avatorId);
    _userMetadata[newUserId] = newUser;
    emit NewUser(newUserId);
    _userIds.increment();
  }

  function getUserMetadata(uint256 _userId) public view returns (IUserData.User memory) {
    return _userMetadata[_userId];
  }
}