# Common Good Reward System
## Abstract
The core idea of this project is that people use tokens as voice credit to buy vote in order to decide whether the smart contract mints new tokens to reward the sponsor and the participants of the proposal. The use case of this project is not for the internet community but for the local living. Besides, it's not a business model. The purpose of this project is dedicated to facilitating local common good which can be rewarded by giving tokens. The nature of this project is decentralized and altruism, so the first proposal for voters to vote is the reward system itself.

## Game
There are 3 roles playing in this game.
1. **sponsor**: the person who **registries** a proposal and has a right to start voting period and waits to get the rewards or nothing.
2. **participants**: people who **join** the proposal by casting some token into the contract and wait voting result to get the interest reward or the contract would shrink the principle when the proposal is rejected.
3. **voters**: people who can **get 2000 free token** to **vote for** or **against** the proposal, or do nothing to cumulate token for proposal in the future.

### Quadratic Voting
In my contracts, 1000 token equal to 1 voice credit. So in the QV system you should use 1 voice credit to buy 1 vote, 4 voice credit buys 2 votes, and 9 voice credit buys 3 votes, and so on.

### Reward System
So the question is that how much tokens sponsor or participants get from the successful proposal?

When the proposal succeeds, sponsor can get ![(numOfVoters)/2](https://latex.codecogs.com/gif.latex?%5Cdpi%7B80%7D%20%5Cbg_white%20%5Cfn_phv%20%5Cfrac%7BnumOfVoters%7D%7B2%7D) tokens, and in contrast, sponsor get nothing.

For the participants, he must transfer P token to the proposal of the contract, when the proposal succeeds and the ratio of voting result is pros to cons, he can get ![](https://latex.codecogs.com/gif.latex?%5Cdpi%7B80%7D%20%5Cbg_white%20%5Cfn_phv%20P%20*%281%20&plus;%5Cfrac%7Bpros%20-%20cons%7D%7Bpros%20&plus;%20cons%7D%29) tokens.
Otherwise, If the proposal is rejected, he would get ![](https://latex.codecogs.com/gif.latex?%5Cdpi%7B80%7D%20%5Cbg_white%20%5Cfn_phv%20P%20*%281%20-%5Cfrac%7Bcons%20-%20pros%7D%7Bpros%20&plus;%20cons%7D%29) tokens.



