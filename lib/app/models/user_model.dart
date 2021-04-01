class User{

  String email, password, token;
  int group_id;

  User({this.email, this.token, this.group_id});

  User.fromMap(Map<String, dynamic> map){
    email = map["email"];
    token = map["token"];
    group_id = map["group_id"];
  }


} 

class CallResponse{
  int statusCode, group_id, client_id;
  String message, token;

  CallResponse({this.statusCode, this.message, this.token, this.group_id, this.client_id});

  CallResponse.fromMap(Map<String, dynamic> map){
    statusCode = map["statusCode"];
    message = map["message"];
    token = map["token"];
    group_id = map["group_id"];
    client_id = map["id"];
  }
}