const UserFactory = artifacts.require("UserFactory");

contract("UserFactory", accounts => {
  let [alice, bob] = accounts;
  let userInstance, result;

  describe("ユーザを作成する", async () => {

    let [user] = []
  
    beforeEach(async () => {
      userInstance = await UserFactory.new();
      result = await userInstance.createUser("shouheitakai", true, "shouheitakai.me@gmail.com", "Asilasil2", 0, { from: bob });
      user = result.logs[0].args;
    })

    it("名前が一致している", async () => {
      const result = await userInstance.getUserMetadata(user.userId)
      assert.equal(result.name, "shouheitakai");
    })
  })
})