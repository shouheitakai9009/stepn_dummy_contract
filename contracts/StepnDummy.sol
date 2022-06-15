// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;

import { SneakerFactory } from './SneakerFactory.sol';
import { UserFactory } from './UserFactory.sol';

contract StepnDummy is 
  SneakerFactory,
  UserFactory
{}