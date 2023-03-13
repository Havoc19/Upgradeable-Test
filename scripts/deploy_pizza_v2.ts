import { ethers, upgrades } from "hardhat";

const proxy1 = "0x78F90543DB33FC4aaC6573C2BC95f624f62cA783";
const proxy2 = "0xa2E794c0Ef3E54DDbc7962B2a1Cdf5A65A2f4D9A";


async function main() {
 const PizzaV2 = await ethers.getContractFactory("Pizza2");
 const pizzaContract = await PizzaV2.deploy();
  await pizzaContract.deployed();
  console.log("Pizza Contract Deployed At : ",pizzaContract.address);
}

main();