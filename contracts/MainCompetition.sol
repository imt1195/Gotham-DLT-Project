pragma solidity >=0.5.0 <0.6.0;

import "./ownable.sol";

contract MainCompetition is Ownable {

    event NewCompetition (uint256 compId, string name);

    // enum userType {Admin, Participant, Judge}
    mapping(address => uint)  public addressToUserType;

    // TO-DO: change to array? admin more than one Competition
    // TO-DO: change state variables to not public
    mapping(address => uint256) public adminToCompId;
    mapping(uint256 => address) public compIdToAdmin;

    struct Competition {
        string name;
        uint256 totalPrize;
        bool isOpen;
    }

    Competition[] public competitions;

    modifier isAdmin() {
        require(addressToUserType[msg.sender] == 0, "The Sender is not an Admin of any Competition");
        _;
    }

    modifier isParticipant() {
        require(addressToUserType[msg.sender] == 1, "The Sender is not an Participant of any Competition");
        _;
    }

    // modifier isParticipantOf (uint256 _CID, address _allegedParticipant) {
    //     require(compIdToComp[_CID].participants[_allegedParticipant], "The proposed address is not a participant in that competition");
    //     _;
    // }

    function _createComp (string memory _name, uint256 _totalPrize) internal {
        uint id = competitions.push(Competition(_name, _totalPrize,false));
        compIdToAdmin[id] = msg.sender;
        emit NewCompetition(id, _name);

    }

    function selectUserType (string memory _userType) public {
        if (keccak256(abi.encodePacked(_userType)) == keccak256(abi.encodePacked("Admin"))) {
            addressToUserType[msg.sender] = 1;
        } else {
            addressToUserType[msg.sender] = 2;
        }
    }

    function createCompetition (string memory _name, uint256 _totalPrize) public payable isAdmin() {
        require(msg.value == _totalPrize, "Message Value does not match prize amount.");
        _createComp(_name, _totalPrize);
    }

    // // Ends Competition -- Rescricted to Admins and Only Admins of this Competition
    // function endCompetition (uint256 _CID) public isAdminOf(_CID) {

    // }

    // function chooseWinner (uint256 _CID, address _winnerAddress) public isAdminOf(_CID) isParticipant()
    // isParticipantOf(_CID, _winnerAddress) {

    // }

    // function joinCompetition (uint256 _CID) public payable isCompetition(_CID) {
    //     if (compIdToComp[_CID].fee > 0) {
    //         require(msg.value >= compIdToComp[_CID].fee, "Value did not meet the competition fee");
    //     }
    // }

}
