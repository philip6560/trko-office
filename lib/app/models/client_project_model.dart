class Project{

  int id;
  String startDate, title, description, status, message, budget;

  Project.fromMap(Map<String, dynamic> map){
    id = map["id"];
    startDate = map["startdate"];
    title = map["title"];
    description = map["description"];
    status = map["status"];
    message = map["message"];
    budget = map["budget"];
  }

}