pragma solidity >=0.4.21 <0.6.0;

contract MainCompetition {
    event StorageSet(string _message);
    event NewCompetition(uint _id, string _name);

    uint public storedData;

    struct Competition {
        string name;
        uint256 totalPrize;
        bool isOpen;
        // address[] participants;
    }

    Competition[] public competitions;

    mapping(uint => address) public compToAdmin;

    function set(uint x) public {
        storedData = x;
    }

    // Internal function for creating a competition
    function _createComp (string memory _name, uint256 _totalPrize) internal {
        uint id = competitions.push(Competition(_name, _totalPrize,false));
        compToAdmin[id] = msg.sender;
        emit NewCompetition(id, _name);
    }

    // As an admin, I can create a competition with a name and prize money
    function createCompetition (string memory _name, uint256 _totalPrize) public {
        // require(msg.value == _totalPrize, "Message Value does not match prize amount.");
        _createComp(_name, _totalPrize);
    }

    // As an admin, I can pull an array of competitions IDs
    function getCompetitions() public returns(uint256[] memory) {

    }

    // As an admin, I can end a competition and select the winning participant
    function endCompetition (uint _compId, address _winningParticipant) public {

    }

    // As a participant, I can sign up for a competition
    function joinCompetition (uint _compId) public {

    }




}
