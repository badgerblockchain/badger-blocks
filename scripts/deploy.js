// This is a script for deploying your contracts. You can adapt it to deploy
// yours, or create new ones.
async function main() {
  // This is just a convenience check
  if (network.name === "hardhat") {
    console.warn(
      "You are trying to deploy a contract to the Hardhat Network, which" +
        "gets automatically created and destroyed every time. Use the Hardhat" +
        " option '--network localhost'"
    );
  }

  // ethers is available in the global scope
  const [deployer] = await ethers.getSigners();
  console.log(
    "Deploying the contracts with the account:",
    await deployer.getAddress()
  );

  console.log("Account balance:", (await deployer.getBalance()).toString());

  const Badger = await ethers.getContractFactory("Badger");
  const badger = await Badger.deploy();
  await badger.deployed();

  const BadgerWorld = await ethers.getContractFactory("BadgerWorld");
  const badgerWorld = await BadgerWorld.deploy();
  await badgerWorld.deployed();

  console.log("Badger contract address:", badger.address);
  console.log("BadgerWorld contract address:", badgerWorld.address);

  // We also save the contract's artifacts and address in the frontend directory
  saveFrontendFiles(badger, badgerWorld);
}

function saveFrontendFiles(badger, badgerWorld) {
  const fs = require("fs");
  const contractsDir = __dirname + "/../frontend/src/contracts";

  if (!fs.existsSync(contractsDir)) {
    fs.mkdirSync(contractsDir);
  }

  fs.writeFileSync(
    contractsDir + "/contract-address.json",
    JSON.stringify({ Badger: badger.address, BadgerWorld: badgerWorld.address }, undefined, 2)
  );

  const BadgerArtifact = artifacts.readArtifactSync("Badger");
  const BadgerWorldArtifact = artifacts.readArtifactSync("BadgerWorld");

  fs.writeFileSync(
    contractsDir + "/Badger.json",
    JSON.stringify(BadgerArtifact, null, 2)
  );

  fs.writeFileSync(
    contractsDir + "/BadgerWorld.json",
    JSON.stringify(BadgerWorldArtifact, null, 2)
  );
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
