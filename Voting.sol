pragma solidity ^0.4.11;

/// @title Voting with delegation.
contract Voting {
    
   address owner;

   // reward given to each person
   uint public reward = 100 finney; // Equal to 0.1 ether

   uint public numberOfNewsArticles = 5;

   uint public constant VOTING_LIMIT = 10000;

    // This declares a new complex type which will
    // be used for variables later.
    // It will represent a single voter.
    struct Voter {
        mapping(uint => bool) voted;
        mapping(uint => bool) vote;  
        
    }

    // This is a type for a single proposal.
    struct Articles {
        //bytes32 name;   // short name (up to 32 bytes)
        uint totalCount;
        bool isFake;
        address[] fakeVoters;
        address[] trueVoters;
    }


    // This declares a state variable that
    // stores a `Voter` struct for each possible address.
    mapping(address => Voter) votersInfo;

    // A dynamically-sized array of `Proposal` structs.
    Articles[] public articles;

   function Voting(){
      owner = msg.sender;

   }

    /// Give your vote (including votes delegated to you)
    /// to proposal `proposals[proposal].name`.

   function vote(bool voteVal, uint article) payable {

     
      assert(articles[article].totalCount <= VOTING_LIMIT);
     

      // Check that the player doesn't exists
      assert(votersInfo[msg.sender].voted[article] == false);


      // Set the number bet for that player
      votersInfo[msg.sender].vote[article] = voteVal;
      votersInfo[msg.sender].voted[article] = true;

      // The player msg.sender has bet for that number
      //TODO
      articles[article].totalCount += 1;
      if (voteVal == true) {
         articles[article].fakeVoters.push(msg.sender);  
      } else {
         articles[article].trueVoters.push(msg.sender); 
      }

   }

    /// @dev Computes the winning proposal taking all
    /// previous votes into account.
    function distributeRewards() 
    {
       for (uint i = 0; i < 5; i++) {
            uint majority = (articles[i].fakeVoters.length * 10)/ articles[i].totalCount;
            if (majority > 7) {
                articles[i].isFake = true;
            }
            if (articles[i].isFake == true) {
                for(uint j = 0; j < articles[j].fakeVoters.length; j++) {
                  articles[j].fakeVoters[j].transfer(reward);
                }
            } else {
                for(uint k = 0; k < articles[j].trueVoters.length; k++) {
                  articles[k].trueVoters[k].transfer(reward);
                }

            }
        }
        
    }


}