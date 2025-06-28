# Digital Asset Management System

## Overview
A blockchain-based digital asset management system built on Ethereum that provides secure registration, ownership tracking, and integrity verification of digital assets.

## Project Structure
```
DigitalAssetProject/
├── contracts/
│   └── DigitalAssetManager.sol    # Main smart contract
├── frontend/
│   └── index.html                 # Web interface
├── README.md                      # This file
└── ProjectReport.pdf              # Detailed project report
```

## Smart Contract Details
- **Network:** Sepolia Testnet
- **Contract Address:** `0xcad89FDb65a21625F8C963546dD67b6dCC3e9AD7`
- **Compiler Version:** Solidity ^0.8.0
- **Development Environment:** Remix IDE

## Features Implemented

### Digital Asset Registration
- Register digital assets with metadata (name, description, hash)
- Immutable storage on Ethereum blockchain
- Automatic timestamp and ownership assignment

### Ownership Management
- Secure ownership tracking
- Transfer capabilities with history logging
- Owner-only access controls

### Asset Integrity Verification
- Cryptographic hash verification
- Tamper detection mechanisms
- Authenticity validation

### User Interface
- Web-based frontend for easy interaction
- MetaMask integration for wallet connectivity
- Real-time transaction monitoring

## Setup Instructions

### Prerequisites
- MetaMask browser extension
- Sepolia testnet ETH (from faucet)
- Modern web browser

### Deployment Steps
1. **Compile Contract:**
   - Open Remix IDE
   - Load `DigitalAssetManager.sol`
   - Compile with Solidity ^0.8.0

2. **Deploy to Sepolia:**
   - Connect MetaMask to Sepolia testnet
   - Deploy contract via Remix
   - Save contract address and ABI

3. **Configure Frontend:**
   - Update `index.html` with contract address
   - Add contract ABI to JavaScript
   - Test web interface

### Usage
1. **Connect Wallet:** Click "Connect MetaMask Wallet"
2. **Register Asset:** Fill in asset details and submit
3. **Manage Assets:** View, transfer, and verify your assets
4. **Verify Integrity:** Check asset authenticity using hash verification

## Smart Contract Functions

### Core Functions
- `registerAsset(name, description, hash)` - Register new digital asset
- `transferAsset(assetId, newOwner, reason)` - Transfer ownership
- `verifyAssetIntegrity(assetId, hash)` - Verify asset integrity
- `getAssetDetails(assetId)` - Retrieve asset information
- `getUserAssets(user)` - Get user's asset list

### Security Features
- Owner-only modifiers
- Asset existence validation
- Address validation
- Immutable audit trail

## Testing Results
✅ Contract compilation successful
✅ Deployment to Sepolia testnet completed
✅ Asset registration functionality verified
✅ Ownership transfer mechanism tested
✅ Integrity verification working
✅ Web interface responsive

## Known Issues/Limitations
- Frontend requires manual ABI and address configuration
- Gas optimization could be improved
- Limited to basic asset metadata storage
- No bulk operations support

## Future Enhancements
- IPFS integration for large file storage
- Multi-signature ownership transfers
- Asset marketplace functionality
- Mobile application development
- Advanced search and filtering

## Dependencies
- **Solidity:** ^0.8.0
- **Web3.js:** 1.7.4
- **MetaMask:** Browser extension
- **Remix IDE:** For development and deployment

## Security Considerations
- All state changes are recorded on blockchain
- Ownership changes require cryptographic signatures
- Asset hashes provide tamper evidence
- Smart contract immutability ensures system integrity

## Contact
- Developer: Joshua Alana

## License
This project is for educational purposes as part of cryptocurrency and digital assets coursework.
