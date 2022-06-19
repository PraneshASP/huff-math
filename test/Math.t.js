const { expect } = require("chai");
const { ethers } = require("hardhat");

const OVERLOW =
  "115792089237316195423570985008687907853269984665640564039457584007913129639933";

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

  it("Should subtract numbers", async function () {
    let num1 = 13,
      num2 = 10;
    let expected = num1 > num2 ? OVERLOW : num2 - num1;
    await math.subNumbers(num1, num2);
    expect(await math.callStatic.subNumbers(num1, num2)).to.be.equal(expected);
  });

  it("Performs abs", async function () {
    let num1 = 1990,
      num2 = 188888;
    await math.abs(num1, num2);
    expect(await math.callStatic.abs(num1, num2)).to.be.equal(
      Math.abs(num1 - num2)
    );
  });
});
