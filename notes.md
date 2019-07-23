# Notes

## Ideas

- [x] re-factor all the contracts into truffle projects
- [] once I get to the advanced solidity lessons, start the testing course and start creating tests for past projects

## Log

### 04/07/19

Today I feel like I have got over that absolute novice stage. I am comfortable reading solidity and with the syntax, also feel comfortable using truffle to create migrations and migrating to a local chain. Today I start working on the DAO contract, this is quite exciting for me as the primary reason for me undertaking this is my interest in DAOs and Aragon. IDE So far I've been following along with the tutorials and sometimes trying to create the contracts before watching all the videos on a topic. I've had a look at the final .sol file and I recognise some patterns I've worked with before, i.e. how to keep track of voters and the multisig pattern. I feel like I probably could write the contract on my own now (of course it would still suck!). it is tempting to take some time out and give it a go, but I'm going to push forward. The whole idea of this 30-day thing is to get as much done in the time as possible, after July I can take my time and fill in the gaps.

UPDATE: So as it goes, my internet connection has been really shit today, so I ended up finishing the contract myself anyway. I did look at the original code afterwards, but it was pretty much the same. I haven't tested it yet though like the rest of the contracts ill re-factor them into truffle projects and do the tests.

### 05/07/19

the DAO contract needs working on and testing, but I'm going to push on. Today is Friday and I won't be back at the desk until Monday so I want to get as much done as possible. I'm starting the State machine contract, I've also downloaded the chainshot builder. It has an Aragon Voting dApp tutorial in it. I still need to figure out how to run the IDE locally as opposed to the tutorial builder.

### 8/07/19

UPDATE: chainshot cant be run locally so that will idea will get scratched. I have refactored the repo so every project is now a truffle project, I haven't created the migrations for each contract, ill do that as I come back to each for the unit tests. I have found another learning resource called exercism. It looks pretty good. I started the JS track but I'm not going to put too much effort into it until I finish the smart-contract courses.

Finished loan state machine, I implemented my own state transition function, after reviewing the code for the one in the tutorial, I actually think mine is better. because there are only three possible states and going backwards is not allowed, I was able to write the function much more concisely than the tutorial. I haven't checked but I'm sure it will use less gas too!

started eventContract project. yet again I have limited internet access so I can't watch the video, however, this gives me an opportunity to write the whole contract myself and compare it with the tutorial version afterwards. UPDATE: I am happy with how I did on my first pass. I modelled the state slightly differently than the tutorial example. We both used structs for events however I didn't include the owner inside as it was unnecessary. the only other major difference was in how we modelled the ticket state. I used a mapping of (uint => address) inside the event struct but the tutorial used (address => mapping(uint => uint)) outside the struct. In hindsight, this is much more flexible as it allows transferring multiple tickets easier. using my version tickets have to be transferred one at a time and each ticket number has to be referenced explicitly.

### 10/7/19

today I decided to take a break from sm30 and start going through the OpenZeppelin tutorials and docs. The reason is I feel like just watching the videos and copying is great and all, but I'm not learning as fast any more. I feel comfortable with the syntax now but where I feel I'm lacking is thinking about modelling larger contracts. a big reason for this is because I have not really touched on inheritance. OpenZeppelin is the library professionals start with and build out there own contracts from there. I'm not going to spend too much time with this. just enough to feel comfortable with a few design patterns before get back to sm30.

I've almost finished the intermediate stage and I'm ahead of schedule so the expanded scope shouldn't stop me finishing sm30 by August.

### 11/7/19

Today was the last day for AGP submissions, so I was focused on reviewing those in the morning. I was also working on a proposal and Notion for a new Aragon Coop. I found a good set of videos on youtube about truffle migrations, they were using a crowdsale and two token contracts (Zeppelin) so I thought I'd kill two birds with one stone. But I overestimated my capabilities ;p While still not comfortable with inheritance, it is coming together. all I need to do is continue using the Zeppelin library and ill be there in no time. but the migrations is so complicated!!! there is a bunch of background knowledge I feel like I'm missing. Well, I'm exaggerating a bit, I do know what promises are and how they work (a bit) but I'm really uncomfortable with it. my strategy of knowing just enough JS to get by is kinda backfiring.

The long and short of it is, I've spent most of my afternoon trying to debug one of the migration files. and even though I did manage to get a lot of it fixed. I'm stuck because the error I'm getting is so unhelpful. it's referring to some library code I'm not even using. tonight I'm going to watch more of these migration vids and try again tomorrow but I'm not going to spend too much time on this if I can't fix it. really I need to just take my time and get there when I get there but I want to be deploying some Aragon apps NOW!!! lol

### 12/07/19

it is amazing what some time away from a problem can do! Last night I had a quick look at the truffle documentation (which is very well written btw) and it kinda made sense but it was 2 am and I was tired. Anyway this morning I looked at the migration and it just all clicked. I fully understood what was going on and why. Then when I got to the offending line of code, the error stuck out like a saw thumb!!!

After that my plan was to do something ambitious (ambitious in the time I had at the desk anyway) like deploy it to the Aragon devchain and create DAO with an agent, then use it to buy some tokens. But instead I an idea and a creative burst of energy. Aragon Futures Contracts.

I know I'm reaching way beyond my capability right now but I'm doing it anyway 😝. So basically I haven't done any coding today and this week I have taken quite a big detour from the plan but I think it has been successful. Today I want to finish the draft spec so all my studies can focus on making this project happen

### 15/07/19

over the weekend i wrote out the spec for the futures contract. While are a few patterns i need before it becomes a reality, it is very doable. I am goin to be focusing on this as my main project from now on. I will continue with sm30 in the evenings focus on the concepts and patterns I need for the main futures project.

the first pattern i need to grok is working with deployed tokens. The futures exchange uses ANT and DAI, i need to import the token address for each in the constructor, and then i need to be able to manipulate the balances of the msg.senders to the exchange functions. i also need to start with the testing course. I dont think I will get most from them at the moment as im at a stage with solidity where i can findout the stuff i need to know with google

### 23/07/19

Since last week, I have been working full time on the futures contract. I scrapped the first iteration and started it again due to the complexity and due to the fact it didnt work at all. I've nearly finished the second iteration and changed how it works slightly, im hoping to have it ready for testing on rinkeby by tomorrow evening. Today im going to finish FOMO3D from sm30, ill also look to finish RPS by the end of the week.

im going to shift gears to the testing course before i start on the sm30 advanced projects primarily because ill be focusing on the futures contract. This is better use of the time i have left as its more complex than the other contracts and its serves the same purpose but being my own project, gives me more scope to improve my skills and build my portfolio.
