async function main() {
    const initialSupply = ethers.utils.parseUnits("1000", 18); // Define o suprimento inicial, aqui 1000 tokens

    // Carrega o contrato
    const NKMT = await ethers.getContractFactory("NKMT");
    
    // Implanta o contrato
    const nkmt = await NKMT.deploy(initialSupply);
    await nkmt.deployed();

    console.log("Contrato NKMT deployado em:", nkmt.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
