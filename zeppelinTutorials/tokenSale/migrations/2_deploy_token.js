// object contaning arguments for constructor
const settings = {
  name: "xShares",
  symbol: "SHR",
  decimals: 18,
  ammount: 1000000
};

const Token = artifacts.require("./SecurityToken");

// im not sure whats happening with all these promises yet?
// suposedly this makes it easier if we are using more than one function
// in more complicated contracts
module.exports = (deployer, network, [owner]) => deployer
  .then(() => deployToken(deployer, owner));

function deployToken(deployer, owner) {
  return deployer.deploy(
    Token,
    settings.name,
    settings.symbol,
    settings.decimals,
    settings.ammount,
  );
}
