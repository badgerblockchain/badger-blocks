// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../node_modules/hardhat/console.sol";

import "./ERC721.sol";

contract Badger is ERC721 {


    event   BadgerMint(uint256 id, string name);
    event   BadgerBurn(address indexed sender, uint256 id); // TODO: implement
    event   Winner(uint256 place);

    
    
    // used to calculate xp mechanism

        
    // time between each interaction

    // level and bag info 

    
    // All badger tokens in game

  
    struct BadgerToken {

    }



    /*///////////////////////////////////////////////////////////////////
                             BADGER FUNCTIONS                                           
    ///////////////////////////////////////////////////////////////////*/

    /**
    * @notice Creates a level 0 badger object and assigns it to the sender if they dont have a badger    
    */
    function createBadger(string memory name) external {
        
    }

    /**
    * @notice Gets and returns a badger object by a given badger id
    */
    function getBadger(uint256 _badgerId) 
    external view returns(  ) {

    }


    /*///////////////////////////////////////////////////////////////////
                             INTERNAL MINT & BURN                                            
    ///////////////////////////////////////////////////////////////////*/

    /**
    * @notice Creates the new basdger and assigns it to the sender 
    */
    function _mint(address _to, uint256 _tokenId) internal override {

    }

    
    /**
    * @notice Removes the token, effectively deleting it 
    */
    function _burn(uint256 _tokenId) internal override {

    }


    /*///////////////////////////////////////////////////////////////////
                            ERC721 (NFT) FUNCTIONS                                           
    ///////////////////////////////////////////////////////////////////*/


    /**
    * @\
    * @notice Assign a badger to a new owner, can be called by the current owner or someone they delegated to
    */
    function transferFrom(
        address _from,
        address _to, 
        uint256 _tokenId
        ) external override payable {

    }


    function approve(
        address _approved, 
        uint256 _tokenId
        ) public override payable (_tokenId) { 

    }


    /*///////////////////////////////////////////////////////////////////
                             XP CALCULATIONS                                           
    ///////////////////////////////////////////////////////////////////*/

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