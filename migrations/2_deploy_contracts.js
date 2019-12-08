const SimpleStorage = artifacts.require("SimpleStorage");
const TutorialToken = artifacts.require("TutorialToken");
const MainCompetition = artifacts.require("MainCompetition");

module.exports = function(deployer) {
  deployer.deploy(SimpleStorage);
  deployer.deploy(TutorialToken);
  deployer.deploy(MainCompetition);
};
