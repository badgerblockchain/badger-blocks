# Badger Blocks

Development curriculum dapp skeleton used for Spring of 2022. This dapp will be a game that is more for learning solidity than the actual functioning of the game. 


## Description   

The **goal** of the game is to level up your badger to a given level as fsat as you can! The contracts in this game will outline the game and badger character (NFT) mechanics.  
- Badgers will be setup as ERC721 contracts, and will exhibit the following characteristics:
  - Start at level 1 and move up to level 20 (potentially chose something else)
  - Badgers level up after reaching a certain amount of xp
    - xp required to level up begins at a small amount and increases as the user levels up. calculation: xp = level^3 + 100
  - Only 1 Badger is allowed per wallet at a time. In order to have another Badger associated with a wallet is to finish the game and restart.
  - Players will name their badger when it is minted.
  - Subject to change as we build this out
- Within the game Badgers can interact with the environment and other players.
- PvE game characteristics:
  - Players can interact their badger with Bucky who acts as a "genie" who gives players treasures or useless items. The randomness will need to be hashed out with an oracle later on, but for now we can use ethereums built-in psuedorandom (not truly random) function.
  - A player can take their badger to an online "casino". This casino will have a few games. 
    - You can bet your xp (from 0 - the amount you have acquired at your given level) and if you win a coin flip you double the xp you bet, otherwise you lose the 1/2 the xp you bet. TODO: figure out how often a player can play this game.
  - Whenever a player logs into the game within each day the badgers xp will increase and the more days in a row you check in the larger the reward. After 10 days the reward hits a ceiling and you cannot keep earning more.
    - The function to determine the xp reward = **daily reward = consecutive_days^2 + 50**
- PvP game characteristics:
  - A player can attack other Badgers with their Badger. The likelihood to win increases as the badger level increases, but the amount of xp gained is less valuable. Badgers with lower levels get less xp, but they need less xp overall to get to higher levels. TODO: hash out the actual mechanics as we get to this part
- Frontend:
  - You can see a list of all the badgers, if you click on one it calls getBadgerInfo() and returns all the attributes about it
  - You can go to a Bucky page and get a treasure from him
  - Another page will have a coin flip
  - Rock paper scissors on another page
  - If you own a badger it will show up on the page
  - every 5 levels a badger changes colors and you can see it on the website
  - can choose from list of badgers and attack them


## Environment Setup  

Please refer to the [introductory guide](https://github.com/badgerblockchain/development-guide/blob/main/introduction.md) in the [development guide](https://github.com/badgerblockchain/development-guide) to set up your environment.

TODO

## Author(s)

### Backend/contracts

Dylan Melotik *<dmelotik@wisc.edu>* discord *melodyl#2639* twitter *@dylanmelotik*  
Pat Stiles *<pdstiles@wisc.edu>* discord *pstylez78#4758*  
Jared Blinken *<blinken@wisc.edu>* discord *jmb#2223*

### Frontend

Yuheng Chen *<TODO:email>* discord *TonyYC#6410*
