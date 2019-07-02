const lot = artifacts.require("SimpleLottery");

module.exports = function(deployer) {
    var duration = 120; // 3 days
    deployer.deploy(lot, duration);
};
