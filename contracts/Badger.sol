// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../node_modules/hardhat/console.sol";

/*
 * @notice this contract outlines a Badger NFT's attributes and mint/burn mechanics
 */
contract Badger {

    event   BadgerMint(address indexed to, uint256 badgerId);
    event   BadgerBurn(address indexed sender, uint256 badgerId);

    // mappings to keep track of Badger NFT info
    mapping(address => uint256)     public balanceOf; // number of Badger NFTs per address
    mapping(uint256 => address)     public ownerOfId; // maps a badgerId/nonce to owner
    mapping(uint256 => BadgerToken) public badgers;   // maps a badgerId to a badger

    
    // used to calculate xp/level mechanism
    uint8   xpFactor     = 3;
    uint8   maxStreak    = 20;
    uint8   rewardFactor = 2;
    uint8   maxLevel     = 20;
    
    // time between each interaction
    uint256 xpCooldown     = 1 days;
    uint256 attackCooldown = 12 hours;
    uint256 flipCooldown   = 1 hours;
    uint256 buckyCooldown  = 4 hours;
    
    // keep track of next badgerId
    uint256 nonce;
    
    // Badger struct to keep track of a Badger's data
    struct BadgerToken {
        uint8   level;
        uint8   xp;
        uint8   wins;
        uint8   losses;
        uint8   dailyStreak;
        string  name;
        uint256 readyForReward;
        uint256 readyForAttack;
        uint256 readyForCoinFlip;
        uint256 readyForBuckyReward;
    }


    /* Function modifier to allow only badger owners to call certain functions */
    modifier onlyOwnerOf(uint256 _badgerId) {
		require(msg.sender == ownerOfId[_badgerId]);
        _;
	}


    // constructor to initialize nonce
    constructor() {
        nonce = 0;
    }


    /*///////////////////////////////////////////////////////////////////
                             BADGER FUNCTIONS                                           
    ///////////////////////////////////////////////////////////////////*/


    /*
    * @notice mints (aka creates) a Badger NFT
    *
    * @param name is the name an owner gives their badger
    */
    function createBadger(string memory name) external {
        require(balanceOf[msg.sender] == 0, "1_BADGER_ONLY");

        nonce++; // increase nonce first

        uint256 stamp = block.timestamp;

        badgers[nonce] = BadgerToken(
            1, 0, 0, 0, 0,
            name,
            stamp, stamp, stamp, stamp
        );

        // write to other mappings
        balanceOf[msg.sender]++;
        ownerOfId[nonce] = msg.sender;

        emit BadgerMint(msg.sender, nonce);
    }


    /*
     * @notice grabs a BadgerToken for frontend to read
     *
     * @param _badgerId is the unique Badger identifier
     * @dev can you return a struct??
     */
    function getBadger(uint256 _badgerId) external view returns( BadgerToken memory ) {
        return badgers[_badgerId]; 
    }


    /*///////////////////////////////////////////////////////////////////
                             INTERNAL BURN                                            
    ///////////////////////////////////////////////////////////////////*/


    /*
     * @notice burns a BadgerToken
     *
     * @param _badgerId is the unique id being burned
     */
    function _burn(uint256 _badgerId) internal {
        require(ownerOfId[_badgerId] != address(0), "Not minted.");

        balanceOf[ownerOfId[_badgerId]]--;
        ownerOfId[_badgerId] = address(0);

        emit BadgerBurn(ownerOfId[_badgerId], _badgerId);
    }


    /*///////////////////////////////////////////////////////////////////
                             XP CALCULATIONS                                           
    ///////////////////////////////////////////////////////////////////*/


    /*
     * @notice calculates the max xp for a given level based on level
     *      max xp = _level^xpFactor + 100
     *
     * @param _level is the level we are using to calculate [1-maxLevel]
     */
    function _calculateXp(uint8 _level) private view returns(uint8) {
        return uint8((_level**xpFactor) + 100); // @dev https://ethereum.stackexchange.com/a/10476 easy to overflow, though
    }


    /*
     * @notice increases a badgers xp and takes care of xp "overflow" onto next level(s)
     *
     * @param _newXp is the amount of xp being added to _badgerId
     */
    function _increaseXp(uint256 _badgerId, uint8 _newXp) internal {
        uint8 _badgerLvl   = badgers[_badgerId].level;
        uint8 _badgerXp    = badgers[_badgerId].xp;

        // @dev we should test this alot
        while ((_badgerXp + _newXp) >= _calculateXp(_badgerLvl)) {
            // update _badgerXp and level
            uint8 _excessXp = uint8(_badgerXp + _newXp - _calculateXp(_badgerLvl));
            _levelUp(_badgerId);
            _newXp = _excessXp;
            _badgerXp = 0;
        }

        // update xp of badger
        badgers[_badgerId].xp = _newXp;
    }


    /*
     * @notice decreases a Badger's xp with a minimum being 0
     *
     * @param _lostXp is the amount of xp being subtracted from _badgerId
     */
    function _decreaseXp(uint256 _badgerId, uint8 _lostXp) internal {
        // catch catch _lostXp going below 0 
        if (badgers[_badgerId].xp <= _lostXp) { badgers[_badgerId].xp = 0; }

        badgers[_badgerId].xp = uint8(badgers[_badgerId].xp - _lostXp);
    }


    /*
     * @notice increases a Badger's level and burns the Badger when maxLevel is reached
     *
     * @param _badgerId is the badger to increase level
     */
    function _levelUp(uint256 _badgerId) private {
        badgers[_badgerId].level++;

        // burn token if max level is reached
        if (badgers[_badgerId].level > maxLevel) {
            _burn(_badgerId);
        }
    }


    // TODO: write functions to change bag size and max level and reward time
    // This is apart of the upgradability aspect of the contracts
    // Implement later on


}
