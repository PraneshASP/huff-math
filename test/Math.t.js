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

  it("Should add numbers", async function () {
    let num1 = 3,
      num2 = 10;
    await math.addNumbers(num1, num2);
    expect(
      (await math.callStatic.addNumbers(num1, num2)).toString()
    ).to.be.equal((num1 + num2).toString());
  });
});
