class Update{
  bool isApproved;
  int projectId, clientId;
  String updateId, milestone, description, link1, link2, link3, createdAt;

  Update({this.clientId, this.isApproved, this.description, this.projectId, this.milestone,
  this.link1, this.link2, this.link3, this.updateId, this.createdAt});

  Update.fromMap(Map<String, dynamic> map){
    clientId = map["client"];
    updateId = map["_id"];
    isApproved = map["isApproved"];
    milestone = map["milestone"];
    description = map["description"];
    link1 = map["link1"];
    link2 = map["link2"];
    link3 = map["link3"];
    projectId = map["project"];
    createdAt = map["createdAt"];
  }

}