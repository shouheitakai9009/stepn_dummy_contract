const SneakerFactory = artifacts.require("SneakerFactory");

const sneakerNames = ["#1", "#2"];
contract("SneakerFactory", accounts => {
  let [alice, bob] = accounts;
  let sneakerInstance, result;

  describe("靴を作成する", async () => {

    let [identifier, shoeType, shoeRarity] = []
  
    beforeEach(async () => {
      sneakerInstance = await SneakerFactory.new();
      result = await sneakerInstance.createSneaker(sneakerNames[0], 0, 0, { from: alice });
      identifier = result.logs[0].args.identifier;
      shoeType = result.logs[0].args.shoeType;
      shoeRarity = result.logs[0].args.rarity;
    })
    it("靴を作成しレシートが受領される", async () => {
      assert.equal(result.receipt.status, true);
    })
    it("種類が指定した値であること", async () => {
      assert.equal(shoeType, 0)
    })
    it("靴の作成者が間違いなくオーナーであること", async () => {
      const owner = await sneakerInstance.sneakerToOwner(identifier);
      assert.equal(owner, alice)
    })
    it("靴一覧が1の長さになっていること", async () => {
      const sneakers = await sneakerInstance.getSneakers();
      assert.equal(sneakers.length, 1);
      console.log(sneakers[0])
    })
    it("間違ったシューズ種類でオーナーが靴を作成する", async () => {
      try {
        sneakerInstance = await SneakerFactory.new();
        await sneakerInstance.createSneaker(sneakerNames[0], 5, 0, { from: alice });
      } catch (error) {
        assert.equal(error.data.name, "RuntimeError")
      }
    })
    it("間違ったレア度でオーナーが靴を作成する", async () => {
      try {
        sneakerInstance = await SneakerFactory.new();
        await sneakerInstance.createSneaker(sneakerNames[0], 0, 4, { from: alice });
      } catch (error) {
        assert.equal(error.data.name, "RuntimeError")
      }
    })
    it("オーナー以外が靴を作成すると失敗すること", async () => {
      try {
        sneakerInstance = await SneakerFactory.new();
        await sneakerInstance.createSneaker(sneakerNames[0], 0, 0, { from: bob });
      } catch (error) {
        assert.equal(error.reason, "Ownable: caller is not the owner");
      }
    })
  })
})