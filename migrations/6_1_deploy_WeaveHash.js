const WeaveHash = artifacts.require("WeaveHash");

module.exports = function (deployer) {
  deployer.deploy(WeaveHash);
};
