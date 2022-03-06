// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../node_modules/hardhat/console.sol";
import "./Badger.sol";

/**
 * @notice this contract implements the game functions on Badger.sol outlined in README.md
 */
contract BadgerWorld is Badger {

    // Global variables

    // randNonce increases by 1 everytime we use it to calculate a random number
    // Note: this is psuedorandom and is not perfect, but it is okay for our use
    uint256 randNonce = 0;

    // This is the default win probability when a badger attacks another badger
    // we add onto it if the level is higher
    // In theory a higher level badger should win more often
    uint8 winProbability = 50;  


    /*///////////////////////////////////////////////////////////////////
                          GAME MECHANIC FUCNTIONS                                           
    ///////////////////////////////////////////////////////////////////*/


    /**
     * @notice this function allows a Badger to claim daily xp
     *      Logic:
     *          if < 24 hours have passed, Badger must wait for reward
     *          if >= 24 hours have passed, xp is claimed
     *          if > 48 hours have passed, reward bonus returns to 0
     *
     * @param _badgerId is the badger who is claiming the reward
     */
    function claimDailyXp(uint256 _badgerId) external onlyOwnerOf(_badgerId) {
        // 1) grab variables that are going to be used often
        //    ie, the BadgerToken and timestamp
        // Note: we are going to be using the readyFor... variables in BadgerToken

        require(/* 2) require that you must wait 24 hours from the last reward*/, "You must wait 24 hours since the last time.");

        if (/* 3) write if statement for wait between 24-48 hrs*/) {
            // Now increase the daily reward

            uint8 _days; // local variable to make this easier to implement

            // 4) use an if statement to check the _badger.daily Streak and set it to _days
            //    If the streak is over maxStreak you can default _days to maxStreak

            // 5) Calculate the xp reward using _calculateXpReward()
            
            // 6) increase the badger's xp and daily streak

        } else {
            // missed daily reward bonus
            // 7) default badger's daily reward to 1
            //    calculate and increase the badger's xp reward with 1 day
        }

        // 8) reset the badger's readyForReward by (stamp + xpCooldown)
    }

    
    /**
     * @notice functionality for attacking other Badgers once every 12 HOURS
     *
     * @param _attackId is the BadgerToken id that is attacking
     * @param _defenseId is the BadgerToken being attacked (on defense)
     */
    function attackBadger(uint256 _attackId, uint256 _defenseId) external onlyOwnerOf(_attackId) {
        // Note: the rest of these functions take a similar structure to the one above

        // 1) grab BadgerToken's of both ids and store on chain (ie, storage variables)

        require(/* 2) ensure that the attacking badger can attack once ever 12 hours */, "Can attack once every 12 hours.");

        // Calculate the win probability by adding the level to winProbability
        // Attack badger has _winChance % liklihood to win
        uint8 _winChance = uint8(winProbability + _attackBadger.level);

        // 3) get a random number from 1-100 using _randomizer()

        // Picking the winner based off the random number
        if (_randNum < _winChance) {
            // attacking Badger wins

            // 4) increase wins and increase losses for badgers

            // 5) increase the xp for the attacking badger by _calculateXpReward(level)
        
        } else {
            // attacking badger loses

            // 6) increase wins and loses correctly

            // 7) if the defending badger wins increase its xp by the amount the attacking
            //    badger would have won.
        }

        // 8) reset attacking badger readyForAttack like the above method
    }


    /**
     * @notice this function simulates a coin flip by using _randomizer(2)
     *      Logic:
     *          The owner can bet their xp on a coin flip once every HOUR
     *          If they win, they double their xp
     *          If they lose, they lose _xpBet/2 
     *
     * @param _badgerId is the Badger making the coin flip bet
     * @param _xpBet is the xp bet. Can ONLY bet as much as they have for that level.
     * @param _guess is either 0 (heads) or 1(tails)
     */
    function coinFlip(uint256 _badgerId, uint8 _xpBet, uint256 _guess) external onlyOwnerOf(_badgerId) {  
        require(/* 1) add statement that follows the string to the right */, "Must wait 1 hour between coinflips.");
        require(/* 2)  statement that follows the string to the right */, "You cannot bet more XP than you have.");

        // 3) simiulate a coin flip using _randomizer
        uint256 randNum = /* call function */;

        
        if (/* 4) Check if the randNum equals the guess*/) {

            // won coin flip
            // 5) increase _badgerId xp by the bet

        } else {

            // lost coinflip
            // 6) decrease the _badgerId xp by the bet/2

        }

        // reset coin flip clock
        badgers[_badgerId].readyForCoinFlip = block.timestamp + flipCooldown;
    }


    /**
     * @notice This function will give a Badger an xp reward or possibly hurt their xp
     *      Logic:
     *          An xp reward is much more likely (90% chance)
     *          (+) reward = level*rewardMultiplier + 20
     *          (-) reward = level + 20
     *
     * @param _badgerId is the Badger calling this function
     */
    function talkToBucky(uint256 _badgerId) external onlyOwnerOf(_badgerId) {
        // Challenge function: Try it yourself following the function spec
        
        // get random number to figure out if reward is positive or negative

        // reset readyForBuckyReward
    }


    /*///////////////////////////////////////////////////////////////////
                            HELPER FUNCTIONS                                           
    ///////////////////////////////////////////////////////////////////*/


    /**
     * @notice generates a random number from [0-_mod]
     *
     * @param _mod is the max number you could get from the function
     */
    function _randomizer(uint256 _mod) private returns(uint256) {
        // 1) increase the nonce by 1
        // we are providing the other statement, because we just copied it, lol'

        return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender, randNonce))) % _mod;
    }


    /**
     * @notice calculates the xp reward with different values
     *      reward = _multiplier^rewardFactor + 50
     *
     * @param _multiplier is the factor that dictates the reward
     */
    function _calculateXpReward(uint8 _multiplier) private view returns(uint8) {
        // 1) do the calculation outlined in the fucntion spec
    }


}
