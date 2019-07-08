# Notes

## Ideas

- [x] re-factor all the contracts into truffle projects
- [] once I get to the advanced solidity lessons, start the testing course and start creating tests for past projects

## Log

### 04/07/19

Today I feel like I have got over that absolute novice stage. I am comfortable reading solidity and with the syntax, also feel comfortable using truffle to create migrations and migrating to a local chain. Today I start working on the DAO contract, this is quite exciting for me as the primary reason for me undertaking this is my interest in DAOs and Aragon. IDE So far i've been following along with the tutorials and sometimes trying to create the contracts before watching all the videos on a topic. I've had a look at the final .sol file and i recognise some patterns ive worked with before, ie how to keep track of voters, and the multisig pattern. i feel like i probably could write the contract on my own now (of course it would still suck!). it is tempting to take some time out and give it a go, but im going to push forward. The whole idea of this 30 day thing is to get as much done in the time as possible, after July i can take my time and fill in the gaps.

UPDATE: So as it goes, my internet connection has been really shit today, so i ended up finishing the contract myself anyway. I did look at the original code afterwards, but it was pretty much the same. I haven't tested it yet though, like the rest of the contracts ill re-factor them into truffle projects and do the tests.

### 05/07/19

the DAO contract needs working on and testing, but im going to push on. Today is Friday and I wont be back at the desk until Monday so i want to get as much done as possible. Im starting the State machine contract, ive also downloaded the chainshot builder. It has a Aragon Voting dApp tutorial in it. I still need to figure out how to run the ide locally as opposed to the tutorial builder.

### 8/07/19

UPDATE: chainshot cant be run locally so that will idea will get scratched. I have re-factored the repo so every project is now a truffle project, I haven't created the migrations for each contract, ill do that as i come back to each for the unit tests. I have found another learning resource called exercism. It looks pretty good. I started the JS track but im not going to put too much effort into it until I finish the smart-contract courses.

Finished loan state machine, I implemented my own state transition function, after reviewing the code for the one in the tutorial, I actually think mine is better. because there are only three possible states and going backwards is not allowed, I was able to write the function much more concisely than the tutorial. I haven't checked but im sure it will use less gas too!
