pragma solidity >=0.4.21 <0.6.0;

contract MainCompetition {
    // TO-DO: add OpenZeppelin to transfer ownership of contract

    address public _owner;

    enum userType {Participant, Admin, Judge}
    mapping(address => userType)  public addressToUserType;

    // TO-DO: change to array? admin more than one Competition
    // TO-DO: change state variables to not public
    mapping(uint256 => address) public adminOfCID;

    mapping(uint256 => Competition) public CIDToCompetition;

    struct Competition {
        uint256 CID;
        string name;
        uint256 totalPrize;
        address admin;
        mapping(address => bool) participants;
        bool isOpen;
        uint256 fee;
    }

    event CompetitionCreated (uint256 CID, string name);

    modifier isOwner() {
        require(msg.sender == _owner, "The Owner");
        _;
    }

    modifier isCompetition (uint256 _CID) {
        require(CIDToCompetition[_CID].CID > 0, "No Competition started with that ID");
        _;
    }

    modifier isAdmin() {
        require(addressToUserType[msg.sender] == userType.Admin, "The Sender is not an Admin of any Competition");
        _;
    }

    modifier isNotAdmin() {
        require(addressToUserType[msg.sender] != userType.Admin, "The Sender is an Admin of a Competition");
        _;
    }

    modifier isAdminOf (uint256 _CID) {
        require(adminOfCID[_CID] == msg.sender, "The Sender is not an Admin of that Competition");
        _;
    }

    modifier isParticipant() {
        require(addressToUserType[msg.sender] == userType.Participant, "The Sender is not an Participant of any Competition");
        _;
    }

    modifier isParticipantOf (uint256 _CID, address _allegedParticipant) {
        require(CIDToCompetition[_CID].participants[_allegedParticipant], "The proposed address is not a participant in that competition");
        _;
    }

    constructor () public {
        _owner = msg.sender;
    }

    //TO-DO: add Counter
    function createCompetition (string memory _name, uint256 _totalPrize, uint256 _fee) public payable isOwner() {

    }

    function endCompetition (uint256 _CID) public isAdmin() isAdminOf(_CID) {

    }

    function chooseWinner (uint256 _CID, address _winnerAddress) public isAdmin isAdminOf(_CID) isParticipant()
    isParticipantOf(_CID, _winnerAddress) {

    }

    function joinCompetition (uint256 _CID) public payable isCompetition(_CID) isNotAdmin() {
        if (CIDToCompetition[_CID].fee > 0) {
            require(msg.value >= CIDToCompetition[_CID].fee, "Value did not meet the competition fee");
        }

    }

}
