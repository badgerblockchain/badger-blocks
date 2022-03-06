// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../node_modules/hardhat/console.sol";

/**
 * @notice this contract outlines a Badger NFT's attributes and mint/burn mechanics
 */
contract Badger {


    // Events are logging mechanisms that log in a transactions logs on chain
    // Learn more here: https://www.tutorialspoint.com/solidity/solidity_events.htm
    event   BadgerMint(address indexed to, uint256 badgerId);
    event   BadgerBurn(address indexed sender, uint256 badgerId);

    // 1) balanceOf tracks the number of BadgerTokens each
    //    wallet address owns. This should be at most 1.
    mapping(address => uint256)     public balanceOf; // number of Badger NFTs per address

    // 2) We need to track the badger id owner by an account, 
    // make a mapping where the key is an address and the value is a uint256 below
    // name this "ids":
    mapping(uint256 => address)     public ownerOfId; // maps a badgerId/nonce to owner

    // 3) Finally, we need to use the badger id to keep track of the actual badgers,
    // make a mapping where the key is the uint256 id and the value is a BadgerToken,
    // name this "badgers":
    mapping(uint256 => BadgerToken) public badgers;   // maps a badgerId to a badger


    // global vars
    // Optional: could make functions to chnage (allow only a single wallet to do so)
    // used to calculate xp/level mechanism
    uint8   xpFactor     = 3;
    uint8   maxStreak    = 20;
    uint8   rewardFactor = 2;
    uint8   maxLevel     = 20;
    
    // global vars
    // Optional: can do the same as the above
    // that would change the game functioning
    // time between each interaction
    uint256 xpCooldown     = 1 days;
    uint256 attackCooldown = 12 hours;
    uint256 flipCooldown   = 1 hours;
    uint256 buckyCooldown  = 4 hours;
    
    
    // 4) We need a number to keep track of badger ids, 
    // it will be a uint256 that is incrememnted by 1
    // every time a badger is "minted" to an owner,
    // name this "nonce":
    uint256 nonce;

    
    // 5)   This struct stores all of the on-chain data
    //      for a badger. Right now the variables in the struct
    //      are not "packed".
    //  Challenge: Pack this struct by changing the order up
    //  Learn about struct packing: https://dev.to/javier123454321/solidity-gas-optimizations-pt-3-packing-structs-23f4
    struct BadgerToken {
        uint8   level;
        uint256 readyForCoinFlip; // the time that the badger can do the next coinFlip
        uint8   xp;
        string  name;
        uint8   dailyStreak;
        uint256 readyForReward;
        uint256 readyForAttack;
        uint8   wins;
        uint8   losses;
        uint256 readyForBuckyReward;
    }


    /* Function modifier to allow only badger owners to call certain functions */
    modifier onlyOwnerOf(uint256 _badgerId) {
		require(msg.sender == ownerOfId[_badgerId]);
        _;
	}


    // 4) Add a constructor below that will be called to set the default valuues
    // of the contract upon deployment. Look up "solidity contructor" for the syntax
    //  4a) In our case, the only default value we need to set is the nonce, which should 
    //      start at 0.

    // Add constructor here


    /*///////////////////////////////////////////////////////////////////
                             BADGER FUNCTIONS                                           
    ///////////////////////////////////////////////////////////////////*/


    /**
    * @notice mints (aka creates) a level 1 badger
    *
    * @param name is the name an owner gives their badger
    */
    function createBadger(address to, string memory name) public {
        // 1) we need to make sure address to doesnt already have a badger,
        // require that ids of sender is the default value (0),
        // ensuring they dont have one already:
        require(//statement goes here);

        // 2) Increase the nonce by 1, this will now be the id of the badger being minted:
        // here

        // 3) set 'badgers' of this nonce to a new BadgerToken with default values you think makess sense
        // i.e. 1 for level etc. 
        badgers[nonce] = BadgerToken(
            // declare all of the vars inside of the Badger struct
            // Note: they must be in the same order as BadgerToken
        ); 


        // 4) emit the badger mint event, events should be emitted any time you change values in storage
        emit BadgerMint(
            // address to goes here,
            // id / nonce goes here
        );

    }


    /**
     * @notice grabs a BadgerToken for frontend to read
     *
     * @param _badgerId is the unique Badger identifier
     */
    function getBadger(uint256 _badgerId) external view returns( BadgerToken memory ) {
        // here you will return the BadgerToken given the _badgerId
    }


    /*///////////////////////////////////////////////////////////////////
                             INTERNAL BURN                                            
    ///////////////////////////////////////////////////////////////////*/


    /**
     * @notice burns a BadgerToken (aka, unassigns it and transfers ownership)
     *
     * @param _badgerId is the unique id being burned
     */
    function _burn(uint256 _badgerId) internal {
        // Note: the null address is:
        // '0x0000000000000000000000000000000000000000'
        // or '0x0' or address(0) < Use that one

        require(/* 1) Check if the _badgerId has been minted/associated with a wallet yet*/);

        // 2) Update THE balanceOf and ownerOfId mappings for _badgerId

        emit BadgerBurn(/* fill in the proper variables outlined in the BadgerBurn event*/);
    }


    /*///////////////////////////////////////////////////////////////////
                             XP CALCULATIONS                                           
    ///////////////////////////////////////////////////////////////////*/


    /**
     * @notice calculates the max xp for a given level based on level
     *      max xp = _level^xpFactor + 100
     *
     * @param _level is the level we are using to calculate [1-maxLevel]
     */
    function _calculateXp(uint8 _level) private view returns(uint8) {
        // 1) Here you want to run the calculation and return the outpu as a uint8
        //    as declared in the function header
        // Note: the power of operator exists in solidity, but it can easily be overflowed
        //       Since our level only goes up to 20 we are safe, but don't forget that
        //       https://ethereum.stackexchange.com/a/10476
    }


    /**
     * @notice increases a badgers xp and takes care of xp "overflow" onto next level(s)
     *
     * @param _newXp is the amount of xp being added to _badgerId
     */
    function _increaseXp(uint256 _badgerId, uint8 _newXp) internal {
        // 1) Grab a _badgerId's current level and xp
        // Note: local variables always start with an underscore
        uint8 _badgerLvl   = /* Figure out how to grab this using a mapping */;
        uint8 _badgerXp    = /* Figure out how to grab this using a mapping */;

        // 2) use a while loop to allow for xp to overflow to the next level
        while ((_badgerXp + _newXp) >= _calculateXp(_badgerLvl)) {
            // update _badgerXp and level
            // Note: you may want to define a new variable here to check for any excess xp
            // Hint: look at the master branch if you are having trouble
        }

        // 3) Lastly, update the xp of _badgerId
    }


    /**
     * @notice decreases a Badger's xp where it cannot drop a level
     *
     * @param _lostXp is the amount of xp being subtracted from _badgerId
     */
    function _decreaseXp(uint256 _badgerId, uint8 _lostXp) internal {
        // 1) Use an if statement to catch any _lostXp that would make _badgerId drop a level
        //    If this happens drop the _badgerId's xp to 0
        
        // 2) Update the _badgerId's xp 
        
        // Note: no return statement is needed
    }


    /**
     * @notice increases a Badger's level and burns the Badger when maxLevel is reached
     *
     * @param _badgerId is the badger to increase level
     */
    function _levelUp(uint256 _badgerId) private {
        // 1) simply increase _badgerId's level by 1.
        // Note: you can add one into solidity like this: variable++
        // Before solidity 0.8.0 you had to use a math library to prevent overflow

        // 2) check if _badgerId's level is higher than maxLevel
        //    If this is true burn that _badgerId
    }

    // Optional:
    // TODO: write functions to change bag size and max level and reward time
    // This is apart of the upgradability aspect of the contracts
    // Implement later on


}
