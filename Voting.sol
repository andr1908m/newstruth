pragma solidity ^0.4.1;


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
   // uint public numberWinner;

   // Array of players
   address[] public voters;

   // Each article number has the number of players voting fake or no fake
   
   mapping(uint => address[]) public artNumberToFakeVoters;

   mapping(uint => address[]) public artNumberToTrueVoters;
   
   mapping(uint => address[]) public artNumberToUnsureVoters;

   mapping(uint => address[]) public totalArticles;

   mapping(uint => uint) public isFake;
   
   // The numbers that each voter voted for
   mapping(address => uint[]) votesByEachVoter;

   // Modifier to only allow the execution of functions when the bets are completed
   modifier onEndVoting(){
      if(numberOfVotes >= maxAmountOfVotes) _;
      //if(totalArticles[])
   }

   /// @notice Constructor that's used to configure the minimum bet per game and the max amount of bets
   function Casino(uint _maxAmountOfVotes){
      owner = msg.sender;
      if(_maxAmountOfVotes > 0 && _maxAmountOfVotes <= LIMIT_AMOUNT_VOTES)
         maxAmountOfVotes = _maxAmountOfVotes;

   }


    function() payable {
        
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

      // assert()
      // Set the number art num for each voter
      votesByEachVoter[msg.sender].push(art_num);

      // The player msg.sender has bet for that number
      if (voteFor == 1) {
          //assert(art_num >=5 );
          artNumberToFakeVoters[art_num].push(msg.sender);
          assert(artNumberToFakeVoters[art_num].length > 0);
 
          
      } 
      if (voteFor == 0) {
          artNumberToTrueVoters[art_num].push(msg.sender);
          assert(artNumberToTrueVoters[art_num].length > 0);

      }          
      if (voteFor == 2) {
          artNumberToUnsureVoters[art_num].push(msg.sender);
          assert(artNumberToUnsureVoters[art_num].length > 0);

      }          
      
      numberOfVotes += 1;
      totalArticles[art_num].push(msg.sender);
      totalVotes += 1;
	  if (totalVotes == 5) {
	    // distributePrizes();
	  }

   }

   function artIsFake(uint article) returns(uint){
      assert(totalVotes == 5); //distributePrizes was called
	  return isFake[article];
   } 

   function distributePrizes() {
      uint winnerEtherAmount = 100 finney; // How much each winner gets
      //assert(totalVotes > 0);
      // Loop through all the winners to send the corresponding prize for each one
          for(uint i = 1; i <= 5; i++){
            //Number of voters for each article 
            uint totalCount = totalArticles[i].length;
            uint fake =  (artNumberToFakeVoters[i].length) ;
            uint n_true =  (artNumberToTrueVoters[i].length) ;
            uint n_unsure =  (artNumberToUnsureVoters[i].length) ;
            uint check = n_true + n_unsure;
            uint majority = (fake * 100) / totalCount;
            
            if( majority > 70 ) {
			    isFake[i] = 1;
			          
                for (uint j = 0; j < fake; j++) {
            
                    artNumberToFakeVoters[i][j].transfer(winnerEtherAmount);
                }
            } else {
			
				if( n_true > n_unsure) {
				    isFake[i] = 1;
					for (uint k = 0; k < artNumberToTrueVoters[i].length; k++) {
						//artNumberToTrueVoters[i][k] = 0x2f3538902fA66BA681C2e2FA17744913DEb5b2f5;
					//	artNumberToTrueVoters[i][k].transfer(winnerEtherAmount);
					}
				} else {
					isFake[i] = 2;
				}
	
            }
            
            totalArticles[i].length = 0;
            artNumberToFakeVoters[i].length = 0;
            artNumberToTrueVoters[i].length = 0;
            artNumberToUnsureVoters[i].length = 0;

          }
          totalVotes = 0;
          
   }
   
   
//   function sampleEther(){
//                     uint winnerEtherAmount = 100 finney;
//                     address var1= 0x2f3538902fA66BA681C2e2FA17744913DEb5b2f5;
//                     //this.address
//                     var1.transfer(winnerEtherAmount);
//   }
   
   
   
}
