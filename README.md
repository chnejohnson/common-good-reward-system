# Common Good Reward System
## Abstract
The core idea of this project is that people vote to decide whether the smart contract mints new token to reward the sponsor of the proposal. The use case of this project is not for the internet community but for the local living. Besides, it's not a business model. The purpose of this project is dedicated to facilitate local common good, and nature of this project is also decentralized.

## Game
There are 3 roles playing in this game.
1. **sponsor**: the person who **registrys** a proposal and has a right to start voting period and waits to get the rewards or nothing.
2. **participants**: people who **join** the proposal by casting some token into the contract and wait voting result to get the interest reward or the contract would shrink the principle when the proposal is rejected.
3. **voters**: people who can **get 2000 free token** to **vote for** or **against** the proposal, or do nothing to cumulate token for proposal in the future.

### Quadratic Voting
In my contracts, 1000 token equal to 1 voice credit. So in the QV system you should use 1 voice credit to buy 1 vote, 4 voice credit buys 2 votes, and 9 voice credit buys 3 votes, and so on.

### Reward System
So the question is how much sponsor or participants get from the successful proposal?

When the proposal succeeds, sponsor can get ![](https://latex.codecogs.com/gif.latex?%5Cdpi%7B80%7D%20%5Cfrac%7Btotalvoters%7D%7B2%7D) token, and in contrast, sponsor get nothing.

For the participants, if he cast P token into the proposal of the contract, when the proposal succeeds and the ratio of voting result is pros:cons, he can get ![](https://latex.codecogs.com/gif.latex?%5Cdpi%7B80%7D%20P%20*%281&plus;%5Cfrac%7Bpros%20-%20cons%7D%7Bpros%20&plus;%20cons%7D%20%29) token.
If the proposal is rejected, he will get ![](https://latex.codecogs.com/gif.latex?%5Cdpi%7B80%7D%20P%20*%281-%5Cfrac%7Bcons%20-%20pros%7D%7Bpros%20&plus;%20cons%7D%20%29) token.



