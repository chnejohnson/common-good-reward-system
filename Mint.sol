pragma solidity ^0.5.0;

import "./ERC20.sol";
import "./ERC20Detailed.sol";

contract Mint is ERC20, ERC20Detailed {
  using SafeMath for uint;

  struct Proposal {
    address sponsor;
    uint pros;
    uint cons;
    uint numOfVoters;
    uint deadline;
    Stages stage;
    mapping(address => uint) part;
    mapping(address => bool) voted;
    mapping(address => bool) gotten;
    mapping(address => bool) withdrawn;
  }

  Proposal[] public proposals;

  constructor(string memory _name, string memory _symbol, uint8 _decimals)
    ERC20Detailed(_name, _symbol, _decimals)
    public {
      registry();
      startVoting(0);
    }

  enum Stages {Start, Voting, End}

  modifier onlySponsor(uint _prop) {
    require(msg.sender == proposals[_prop].sponsor, "you are not sponsor of the proposal.");
    _;
  }

  modifier onlyPart(uint _prop) {
    require(proposals[_prop].part[msg.sender] > 0, "you are not the participants of the proposal.");
    _;
  }

  modifier onlyVoter(uint _prop) {
    require(msg.sender != proposals[_prop].sponsor, "you are the sponsor of the proposal.");
    require(proposals[_prop].part[msg.sender] == 0, "you are the participant of the proposal.");
    _;
  }

  modifier onlyStart(uint _prop) {
    require(proposals[_prop].stage == Stages.Start, "not in the Start period.");
    _;
  }

  modifier onlyVoting(uint _prop) {
    require(proposals[_prop].stage == Stages.Voting, "not in the Voting period.");
    if(proposals[_prop].deadline < now){
      proposals[_prop].stage = Stages.End;
      return;
    }
    _;
  }

  modifier onlyEnd(uint _prop) {
    require(proposals[_prop].stage == Stages.End, "not in the End period.");
    _;
  }

  modifier hasNotVoted(uint _prop) {
    require(proposals[_prop].voted[msg.sender] == false, "you have voted.");
    _;
  }

  function registry() public {
    proposals.push(Proposal(msg.sender, 0, 0, 0, 0, Stages.Start));
  }

  function join(uint _prop, uint _amount) public onlyStart(_prop) {
    require(msg.sender != proposals[_prop].sponsor, "you are the sponsor of the proposal.");
    require(_amount >= 1000, "you should send more principle.");
    proposals[_prop].part[msg.sender] = _amount;
    _burn(msg.sender, _amount);
  }

  function startVoting(uint _prop) public onlyStart(_prop) onlySponsor(_prop) {
    proposals[_prop].deadline = now + 3 days;
    proposals[_prop].stage = Stages.Voting;
  }

  function getFreeToken(uint _prop) public onlyVoter(_prop) onlyVoting(_prop) {
    require(!proposals[_prop].gotten[msg.sender], "you have gotten free token.");
    proposals[_prop].gotten[msg.sender] = true;
    _mint(msg.sender, 2000);
  }

  function voteFor(uint _prop, uint _vote) public onlyVoting(_prop) hasNotVoted(_prop) onlyVoter(_prop){
    require(_vote > 0, "you should vote more than one.");
    proposals[_prop].pros = proposals[_prop].pros.add(_vote);
    proposals[_prop].voted[msg.sender] = true;
    proposals[_prop].numOfVoters = proposals[_prop].numOfVoters.add(1);
    _burn(msg.sender, _vote.mul(_vote).mul(1000));
  }

  function voteAgainst(uint _prop, uint _vote) public onlyVoting(_prop) hasNotVoted(_prop) onlyVoter(_prop){
    require(_vote > 0, "you should vote more than one.");
    proposals[_prop].cons = proposals[_prop].cons.add(_vote);
    proposals[_prop].voted[msg.sender] = true;
    proposals[_prop].numOfVoters = proposals[_prop].numOfVoters.add(1);
    _burn(msg.sender, _vote.mul(_vote).mul(1000));
  }

  //only for developing to across three days voting period.
  function DevEndVoting(uint _prop) public onlyVoting(_prop) {
    proposals[_prop].stage = Stages.End;
  }

  function sponsorReward(uint _prop) public onlyEnd(_prop) onlySponsor(_prop) returns(bool) {
    (bool outcome,,) = _checkVote(_prop);
    if(outcome){
      proposals[_prop].withdrawn[msg.sender] = true;
      _mint(msg.sender, proposals[_prop].numOfVoters.mul(1000).div(2));
      return true;
    }else{
      return false;
    }
  }

  function partReward(uint _prop) public onlyEnd(_prop) onlyPart(_prop) {
    uint principal = proposals[_prop].part[msg.sender];
    uint amount = _calc(_prop, principal);
    proposals[_prop].part[msg.sender] = 0;
    _mint(msg.sender, amount);
  }

  function _calc(uint _prop, uint _prin) internal view returns(uint) {
    bool outcome;
    uint pros;
    uint cons;
    uint total;
    (outcome, pros, cons) = _checkVote(_prop);
    total = pros.add(cons);
    if(outcome){
      return total.add(pros).sub(cons).mul(_prin).div(total);
    }else{
      return total.sub(cons).add(pros).mul(_prin).div(total);
    }
  }

  function _checkVote(uint _prop) internal view onlyEnd(_prop) returns(bool, uint, uint) {
    uint _pros = proposals[_prop].pros;
    uint _cons = proposals[_prop].cons;
    if(_pros > _cons){
      return (true, _pros, _cons);
    }else{
      return (false, _pros, _cons);
    }
  }
}