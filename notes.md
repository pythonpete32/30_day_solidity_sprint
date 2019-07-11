# Notes

## Ideas

- [x] re-factor all the contracts into truffle projects
- [] once I get to the advanced solidity lessons, start the testing course and start creating tests for past projects

## Log

### 04/07/19

Today I feel like I have got over that absolute novice stage. I am comfortable reading solidity and with the syntax, also feel comfortable using truffle to create migrations and migrating to a local chain. Today I start working on the DAO contract, this is quite exciting for me as the primary reason for me undertaking this is my interest in DAOs and Aragon. IDE So far i've been following along with the tutorials and sometimes trying to create the contracts before watching all the videos on a topic. I've had a look at the final .sol file and I recognise some patterns I've worked with before, i.e. how to keep track of voters, and the multisig pattern. I feel like I probably could write the contract on my own now (of course it would still suck!). it is tempting to take some time out and give it a go, but I'm going to push forward. The whole idea of this 30 day thing is to get as much done in the time as possible, after July I can take my time and fill in the gaps.

UPDATE: So as it goes, my internet connection has been really shit today, so I ended up finishing the contract myself anyway. I did look at the original code afterwards, but it was pretty much the same. I haven't tested it yet though, like the rest of the contracts ill re-factor them into truffle projects and do the tests.

### 05/07/19

the DAO contract needs working on and testing, but I'm going to push on. Today is Friday and I wont be back at the desk until Monday so I want to get as much done as possible. I'm starting the State machine contract, I've also downloaded the chainshot builder. It has a Aragon Voting dApp tutorial in it. I still need to figure out how to run the IDE locally as opposed to the tutorial builder.

### 8/07/19

UPDATE: chainshot cant be run locally so that will idea will get scratched. I have re-factored the repo so every project is now a truffle project, I haven't created the migrations for each contract, ill do that as I come back to each for the unit tests. I have found another learning resource called exercism. It looks pretty good. I started the JS track but I'm not going to put too much effort into it until I finish the smart-contract courses.

Finished loan state machine, I implemented my own state transition function, after reviewing the code for the one in the tutorial, I actually think mine is better. because there are only three possible states and going backwards is not allowed, I was able to write the function much more concisely than the tutorial. I haven't checked but I'm sure it will use less gas too!

started eventContract project. yet again I have limited internet access so I cant watch the video, however this gives me a opportunity to write the whole contract myself and compare it with the tutorial version afterwards. UPDATE: I am happy with how I did on my first pass. I modelled the state slightly differently than the tutorial example. We both used structs for events however I didn't include the owner inside as it was unnecessary. the only other major difference was in how we modelled the ticket state. I used a mapping of (uint => address) inside the event struct but the tutorial used (address => mapping(uint => uint)) outside the struct. In hindsight this is much more flexible as it allows transferring multiple ticket easier. using my version tickets have to be transferred one at a time and each ticket number has to be referenced explicitly.

### 10/7/19

today i decided to take a break from sm30 and start going thrugh the OpenZeppelin tutorials and docs. The reason is i feel like just watching the videos and copying is great and all, but im not learning as fast anymore. I feel comprotabe with the syntax now but where i feel im lacking is thinking about modeling larger contracts. a big reason for this is because i have not really touched on inheratance. OpenZeppelin is the libary professionals start with and build out there own contracts from there. Im not going to spend too much time with this. just enough to feel comfortable with a few design patterns before get back to sm30\.

ive almost finished the intermediate stage and im ahead of schedule so the expanded scope shudnt stop me finishing sm30 by august.
