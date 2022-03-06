// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../node_modules/hardhat/console.sol";
import "./Badger.sol";

/*
 * @notice this contract implements the game functions on Badger.sol outlined in README.md
 */
contract BadgerWorld is Badger {

    // Global variables
    uint256 randNonce = 0;
    uint8 winProbability = 50;  


    /*///////////////////////////////////////////////////////////////////
                          GAME MECHANIC FUCNTIONS                                           
    ///////////////////////////////////////////////////////////////////*/


    /*
     * @notice this function allows a Badger to claim daily xp
     *      Logic:
     *          if < 24 hours have passed, Badger must wait for reward
     *          if >= 24 hours have passed, xp is claimed
     *          if > 48 hours have passed, reward bonus returns to 0
     *
     * @param _badgerId is the badger who is claiming the reward
     */
    function claimDailyXp(uint256 _badgerId) external onlyOwnerOf(_badgerId) {
        // get vars we will use often
        BadgerToken memory _badger = badgers[_badgerId];
        uint256 stamp = block.timestamp;

        require(_badger.readyForReward >= stamp, "You must wait 24 hours since the last time.");

        if (_badger.readyForReward <= (block.timestamp + 1 days)) {
            // daily reward + increased bonus

            uint8 _days;

            // calculate reward streak (aka, multiplier)
            if (_badger.dailyStreak > maxStreak) { _days = maxStreak; } 
            else { _days = _badger.dailyStreak; }

            // calculate daily reward (in xp)
            uint8 _newXp = _calculateXpReward(_days);

            _increaseXp(_badgerId, _newXp);
            badgers[_badgerId].dailyStreak++;

        } else {
            // missed daily reward bonus -- back to 1 day sreak
            badgers[_badgerId].dailyStreak = 1;
            _increaseXp(_badgerId, _calculateXpReward(1));
        }

        // reset xp reward clock
        badgers[_badgerId].readyForReward = stamp + xpCooldown;
    }

    
    /*
     * @notice functionality for attacking other Badgers once every 12 HOURS
     *
     * @param _attackId is the BadgerToken id that is attacking
     * @param _defenseId is the BadgerToken being attacked (on defense)
     */
    function attackBadger(uint256 _attackId, uint256 _defenseId) external onlyOwnerOf(_attackId) {
        // store BadgerToken's in storage b/c we are changing on-chain data
        BadgerToken storage _attackBadger = badgers[_attackId];
        BadgerToken storage _defenseBadger = badgers[_defenseId];

        require(_attackBadger.readyForAttack >= block.timestamp, "Can attack once every 12 hours.");

        // win chance increases with level
        uint8 _winChance = uint8(winProbability + _attackBadger.level);

        uint256 _randNum = _randomizer(100); // get random number from 1-100

        // deciding winning Badger
        if (_randNum < _winChance) {
            // attacking Badger wins

            _attackBadger.wins++;
            _defenseBadger.losses++;
            _increaseXp(_attackId, _calculateXpReward(_attackBadger.level));
        
        } else {
            // attacking badger loses

            _attackBadger.losses++;
            _defenseBadger.wins++;

            // if you win when being attacked you get the xp reward that the attacker would've
            _increaseXp(_defenseId, _calculateXpReward(_attackBadger.level));
        }

        // reset attack clock
        _attackBadger.readyForAttack = block.timestamp + attackCooldown;
    }


    /*
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
        require(badgers[_badgerId].readyForCoinFlip >= block.timestamp, "Must wait 1 hour between coinflips.");
        require(_xpBet <= badgers[_badgerId].xp, "You cannot bet more XP than you have.");

        // simulate a coin flip
        uint256 randNum = _randomizer(2);

        if (randNum == _guess) {

            // won coin flip
            _increaseXp(_badgerId, _xpBet);

        } else {

            // lost coinflip
            _decreaseXp(_badgerId, _xpBet/2);

        }

        // reset coin flip clock
        badgers[_badgerId].readyForCoinFlip = block.timestamp + flipCooldown;
    }


    /*
     * @notice This function will give a Badger an xp reward or possibly hurt their xp
     *      Logic:
     *          An xp reward is much more likely (90% chance)
     *          (+) reward = level*rewardMultiplier + 20
     *          (-) reward = level + 20
     *
     * @param _badgerId is the Badger calling this function
     */
    function talkToBucky(uint256 _badgerId) external onlyOwnerOf(_badgerId) {
        BadgerToken memory _badger = badgers[_badgerId];
        
        require(_badger.readyForBuckyReward > block.timestamp, "Must wait 4 hours between talking to bucky.");

        // get random number to figure out if reward is positive or negative
        uint256 randNum = _randomizer(100);

        if (randNum < 90) {
            // (+) reward

            uint256 _rewardMult = _randomizer(5);
            uint8 _newXp = uint8(_badger.level*_rewardMult + 20);
            _increaseXp(_badgerId, _newXp);

        } else {
            // (-) reward

            uint8 _lostXp = uint8(_badger.level + 20);
            _decreaseXp(_badgerId, _lostXp);
        
        }

        // reset bucky cooldown
        badgers[_badgerId].readyForBuckyReward = block.timestamp + buckyCooldown;
    }


    /*///////////////////////////////////////////////////////////////////
                            HELPER FUNCTIONS                                           
    ///////////////////////////////////////////////////////////////////*/


    /*
     * @notice generates a random number from [0-_mod]
     *
     * @param _mod is the max number you could get from the function
     */
    function _randomizer(uint256 _mod) private returns(uint256) {
        randNonce++;
        return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender, randNonce))) % _mod;
    }


    /*
     * @notice calculates the xp reward with different values
     *      reward = _multiplier^rewardFactor + 50
     *
     * @param _multiplier is the factor that dictates the reward
     */
    function _calculateXpReward(uint8 _multiplier) private view returns(uint8) {
        return uint8((_multiplier**rewardFactor) + 50);
    }


}
