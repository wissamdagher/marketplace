// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract VisitDocument { 
  string name;
  address owner; 
  uint public visitDocumentCount;

  struct VisitDoc { 
    uint id; 
    uint _doctorvisitId;
    uint _empId;
    bytes32 _docHash;
    uint flag; //flag is one when created by the contract
  }

  event VisitDocumentAddition (
    uint documentID,
    string msg
  );
  mapping (uint => VisitDoc ) public visitdocuments;
  mapping (bytes32 => uint ) public visitdocumenthash;

  constructor() {
    name = "VisitDocument contract initialised";
    owner = msg.sender;
    visitDocumentCount = 0;
  }

  function setName(string memory _name) public { 
    name = _name;
  }

  function getName() public view returns (string memory) {
    return name;
  }

  function addVisitDocument(uint _doctorvisitId, uint _empId,bytes32 _docHash) public {
    if (!DocumentExists(_docHash)) { //check if document hash already exists
        visitDocumentCount ++;
        visitdocuments[visitDocumentCount] = VisitDoc(visitDocumentCount, _doctorvisitId, _empId, _docHash, 1);
        visitdocumenthash[_docHash] = visitDocumentCount; 

        emit VisitDocumentAddition(visitDocumentCount, "success");
    } else {
      emit VisitDocumentAddition(visitDocumentCount, "failure");
    }
  }

  function validateVisitDocument(uint _visitDocument) public {
    
  }

  function DocumentExists(bytes32 _docHash) public view returns(bool) {
      if(visitdocumenthash[_docHash] > 0) {
        return true;
      }
      else {
        return false;
      }
  }
  
}