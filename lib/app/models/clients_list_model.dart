class Client{

  int id, statusCode;
  String companyName, message;

  Client({this.id, this.companyName, this.statusCode, this.message});

  Client.fromMap(Map<String, dynamic> map){
    id = map["id"];
    statusCode = map["status"];
    companyName = map["company"];
    message = map["message"];
  }

}