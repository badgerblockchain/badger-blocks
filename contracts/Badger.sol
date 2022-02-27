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
    BadgerToken[] public badgers;

    // TODO is this struct packed enough?? 
    struct BadgerToken {

    }



    modifier OnlyOwner(uint256 _badgerId) {

	}

    /*///////////////////////////////////////////////////////////////////
                             BADGER FUNCTIONS                                           
    ///////////////////////////////////////////////////////////////////*/

    // Changed event name 
    // @dev There is a def diff betweren mint and transfer but not in here
    function createBadger(string memory name) external {
 
    }

    /*
        grabs badger info for frontend to see
    */
    function getBadger(uint256 _badgerId) 
    external view returns( uint8 level, uint8 xp, string memory name ) {

    }


    /*///////////////////////////////////////////////////////////////////
                             INTERNAL MINT & BURN                                            
    ///////////////////////////////////////////////////////////////////*/

    //
    function _mint(address _to, uint256 _tokenId) internal override {

    }

    
    //
    function _burn(uint256 _tokenId) internal override {

    }


    /*///////////////////////////////////////////////////////////////////
                             XP CALCULATIONS                                           
    ///////////////////////////////////////////////////////////////////*/

    // changed to public 
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
    


    /*///////////////////////////////////////////////////////////////////
                            ERC721 (NFT) FUNCTIONS                                           
    ///////////////////////////////////////////////////////////////////*/

    function transferFrom(
        address _from,
        address _to, 
        uint256 _tokenId
        ) external override payable {

    }


    function approve(
        address _approved, 
        uint256 _tokenId
        ) public override payable onlyOwnerOf(_tokenId) { 

    }


}