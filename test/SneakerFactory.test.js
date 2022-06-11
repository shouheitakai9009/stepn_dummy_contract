const SneakerFactory = artifacts.require("SneakerFactory");

const sneakerNames = ["#1", "#2", "#3", "#4"];
contract("SneakerFactory", accounts => {
  let [alice, bob] = accounts;
  let sneakerInstance, result;

  describe("靴を作成する", async () => {

    let [identifier, shoeType, shoeRarity] = []
  
    beforeEach(async () => {
      sneakerInstance = await SneakerFactory.new();
      result = await sneakerInstance.createSneaker(sneakerNames[0], 0, 0, { from: alice });
      await sneakerInstance.createSneaker(sneakerNames[1], 0, 1, { from: alice });
      await sneakerInstance.createSneaker(sneakerNames[2], 0, 2, { from: alice });
      await sneakerInstance.createSneaker(sneakerNames[3], 0, 3, { from: alice });
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
    it("オーナーが保持する靴数が1になっていること", async () => {
      const sneakers = await sneakerInstance.getOwnerToSneakers({ from: alice });
      assert.equal(sneakers.length, 4);
    })
    it("靴一覧が1の長さになっていること", async () => {
      let sneakers = await sneakerInstance.getSneakers();
      assert.equal(sneakers.length, 4);
    })
    describe("レア度に応じたステータスランダム性", () => {
      it("レア度[Common]のステータスは1-10以内であること", async () => {
        const sneakers = await sneakerInstance.getSneakers();
        assert(sneakers[0].baseEfficiency >= 1 && sneakers[0].baseEfficiency <= 10);
        assert(sneakers[0].baseLuck >= 1 && sneakers[0].baseLuck <= 10);
        assert(sneakers[0].baseComfort >= 1 && sneakers[0].baseComfort <= 10);
        assert(sneakers[0].baseResiliense >= 1 && sneakers[0].baseResiliense <= 10);
      })
      it("レア度[Uncommon]のステータスは8-18以内であること", async () => {
        const sneakers = await sneakerInstance.getSneakers();
        assert(sneakers[1].baseEfficiency >= 8 && sneakers[1].baseEfficiency <= 18);
        assert(sneakers[1].baseLuck >= 8 && sneakers[1].baseLuck <= 18);
        assert(sneakers[1].baseComfort >= 8 && sneakers[1].baseComfort <= 18);
        assert(sneakers[1].baseResiliense >= 8 && sneakers[1].baseResiliense <= 18);
      })
      it("レア度[Rare]のステータスは15-35以内であること", async () => {
        const sneakers = await sneakerInstance.getSneakers();
        assert(sneakers[2].baseEfficiency >= 15 && sneakers[2].baseEfficiency <= 35);
        assert(sneakers[2].baseLuck >= 15 && sneakers[2].baseLuck <= 35);
        assert(sneakers[2].baseComfort >= 15 && sneakers[2].baseComfort <= 35);
        assert(sneakers[2].baseResiliense >= 15 && sneakers[2].baseResiliense <= 35);
      })
      it("レア度[Epic]のステータスは28-63以内であること", async () => {
        const sneakers = await sneakerInstance.getSneakers();
        assert(sneakers[3].baseEfficiency >= 28 && sneakers[3].baseEfficiency <= 63);
        assert(sneakers[3].baseLuck >= 28 && sneakers[3].baseLuck <= 63);
        assert(sneakers[3].baseComfort >= 28 && sneakers[3].baseComfort <= 63);
        assert(sneakers[3].baseResiliense >= 28 && sneakers[3].baseResiliense <= 63);
      })
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