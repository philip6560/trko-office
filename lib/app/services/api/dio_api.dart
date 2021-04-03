import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:trko_official/app/models/client_payment.dart';
import 'package:trko_official/app/models/clients_list_model.dart';
import 'package:trko_official/app/models/project_update.dart';
import 'package:trko_official/app/models/user_model.dart';
import '../../models/client_project_model.dart';
import '../../models/clients_list_model.dart';
import '../api/api.dart';

class TrkoApi implements Api{

  var client = Dio();
  String baseUrl = "https://trko-api.herokuapp.com/api/v1";
  var response;

  @override
  Future<CallResponse> login({String email, String password}) {
    // TODO: implement login

    return null;
  }

  @override
  Future<Client> allClients({String token}) {
    // TODO: implement allClients

    return null;
  }

  @override
  Future allProjects({String token}) {
    // TODO: implement allProjects
    return null;
  }

  @override
  Future addPayment({String token, String projectId, String amount, String note, String dateTime}) {
    // TODO: implement addPayment
    return null;
  }

  @override
  Future addUpdate({String token, String projectId, String milestone, String descripition, String link1, String link2, String link3}) {
    // TODO: implement addUpdate
    return null;
  }

  @override
  Future clientProjects({String token}) {
    // TODO: implement clientProjects
    return null;
  }

  @override
  Future confirmUpdate({String token, String updateId}) {
    // TODO: implement confirmUpdate
    return null;
  }

  @override
  Future deletePayment({String token, String paymentId}) {
    // TODO: implement deletePayment
    return null;
  }

  @override
  Future deleteUpdate({String token, String updateId}) {
    // TODO: implement deleteUpdate
    return null;
  }

  @override
  Future editPayment({String token, String projectId, String paymentId, String amount, String note, String dateTime}) {
    // TODO: implement editPayment
    return null;
  }

  @override
  Future editUpdate({String token, String projectId, String updateId, String milestone, String descripition, String link1, String link2, String link3}) {
    // TODO: implement editUpdate
    return null;
  }

  @override
  Future projectPayments({String token, String projectId}) {
    // TODO: implement projectPayments
    return null;
  }

  @override
  Future projectUpdates({String token, String projectId}) {
    // TODO: implement projectUpdates
    return null;
  }

  @override
  Future resetPassword({String token, String oldPassword, String newPassword}) {
    // TODO: implement resetPassword
    return null;
  }

}




class TrkoRepository{

  var client = Dio();
  String baseUrl = "https://trko-api.herokuapp.com/api/v1";
  var response;


  clientLogin({String email, String password})async{

    print("email:$email, password: $password");

    String url = baseUrl + "/users/client/login";

    Map<String, String> loginDetails = {
      "email": email,
      "password": password,
    };
  
    try{
      // always check each user as a client first
      response = await client.post(url, data: loginDetails);

      if (response.statusCode == 200){
        print("Client found");
        return CallResponse.fromMap(response.data);
      }

    } catch (e) {
      if(e.response != null){
        if(e.response.statusCode == 404){
          // user not found then check if he's an admin
          print("404 user not found");
          return CallResponse(group_id: null, statusCode: e.response.data["status"], message: e.response.data["message"], token: null);
        }
        else{
          // could not authenticate, invalid password
          print("invalid password");
          return CallResponse(group_id: null, statusCode: 401, message: e.response.data["message"], token: null);
        }
      }
      else{
        print("Could not login, please check your internet connection" );
        return CallResponse(group_id: null, statusCode: null, message: "Could not login, please check your internet connection", token: null);
      }
    }


  }

  adminLogin({String email, String password})async{

    print("email:$email, password: $password");

    String url = baseUrl + "/users/admin/login";

    Map<String, String> loginDetails = {
      "email": email,
      "password": password,
    };
  
    try{
      // always check each user as a client first
      response = await client.post(url, data: loginDetails);

      if (response.statusCode == 200){
        print("is Admin");
        return CallResponse.fromMap(response.data);
      }

    } catch (e) {
      if(e.response != null){
        if(e.response.statusCode == 404){
          // user not found then check if he's an admin
          print("404 admin not found");
          return CallResponse.fromMap(e.response.data);
        }
        else{
          // could not authenticate, invalid password
          print("invalid password");
          return CallResponse.fromMap(e.response.data);
        }
      }
      else{
        print("Could not login, please check your internet connection" );
        return CallResponse(group_id: null, statusCode: null, message: "Could not login, please check your internet connection", token: null);
      }
    }
    
      // Map error = {"error": "Unable to login, Please check login credentials"};


  }


  Future<List<Client>> allClients({String token})async{

    print("We got token : $token");

    Map<String, String> headerDetails = {"Authorization" : "Bearer $token"};

    String url = baseUrl + "/users";
    List<Client> clients = [];

    try{

      response = await client.get(url, options: Options(headers: headerDetails));

      for(Map client in response.data){
        clients.add(Client.fromMap(client));
      }

      print("$clients");

      // returns list of all clients
      return clients;

    }
    catch (e){

      print("onCall Clients List Error: ${e.response}");

      if(e.response == null){
        clients.add(Client(message: "Oops! check your internet connection"));
        return clients;
      }
      else{
        clients.add(Client.fromMap(e.response.data));
        return clients;
      }

    }

  }

