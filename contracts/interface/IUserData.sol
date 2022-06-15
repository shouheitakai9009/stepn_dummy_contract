// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;

interface IUserData {
  struct User {
    uint256 userId;
    string name;
    uint8 male;
    string email;
    string password;
    uint8 avatorId;
  }
}