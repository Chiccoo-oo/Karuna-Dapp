Karuna: A Transparent Charity Dapp
Karuna (करुणा) is a decentralized application (dApp) built on the Stacks blockchain. Its purpose is to bring a new level of trust and transparency to charitable giving by leveraging the immutable and public nature of blockchain technology.

The name "Karuna" is a Sanskrit word meaning compassion and mercy, reflecting the project's core mission.

🌟 Project Overview
Karuna solves the problem of opacity in charitable donations. By operating on the Stacks blockchain, every donation is recorded as a public, verifiable, and permanent transaction. Donors can see exactly where their contributions are going, and organizations can prove that funds were received and accounted for.

✨ Features
Transparent Donations: All donations are recorded on the Stacks Testnet, making them publicly visible and immutable.

Traceable Funds: Funds are sent directly from the donor's wallet to a designated address, eliminating intermediaries.

Live Project Status: Anyone can view the total amount raised for any project by querying the smart contract, ensuring real-time transparency.

⚙️ Technical Stack
Blockchain: Stacks (Layer 2 on Bitcoin)

Smart Contract Language: Clarity

Frontend: HTML, CSS (Tailwind CSS), and JavaScript

Blockchain Libraries: @stacks/connect, @stacks/transactions

Local Development: Clarinet CLI

🚀 How to Run the Project Locally
This project requires a few prerequisites to run and interact with the Stacks Testnet.

Prerequisites
Clarinet: The Stacks CLI for smart contract development.

Node.js & npm: For running a local web server.

Leather Wallet: A browser extension wallet configured for the Stacks Testnet.

Testnet STX: You will need a small amount of Testnet STX for transaction fees, which can be acquired from a public faucet.

Step-by-Step Instructions
Clone the Repository

git clone https://github.com/your-username/Karuna-Dapp.git
cd Karuna-Dapp

Deploy the Smart Contract
The smart contract must be deployed to the Stacks Testnet to get a unique contract address.

First, open contracts/karuna.clar and replace the placeholder admin-address with your own Stacks Testnet address.

Then, run the following command to generate and apply the deployment plan:

clarinet deployments apply --network testnet

Your Leather Wallet will prompt you to confirm the transaction. Once deployed, the terminal will provide you with the contract's public address (e.g., ST...karuna).

Update the Frontend

Open index.html in a text editor.

Find the CONTRACT_ADDRESS constant in the <script> tag.

Replace the placeholder address with the address you got from the deployment.

Run the Local Web Server

In your terminal, navigate to the project's root directory.

If you haven't already, run npm install http-server to install the local server.

Start the server with:

npm start

Open your web browser and navigate to http://localhost:8000.

