pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract SneakerFactory is Ownable {

  event NewSneaker(uint id, uint8 shoe_type);

  struct Sneaker {
    uint id;
    uint8 shoe_type; // 1: WALKER, 2: JOGGER, 3: RUNNER, 4: TRAINER
  }

  Sneaker[] public sneakers;

  mapping (uint => address) public sneakerToOwner;

  function _createSneaker(uint _id, uint8 _shoe_type) private {
    sneakers.push(Sneaker(_id, _shoe_type));
    sneakerToOwner[_id] = msg.sender;
    emit NewSneaker(_id, _shoe_type);
  }

  function _generateSneakerId(string memory _str) private pure returns (uint) {
    uint rand = uint(keccak256(abi.encode(_str)));
    return rand % (10 ** 16);
  }

  function createSneaker(string memory _shoe_name, uint8 _shoe_type) public payable onlyOwner {
    uint randName = _generateSneakerId(_shoe_name);
    _createSneaker(randName, _shoe_type);
  }
}