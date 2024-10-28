// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    // Structure to represent a candidate
    struct Candidate {
        string name;
        uint voteCount;
    }
    //This function converts uint to string
    //*no native support
    function uint2str(uint _i) internal pure returns (string memory) {
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len;
        while (_i != 0) {
            k = k - 1;
            uint8 temp = (48 + uint8(_i - _i / 10 * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }
    // Array to store the candidates
    Candidate[] public candidates;

    //Variables to store the start and end times for voting 
    //*values are stored as unix epoch values
    uint public votingStart;
    uint public votingEnd;

    // Mapping to track if an address has voted
    mapping(address => bool) public voters;

    // This announces voting events(the candidate voted for and the voter)
    event Voted(address indexed voter, uint indexed candidateIndex);
    // This announces voting events(the candidate user voted for and the time they voted)
    event VoteAttempted(uint timestamp, uint candidateIndex);

    //This allows you check the current time
    // its to announce an event so the timestamp is updated 
    // and a voting session can start if you migrate the contract before the actual start time
    // itll be made more efficient with the front end but This works for now
    event CheckTime(uint timestamp);



    // This constructor initializes the candidates 
    //  as well as a start and end time for voting
    constructor(string[] memory candidateNames,uint voteStart,uint voteEnd) {
        require(voteStart < voteEnd,"Start time has to be before the end time");
        for (uint i = 0; i < candidateNames.length; i++) {
            candidates.push(Candidate({
                name: candidateNames[i],
                voteCount: 0
            }));
        }
        votingStart=voteStart;
        votingEnd=voteEnd;
    }
    //This function grabs the current timestamp
    function getCurrentTime() public returns (uint) {
        emit CheckTime(block.timestamp);
    
        return block.timestamp;
    }

    // This function votes for candidates while the voting period is valid 
    function vote(uint candidateIndex) public {  
               
        require(block.timestamp >= votingStart, string(abi.encodePacked("Voting period has not started yet. Please wait.","time is ", uint2str(block.timestamp), " voting starts by ",uint2str(votingStart))));
        require(block.timestamp <= votingEnd, string(abi.encodePacked("Voting period has ended. You can no longer vote. It ended by ",uint2str(votingEnd))));
        require(!voters[msg.sender], "You have already voted.You can not vote more than once");
        require(candidateIndex < candidates.length, "This candidate does not exist. Please vote for an existing candidate");
        
        voters[msg.sender] = true;
        candidates[candidateIndex].voteCount++;

        emit Voted(msg.sender, candidateIndex);
        emit VoteAttempted(block.timestamp, candidateIndex);
    }

    // This function gets specific candidate details
    function getCandidate(uint index) public view returns (string memory name, uint voteCount) {
        require(index < candidates.length, "Invalid candidate index.Please try again");
        return (candidates[index].name, candidates[index].voteCount);
    }

    // This function gets all candidates details
     function getAllCandidates()
     public view returns (Candidate[] memory) {
        return candidates;
        }

    // This function gets the total number of candidates 
    function getTotalCandidates() public view returns (uint) {
        return candidates.length;
    }

    // This function gets the candidate with the highest votes
    function getWinningCandidate() public view returns (string memory name, uint voteCount) {
        uint winningVoteCount = 0;
        uint winningIndex = 0;

        for (uint i = 0; i < candidates.length; i++) {
            if (candidates[i].voteCount > winningVoteCount) {
                winningVoteCount = candidates[i].voteCount;
                winningIndex = i;
            }
        }

        return (candidates[winningIndex].name, candidates[winningIndex].voteCount);
    }
}


