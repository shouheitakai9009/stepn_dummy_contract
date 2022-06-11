const SneakerFactory = artifacts.require("SneakerFactory");

module.exports = function (deployer) {
  deployer.deploy(SneakerFactory);
};
