const YourContractName = artifacts.require("FiatToken");

module.exports = function (deployer) {
  deployer.deploy(FiatToken, "MyToken", "MTK", "USD", 18, "0xAddressOfMasterMinter", "0xOwnerAddress");
};
