import { ethers, upgrades } from "hardhat";

const proxy = "0xD676DCCb61d3a68605972D2F9Fe88F5bD117F084";


async function main() {
  // const Pizza1 = await ethers.getContractFactory("Pizza");
 const PizzaV2 = await ethers.getContractFactory("Pizza3");
 const pizzaContract = await PizzaV2.deploy();
  await pizzaContract.deployed();
  console.log("Pizza Contract Deployed At : ",pizzaContract.address);
}

main();