

#  Voting System Smart Contract
A Proof of Concept (POC) blockchain-based voting system that provides secure, time-based voting using Solidity and Hardhat.

## Features
- Voting start and end time logic
- Candidate vote tracking
- Event emission for vote activity
- Prevents double voting

## How to Use
1. Clone the repo
2. Run `npm install`
3. Configure `hardhat.config.js`
4. Use Hardhat test or deploy scripts

## Tech Stack
- Solidity
- Hardhat
- Ganache (for local testing)


## Getting Started

### Prerequisites
- Node.js
- Hardhat
- Ganache (or any local Ethereum node)


---

### Installation

```bash
git clone https://github.com/EtomCoda/Voting-System-Smart-Contract.git
cd Voting-System-Smart-Contract
npm install
```

### Compile the Contract

```bash
npx hardhat compile
```

### Test the Contract

```bash
npx hardhat test
```

### Deploy the Contract

```bash
npx hardhat run scripts/deploy.js --network localhost
```

---

## 📄 Contract Overview

### Functions

- `addCandidate(string _name)`: Add a candidate
- `vote(uint _candidateId)`: Cast a vote
- `getVoteCount(uint _candidateId)`: View vote tally
- `setVotingPeriod(uint _start, uint _end)`: Set voting window

### Modifiers

- Only allows voting during active time window
- Prevents double voting by tracking voter addresses

### Events

- `Voted(address indexed voter, uint indexed candidateId)`
- `VotingTimeChecked(bool votingOpen)`

---

## 🧠 Project Notes

> This project is a **Proof of Concept (POC)**.

### Limitations

- ❌ No voter identity verification
- ❌ No Sybil attack prevention
- ❌ No frontend/UI
- ❌ Not audited or gas-optimized

---

## 📁 Folder Structure

```
📁 contracts/
    └── Voting.sol
📁 scripts/
    └── deploy.js
📁 test/
    └── Voting.test.js
📄 README.md
```

---

## ✅ To-Do

- [ ] Add more Hardhat test cases
- [ ] Improve contract modularity and comments
- [ ] Integrate frontend using Ethers.js + React
- [ ] Deploy to a testnet (e.g. Sepolia, Goerli)

---

## 📃 License

MIT

---

## 🤝 Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you’d like to change.

---

## 🙋‍♂️ Author

Made with 💡 by [EtomCoda](https://github.com/EtomCoda)


---
