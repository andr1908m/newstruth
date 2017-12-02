pragma solidity ^0.4.11;


/// @title Contract to bet Ether for a number and win randomly when the number of bets is met.
/// @author Merunas Grincalaitis
contract Voting {
   address owner;

   // The total amount of Ether bet for this current game
   uint public totalVotes;

   // The total number of bets the users have made
   uint public numberOfVotes;

   // The maximum amount of bets can be made for each game
   uint public maxAmountOfVotes = 1000;

   // The max amount of bets that cannot be exceeded to avoid excessive gas consumption
   // when distributing the prizes and restarting the game
   uint public constant LIMIT_AMOUNT_VOTES = 100;

   // The number that won the last game
   uint public numberWinner;

   // Array of players
   address[] public voters;

   // Each article number has the number of players voting fake or no fake
   mapping(uint => address[]) artNumberToFakeVoters;

   mapping(uint => address[]) artNumberToTrueVoters;
   
   
   mapping(uint => address[]) totalArticles;

   // The numbers that each voter voted for
   mapping(address => uint[]) votesByEachVoter;

   // Modifier to only allow the execution of functions when the bets are completed
   modifier onEndVoting(){
      if(numberOfVotes >= maxAmountOfVotes) _;
   }

   /// @notice Constructor that's used to configure the minimum bet per game and the max amount of bets
   function Casino(uint _maxAmountOfVotes){
      owner = msg.sender;
      if(_maxAmountOfVotes > 0 && _maxAmountOfVotes <= LIMIT_AMOUNT_VOTES)
         maxAmountOfVotes = _maxAmountOfVotes;

   }

   function checkVoterExists(address voter) returns(bool){
      if(votesByEachVoter[voter].length > 0)
         return true;
      else
         return false;
   }

   function vote(uint art_num, uint voteFor) {

      // Check that the max amount of bets hasn't been met yet
      assert(numberOfVotes < maxAmountOfVotes);

      // Check that the player doesn't exists
     // assert(checkVoterExists(msg.sender) == false);

      // Check that the number to bet is within the range
      assert(art_num >= 1 && art_num <= 5);


      // Set the number art num for each voter
      votesByEachVoter[msg.sender].push(art_num);

      // The player msg.sender has bet for that number
      if (voteFor == 1) artNumberToFakeVoters[art_num].push(msg.sender);
      if (voteFor == 0) artNumberToTrueVoters[art_num].push(msg.sender);

      numberOfVotes += 1;
      totalArticles[art_num].push(msg.sender);
      totalVotes += 1;

   }



   function distributePrizes() onEndVoting {
      uint winnerEtherAmount = 100 finney; // How much each winner gets

      // Loop through all the winners to send the corresponding prize for each one
   
          for(uint i = 1; i <= 5; i++){
            uint totalCount = totalArticles[i].length;
            uint fake =  artNumberToFakeVoters[i].length;
            uint majority = ( fake *10 )/totalCount;
            if(majority > 7) {
                for (uint j = 0; j < fake; j++) {
                    artNumberToFakeVoters[1][1] = 0xc91d9caA47e0a1904680284a2264624B6EDB55af;
                    artNumberToFakeVoters[1][1].transfer(winnerEtherAmount);
                }
            } else {
                 for (uint k = 0; k < artNumberToTrueVoters[i].length; k++) {
                    artNumberToTrueVoters[i][k] = 0xc91d9caA47e0a1904680284a2264624B6EDB55af;
    
                    artNumberToTrueVoters[i][k].transfer(winnerEtherAmount);
                }
            }
    

          }
   }
}
