// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../node_modules/hardhat/console.sol";

import "./ERC721.sol";

contract Badger is ERC721 {

    event   BadgerMint(address indexed to, uint256 id);
    event   BadgerBurn(address indexed sender, uint256 id); 

    
    // 1) We need a number to keep track of badger ids, 
    // it will be a uint256 that is incrememnted by 1
    // every time a badger is "minted" to an owner,
    // name this "nonce":
    uint256 public nonce;
    
    // 2) We need to track the badger id owner by an account, 
    // make a mapping where the key is an address and the value is a uint256 below
    // name this "ids":
    mapping(address => uint256)     public ids;

    // 3) Finally, we need to use the badger id to keep track of the actual badgers,
    // make a mapping where the key is the uint256 id and the value is a BadgerToken,
    // name this "badgers":
    mapping(uint256 => BadgerToken) public badgers;


    // Badger token type is made for you, 
    struct BadgerToken {
        string  name;
        uint256 id;
        uint256 level; 
        uint256 xp;
        uint256 wins;
        uint256 losses;
    }

    // 4) Add a constructor below that will be called to set the default valuues
    // of the contract upon deployment. Look up "solidity contructor" for the syntax
    //  4a) In our case, the only default value we need to set is the nonce, which should 
    //      start at 0.

    // Add constructor here


    /*///////////////////////////////////////////////////////////////////
                             BADGER FUNCTIONS                                           
    ///////////////////////////////////////////////////////////////////*/

    /** @notice Creates a level 1 badger object and assigns it to the sender if they dont have a badger */
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
            // name,
            // id, 
            // level,
            // xp,
            // wins,
            // losses
        ); 


        // 4) emit the badger mint event, events should be emitted any time you change values in storage
        emit BadgerMint(
            // address to goes here,
            // id / nonce goes here
        );

    }

    /**
    * @notice Gets and returns a badger object by a given badger id
    */
    function getBadger(uint256 _badgerId) 
    external view returns(BadgerToken) {
        // 1) return badgers of _badgerId
    }


    /*///////////////////////////////////////////////////////////////////
                             INTERNAL MINT & BURN                                            
    ///////////////////////////////////////////////////////////////////*/

    
    /**
    * @dev Removes token reference from sender and sets senders # of tokens to 0
    * @notice dont forget to revoke approvals here as well after implementing approve.
    *         but save that for later
    */
    function _burn(uint256 _tokenId) internal override {
        
        emit BadgerBurn();
    }



    /*///////////////////////////////////////////////////////////////////
                             XP CALCULATIONS                                           
    ///////////////////////////////////////////////////////////////////*/

    // We will do these next week 

    // 
    function _calculateXp(uint8 _level) public view returns(uint8) {

    }


    // 
    function _increaseXp(uint256 _badgerId, uint8 _newXp) internal {

    }


    //
    function _decreaseXp(uint256 id, uint8 _lostXp) internal {

    }


    // 
    function _levelUp(uint256 id) private {

    }
    

}