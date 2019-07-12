// object contaning arguments for constructor
const settings = {
  rate: 10000,
};

const Token = artifacts.require("./SecurityToken");
const ICO = artifacts.require("./ICO");

// im not sure whats happening with all these promises yet?
// suposedly this makes it easier if we are using more than one function
// in more complicated contracts
module.exports = (deployer, network, [owner]) => deployer
  .then(() => deployICO(deployer, owner))
  .then(() => transferTokensToICO(owner))
  .then(() => displaySummary(owner));

function deployICO(deployer, owner) {
  return deployer.deploy(
    ICO,
    settings.rate,
    owner,
    Token.address,
  );
}

async function transferTokensToICO(owner) {
  const tokenInstance = (await Token.deployed());
  let ammountToTransfer = (await tokenInstance.balanceOf(owner));
  return tokenInstance.transfer(
    ICO.address,
    ammountToTransfer
  )
}

async function displaySummary(owner){
  const tokenInstance = (await Token.deployed());
  console.log(`    ==================================================
    Deployed Contracts:
    Tokens: ${Token.address}
    ICO : ${ICO.address}
    ==================================================
    Balances:
    ICO => ${await tokenInstance.balanceOf(ICO.address)} tokens
    Owner => ${await tokenInstance.balanceOf(owner)} tokens
    ==================================================
  `)
}
