class Project{

  int id, statusCode;
  String startDate, title, description, status, message, budget;

  Project({this.message, this.budget, this.statusCode,
  this.startDate, this.description, this.id, this.status, this.title});

  Project.fromMap(Map<String, dynamic> map){
    id = map["id"];
    startDate = map["startdate"];
    title = map["title"];
    description = map["description"];
    status = map["status"];
    message = map["message"];
    budget = map["budget"];
    statusCode = status == null ? map["status"]: null;
  }

}