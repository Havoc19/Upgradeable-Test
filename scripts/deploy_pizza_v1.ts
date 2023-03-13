import { ethers, upgrades } from "hardhat";

const SLICES1 = 8;
const SLICES2 = 9;
// async function main() {
//  const Pizza = await ethers.getContractFactory("Pizza");

//  console.log("Deploying Pizza...");

//  const pizza1 = await upgrades.deployProxy(Pizza, [SLICES1], {
//    initializer: "initialize",
//  });
//  await pizza1.deployed();
//  const pizza2 = await upgrades.deployProxy(Pizza, [SLICES2], {
//   initializer: "initialize",
// });
// await pizza2.deployed();

//  console.log("Pizza deployed to:", pizza1.address);
//  console.log("Pizza deployed to:", pizza2.address);
// }

async function main() {
  const contract = await ethers.getContractFactory("Pizza2");
  const pizzaContract = await contract.deploy();
  await pizzaContract.deployed();
  console.log("Pizza Contract Deployed At : ",pizzaContract.address);

  const contractFactory = await ethers.getContractFactory("PizzaFactory");
  const factoryContract = await contractFactory.deploy(pizzaContract.address);
  await factoryContract.deployed();
  console.log("Pizza Factory Contract Deployed At : ",factoryContract.address);

  // const address = await factoryContract.createPizza(6);
  // console.log("Proxy Address : ",address);
}

main();