  Future<List<Project>> clientProject({String token, int clientId})async{

    print("We got token for clients project: $token");

    Map<String, String> headerDetails = {"Authorization" : "Bearer $token"};

    String url = baseUrl + "/project/client/" + clientId.toString();
    List<Project> projectsList = [];

    try{

      response = await client.get(url, options: Options(headers: headerDetails));

      for(Map project in response.data){
        projectsList.add(Project.fromMap(project));
      }

      print("client with $clientId, owns these projects $projectsList");

      // returns list of all clients
      return projectsList;

    }
    catch (e){

      debugPrint("onCall Clients List Error: ${e.response}");

      if(e.response == null){
        print("onCall Clients List DioErrorType.Default: ${e.response}");
        projectsList.add(Project(message: "Oops! check your internet connection"));
        return projectsList;
      }
      else{
        print("onCall Clients List DioErrorType.RESPONSE: ${e.response.data}");
        projectsList.add(Project(statusCode: e.response.data["status"], message: e.response.data["message"]));
        return projectsList;
      }

    }
  }

  Future<List<Update>> projectUpdate({int projectId, String token})async{

    print("We got token for clients updates: $token and projectId: $projectId");

    Map<String, String> headerDetails = {"Authorization" : "Bearer $token"};

    String url = baseUrl + "/update/project/" + projectId.toString() ;
    List<Update> updatesList = [];

    try{

      response = await client.get(url, options: Options(headers: headerDetails));

      for(Map update in response.data["data"]){
        print("$update");
        updatesList.add(Update.fromMap(update));
      }

      print("client with $projectId, owns these updates $updatesList");

      // returns list of all clients
      return updatesList;

    }
    catch (e){

      print("onCall Clients update List Error: ${e.response}");

      if(e.response == null){
        print("onCall updates List DioErrorType.Default: ${e.response}");
        updatesList.add(Update(message: "Oops! check your internet connection"));
        return updatesList;
      }
      else{
        print("onCall updates List DioErrorType.RESPONSE: ${e.response.data}");
        updatesList.add(Update(statusCode: e.response.data["status"], message: e.response.data["message"]));
        return updatesList;
      }

    }
  }

  Future<CallResponse> deleteUpdate({String updateId, String token})async{

    print("We got token for clients updates: $token and projectId: $updateId");

    Map<String, String> headerDetails = {"Authorization" : "Bearer $token"};

    String url = baseUrl + "/update/" + updateId;

    try{

      response = await client.delete(url, options: Options(headers: headerDetails));
      
      return CallResponse(statusCode: response.data["status"], message: response.data["message"]);

    }
    catch (e){

      print("onCall Clients delete update List Error: ${e.response}");

      if(e.response == null){

        return CallResponse(message: "Oops! check your internet connection.");
      }
      else{
        return CallResponse(message: "Oops! something went wrong.");
      }
    }
  }


  Future<CallResponse> approveUpdate({String updateId, String token})async{

    print("We got token for clients updates: $token and projectId: $updateId");

    Map<String, String> headerDetails = {"Authorization" : "Bearer $token"};

    String url = baseUrl + "/update/" + updateId + "/approve";

    try{

      response = await client.put(url, options: Options(headers: headerDetails));

      print("${response.data}");

      return CallResponse(statusCode: response.data["status"], message: response.data["message"]);

    }
    catch (e){

      print("onCall Clients approve update List Error: ${e.response}");

      if(e.response == null){

        return CallResponse(message: "Oops! check your internet connection.");
      }
      else{
        return CallResponse(message: "Oops! something went wrong.");
      }
    }
  }

  Future addUpdate({Map<String, dynamic> updateData, String token})async{

    print("We got token for clients updates: $token and projectId: $updateData");

    Map<String, String> headerDetails = {"Authorization" : "Bearer $token"};

    String url = baseUrl + "/update";

    try{

      response = await client.post(url, data: updateData, options: Options(headers: headerDetails));

      print("added $response");

      return response.data;

    }
    catch (e){

      print("onCall Clients delete update List Error: ${e.response}");

      if(e.response == null){

        return CallResponse(message: "Oops! check your internet connection");
      }
      else{
        return CallResponse.fromMap(e.response.data);
      }
    }
  }


  Future editUpdate({List<Map> updateData, String token, String updateId})async{

    print("We got token for clients updates: $token and projectId: $updateData");

    Map<String, String> headerDetails = {"Authorization" : "Bearer $token"};

    String url = baseUrl + "/update/" + updateId.toString();

    try{

      response = await client.put(url, data: updateData, options: Options(headers: headerDetails));

      print("added $response");

      return response.data;

    }
    catch (e){

      print("onCall Clients edit update Error: ${e.response}");

      if(e.response == null){

        return CallResponse(message: "Oops! check your internet connection");
      }
      else{
        
        return CallResponse(message: "Oops! something went wrong.");
      }
    }
  }


  Future getPayment({String token, int projectId, int clientId})async{

    print("We got token for clients updates: $token and clientId: $clientId and projectId $projectId");

    Map<String, String> headerDetails = {"Authorization" : "Bearer $token"};

    String url = baseUrl + "/payment/project/" + projectId.toString() + "/client/" + clientId.toString();

    List<Payment> paymentList = [];

    try{

      response = await client.get(url, options: Options(headers: headerDetails));

      print("added $response");

      for(Map update in response.data["data"]){
        print("$update");
        paymentList.add(Payment.fromMap(update));
      }

      return paymentList;

    }
    catch (e){

      print("onCall Clients delete update List Error: ${e.response}");

      if(e.response.data == 500){

        return CallResponse.fromMap(e.response.data);
      }
      else{
        return null;
      }
    }
  }

}









      // for (Map users in response.data){
      //   if(users["email"] == email && users["password"] == password){
      //     print("${users["email"]}");
      //     return true;
      //   }
      //   else{
      //     continue;
      //   }


            // print("response: ${response.data}, StatusCode: ${response.statusCode}");

      // return false;