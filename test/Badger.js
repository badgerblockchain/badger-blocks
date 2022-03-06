const { ethers } = require("hardhat");  // optional, but more explicit

// We import Chai to use its asserting functions here.
const { expect } = require("chai");

////
//// This is a testing script used to ensure Badger.sol is doing what we want
////

describe("Badger NFT Contract", function () {

    // creating global variables to setup with
    let Badger_1;
    let addr1;
    let addr2;
    let addr3;
    let owner;

    it("Should check NewBadger event when calling createBadger()", async function () {
        const BadgerContract = await ethers.getContractFactory("Badger");
        const badgerContract = await BadgerContract.deploy();
        
        // call createBadger with an arbitrary name and check NewBadger event
        await expect(badgerContract.createBadger("Test Badger"))
            .to.emit(badgerContract, "BadgerMint")
            .withArgs(, 1);

    });

    // TODO: cannot figure out the null address
    it("Should check Transfer event when calling createBadger()", async function () {
        const BadgerContract = await ethers.getContractFactory("Badger");
        const badgerContract = await BadgerContract.deploy();
    
        // call createBadger and check _mint() Transfer event
        await expect(badgerContract.createBadger("Next Badger"))
            .to.emit(badgerContract, "Transfer")
            .withArgs('0x000000000000000000000000000000000000000', 0, 0);        
    
    });

    // it("Should check if only one Badger can be minted per address", async function () {
    //     const BadgerContract = await ethers.getContractFactory("Badger");
    //     const badgerContract = await BadgerContract.deploy();


    // });

});