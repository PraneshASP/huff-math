const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Math", function () {
  beforeEach(async function () {
    const Math = await ethers.getContractFactory("Math");
    math = await Math.deploy();
    await math.deployed();
  });
  it("Math is deployed", async function () {
    expect(math.address).to.not.equal(
      "0x0000000000000000000000000000000000000000"
    );
  });
});
