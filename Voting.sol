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
    }

    // This is a type for a single proposal.
    struct Articles {
        //bytes32 name;   // short name (up to 32 bytes)
   
        address[] fakeVoters;
        address[] trueVoters;
        address[] unsureVoters;
    }


    // This declares a state variable that
    // stores a `Voter` struct for each possible address.
    mapping(address => Voter) votersInfo;

    // A dynamically-sized array of `Proposal` structs.
    mapping(uint => Articles) articles;

   function Voting(){
      owner = msg.sender;

   }

    /// Give your vote (including votes delegated to you)
    /// to proposal `proposals[proposal].name`.

   function vote(uint voteVal, uint article) payable {

     
      //assert(articles[article].totalCount <= VOTING_LIMIT);
      // add assert for 5 articles 

      // Check that the player doesn't exists
    assert(votersInfo[msg.sender].voted[article] == false);


      // Set the number bet for that player
      votersInfo[msg.sender].voted[article] = true;

      // The player msg.sender has bet for that number
      //TODO
      if (voteVal == 0) {
         articles[article].fakeVoters.push(msg.sender);  
      } else if (voteVal == 1) {
         articles[article].trueVoters.push(msg.sender); 
      } else {
          articles[article].unsureVoters.push(msg.sender);  
      }

   }

    /// @dev Computes the winning proposal taking all
    /// previous votes into account.
    function distributeRewards() 
    {
       for (uint i = 1; i <= 5; i++) {
           uint totalCount = articles[i].fakeVoters.length + articles[i].trueVoters.length + articles[i].unsureVoters.length;
            uint majority = (articles[i].fakeVoters.length * 10)/ totalCount;
            bool isFake = false;

            if (majority > 7) {
                isFake = true;
            }
            if (isFake == true) {
                for(uint j = 0; j < articles[i].fakeVoters.length; j++) {
                  address x = articles[i].fakeVoters[j];
                }
            } else {
                for(uint k = 0; k < articles[i].trueVoters.length; k++) {
                  address y =  articles[i].trueVoters[k];
                }

            }
            
            // Delete all the players for each number
            for(uint z = 1; z <= 5; z++){
               delete articles[z];
            }
        }
        
    }


}
