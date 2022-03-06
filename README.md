# Badger Blocks

Master copy of the dapp used for the development curriculum in Spring of '22. This dapp will be a game that is more for learning solidity than the actual functioning of the game. 


## Description   

The **goal** of the game is to level up your badger to a given level as fast as you can! The contracts in this game will outline the game and badger character (NFT) mechanics.  
- Badgers will be setup as erc721 contracts, and will exhibit the following characteristics:
  - Start at level 1 and move up to level 25 (potentially chose something else)
  - Badgers level up after reaching a certain amount of xp
    - xp required to level up begins at a small amount and increases as the user levels up. calculation: level^3 + 100
  - Only 1 Badger is allowed per wallet at a time. In order to have another Badger associated with a wallet is to finish the game and restart.
  - Players will name their badger when it is minted.
  - TODO: this is a good start, maybe this can be added on after the basics of the game is laid out
- Within the game Badgers can interact with the environment and other players.
- PvE game characteristics:
  - Players can interact their badger with Bucky who acts as a genie figure who gives players treasures or useless items. The randomness will need to be hashed out with an oracle later on, but for now we can use ethereums built-in psuedorandom function.
  - A player can take their badger to an online "casino". This casino will have one game. You can bet your xp (from 0 - the amount you have acquired at your given level) and if you win a coin flip (potentially another game) you double the xp you bet, otherwise you lose the xp you bet. You can compete in this game once every 12 hours
  - Whenever a player logs into the game within each day the badgers xp will increase and the more days in a row you check in the larger the reward. After 10 days the reward hits a ceiling and you cannot keep earning more.
- PvP game characteristics:
  - A player can attack other Badgers with their Badger. The likelihood to win increases as the badger level increases, but the amount of xp gained is less valuable. Badgers with lower levels get less xp, but they need less xp overall to get to higher levels. 
    - **daily reward = consecutive_days^2 + 50**
- Frontend:
  - You can see a list of all the badgers, if you click on one it calls getBadgerInfo() and returns all the attributes about it
  - You can go to a Bucky page and get a treasure from him
  - Another page will have a coin flip
  - Rock paper scissors on another page
  - If you own a badger it will show up on the page
  - every 5 levels a badger changes colors and you can see it on the website
  - can choose from list of badgers and attack them


## Enviornment Setup  

Please refer to the [introductory guide](https://github.com/badgerblockchain/development-guide/blob/main/introduction.md) in the [development guide](https://github.com/badgerblockchain/development-guide) to set up your environment.


### Quick and Easy Setup

To download code and install dependencies:
```sh
$ git clone https://github.com/badgerblockchain/badger-blocks.git
$ cd badger-blocks
$ npm install
```

To download dependencies for the frontend:
```sh
$ cd frontend
$ npm install
```

To compile the smart contracts:
```sh
$ cd badger-blocks
$ npx hardhat compile
```

To run smart contract tests:
```sh
$ npx hardhat test
```

To run a local test node and deploy contracts to it:
```sh
$ npx hardhat node

# in another terminal window...
$ npx hardhat run --network localhost scripts/deploy.js
```

To launch the ReactJS frontend:
> You must have already done the above for the contracts to be connected to the frontend
```sh
$ cd frontend
$ npm start
# open http://localhost:3000 in any browser to see
```


## Author(s)

### Backend/contracts

Dylan Melotik *<dmelotik@wisc.edu>* discord *melodyl#2639* twitter *@dylanmelotik*  
Pat Stiles *<pdstiles@wisc.edu>* discord *pstylez78#4758*  
Jared Blinken *<blinken@wisc.edu>* discord *jmb#2223*

### Frontend

Yuheng Chen *<TODO:email>* discord *TonyYC#6410*
