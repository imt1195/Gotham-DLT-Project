const MainCompetition = artifacts.require("MainCompetition");

// const compNames = ["Competition 1", "Competition 2"];
// const prizeValues = [100,1000];
// const userTypes = ["Admin", "Participant"];

contract("MainCompetition", accounts => {

//   let [alice, bob] = accounts;
//   let contractInstance;
//   beforeEach(async () => {
//     contractInstance = await MainCompetition.deployed();
// });

it("...should set and check a user type.", async () => {
  
  contractInstance = await MainCompetition.deployed();

  // Set value
  const result = await contractInstance.selectUserType("Admin", {from: accounts[0] });

  // Get stored value
  const userType = await contractInstance.addressToUserType[accounts[0]].call();

  // // Check value
  assert.equal(userType, 1, "The the user was set to an admin.");
});

});
