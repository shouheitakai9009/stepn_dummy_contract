const SneakerFactory = artifacts.require("SneakerFactory");

const sneakerNames = ["#1", "#2"];
contract("SneakerFactory", accounts => {
  let [alice, bob] = accounts;

  describe("靴を作成する", () => {
    it("オーナーが靴を作成すると成功すること", async () => {
      const contractInstance = await SneakerFactory.new();
      const result = await contractInstance.createSneaker(sneakerNames[0], 3, { from: alice });
      assert.equal(result.receipt.status, true);

      const sneakerId = result.logs[0].args.id;
      const shoeType = result.logs[0].args.shoe_type;
      assert.equal(shoeType, 3)

      const owner = await contractInstance.sneakerToOwner(sneakerId);
      assert.equal(owner, alice)
    })
    it("オーナー以外が靴を作成すると失敗すること", async () => {
      const contractInstance = await SneakerFactory.new();
      try {
        await contractInstance.createSneaker(sneakerNames[0], 3, { from: bob });
      } catch (error) {
        assert.equal(error.reason, "Ownable: caller is not the owner");
      }
    })
  })
})