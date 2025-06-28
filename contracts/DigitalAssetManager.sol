// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DigitalAssetManager {
    
    // Structure to store digital asset information
    struct DigitalAsset {
        uint256 assetId;
        string name;
        string description;
        string assetHash; // Cryptographic hash of the asset
        address owner;
        uint256 timestamp;
        bool exists;
    }
    
    // Structure to store asset transfer history
    struct Transfer {
        address from;
        address to;
        uint256 timestamp;
        string reason;
    }
    
    // Mappings
    mapping(uint256 => DigitalAsset) public assets;
    mapping(uint256 => Transfer[]) public transferHistory;
    mapping(address => uint256[]) public userAssets;
    
    // State variables
    uint256 public totalAssets;
    address public owner;
    
    // Events
    event AssetRegistered(uint256 indexed assetId, string name, address indexed owner);
    event AssetTransferred(uint256 indexed assetId, address indexed from, address indexed to);
    event AssetVerified(uint256 indexed assetId, bool isValid);
    
    // Modifiers
    modifier onlyAssetOwner(uint256 _assetId) {
        require(assets[_assetId].owner == msg.sender, "Not the asset owner");
        _;
    }
    
    modifier assetExists(uint256 _assetId) {
        require(assets[_assetId].exists, "Asset does not exist");
        _;
    }
    
    constructor() {
        owner = msg.sender;
        totalAssets = 0;
    }
    
    // Register a new digital asset
    function registerAsset(
        string memory _name,
        string memory _description,
        string memory _assetHash
    ) public returns (uint256) {
        totalAssets++;
        uint256 newAssetId = totalAssets;
        
        assets[newAssetId] = DigitalAsset({
            assetId: newAssetId,
            name: _name,
            description: _description,
            assetHash: _assetHash,
            owner: msg.sender,
            timestamp: block.timestamp,
            exists: true
        });
        
        userAssets[msg.sender].push(newAssetId);
        
        emit AssetRegistered(newAssetId, _name, msg.sender);
        return newAssetId;
    }
    
    // Transfer asset ownership
    function transferAsset(
        uint256 _assetId,
        address _newOwner,
        string memory _reason
    ) public onlyAssetOwner(_assetId) assetExists(_assetId) {
        require(_newOwner != address(0), "Invalid new owner address");
        require(_newOwner != msg.sender, "Cannot transfer to yourself");
        
        address previousOwner = assets[_assetId].owner;
        assets[_assetId].owner = _newOwner;
        
        // Update user assets mappings
        removeAssetFromUser(previousOwner, _assetId);
        userAssets[_newOwner].push(_assetId);
        
        // Record transfer history
        transferHistory[_assetId].push(Transfer({
            from: previousOwner,
            to: _newOwner,
            timestamp: block.timestamp,
            reason: _reason
        }));
        
        emit AssetTransferred(_assetId, previousOwner, _newOwner);
    }
    
    // Verify asset integrity
    function verifyAssetIntegrity(uint256 _assetId, string memory _providedHash) 
        public 
        view 
        assetExists(_assetId) 
        returns (bool) {
        return keccak256(abi.encodePacked(assets[_assetId].assetHash)) == 
               keccak256(abi.encodePacked(_providedHash));
    }
    
    // Get asset details
    function getAssetDetails(uint256 _assetId) 
        public 
        view 
        assetExists(_assetId) 
        returns (
            uint256 assetId,
            string memory name,
            string memory description,
            string memory assetHash,
            address assetOwner,
            uint256 timestamp
        ) {
        DigitalAsset memory asset = assets[_assetId];
        return (
            asset.assetId,
            asset.name,
            asset.description,
            asset.assetHash,
            asset.owner,
            asset.timestamp
        );
    }
    
    // Get user's assets
    function getUserAssets(address _user) public view returns (uint256[] memory) {
        return userAssets[_user];
    }
    
    // Get transfer history for an asset
    function getTransferHistory(uint256 _assetId) 
        public 
        view 
        assetExists(_assetId) 
        returns (Transfer[] memory) {
        return transferHistory[_assetId];
    }
    
    // Helper function to remove asset from user's list
    function removeAssetFromUser(address _user, uint256 _assetId) private {
        uint256[] storage userAssetList = userAssets[_user];
        for (uint256 i = 0; i < userAssetList.length; i++) {
            if (userAssetList[i] == _assetId) {
                userAssetList[i] = userAssetList[userAssetList.length - 1];
                userAssetList.pop();
                break;
            }
        }
    }
    
    // Emergency function to get total supply
    function getTotalAssets() public view returns (uint256) {
        return totalAssets;
    }
    
    // Check if asset exists
    function assetExistsCheck(uint256 _assetId) public view returns (bool) {
        return assets[_assetId].exists;
    }
}
