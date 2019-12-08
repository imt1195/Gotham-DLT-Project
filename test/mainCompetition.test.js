const MainCompetition = artifacts.require("MainCompetition");

contract("MainCompetition", accounts => {
  it("...should store the value 89.", async () => {
    const MainCompetitionInstance = await MainCompetition.deployed();

    // Set value of 89
    await MainCompetitionInstance.set(89, { from: accounts[0] });

    // Get stored value
    const storedData = await MainCompetitionInstance.storedData.call();

    assert.equal(storedData, 89, "The value 89 was not stored.");
  });
});
