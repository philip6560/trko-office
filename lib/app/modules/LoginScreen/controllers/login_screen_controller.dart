import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trko_official/app/models/user_model.dart';
import 'package:trko_official/app/modules/ChangePasswordScreen/views/change_password_screen_view.dart';
import 'package:trko_official/app/modules/ClientsScreen/views/clients_screen_view.dart';
import 'package:trko_official/app/services/api/dio_api.dart';
import 'package:trko_official/app/widgets/loading_widget.dart';
import 'package:trko_official/app/widgets/snackbar.dart';

class LoginScreenController extends GetxController {

  
  final field1 = ValueKey('loginField1');
  final field2 = ValueKey('loginField2');
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  RxString email;
  RxString password;
  CallResponse client_result;
  CallResponse admin_result;
  TrkoRepository trkoRepository = TrkoRepository();
  int group_id;
  String token;
  int clientId;
  var formKey = GlobalKey<FormState>().obs;

  validate() async{
    if(formKey.value.currentState.validate()){
      formKey.value.currentState.save();

      loading(context: Get.context);

      client_result = await trkoRepository.clientLogin(email: email.value, password: password.value);

      print("top: ${client_result.message}");

      // token and group_id will be passed to customize view
      if (client_result.statusCode == null && client_result.group_id == 2){

        print("Client going to home screen $client_result");

        group_id = client_result.group_id;
        token = client_result.token;
        clientId = client_result.client_id;
        emailcontroller.clear();
        passwordcontroller.clear();

        Get.offAll(ChangePasswordScreen(), arguments: {"navback": false});
      }

      // invalid password
      else if(client_result.statusCode == 401){

        Get.back();
        snackbarResponse("${client_result.message}");
        print("${client_result.statusCode}");
      }

      // inactive internet connection
      else if(client_result.statusCode == null){

        Get.back();
        snackbarResponse("${client_result.message}");
        print("${client_result.message}");
      }

      // check if its admin
      else if(client_result.statusCode == 404){

        // call to admin route
        admin_result = await trkoRepository.adminLogin(email: email.value, password: password.value);

        // token and group_id will be passed to customize view
        if (admin_result.statusCode == null && admin_result.group_id == 1){

          group_id = admin_result.group_id;
          token = admin_result.token;
          emailcontroller.clear();
          passwordcontroller.clear();

          Get.offAll(ClientsScreen(),);
         print("Admin going to home screen $admin_result");
        }

        // invalid password
        else if(admin_result.statusCode == 401){

          Get.back();
          snackbarResponse("${admin_result.message}.");
          print("${admin_result.message}");
        }

        // inactive internet connection
        else if(admin_result.statusCode == null){

          Get.back();
          snackbarResponse("${admin_result.message}");
          print("${admin_result.message}");
        }

        // User does not exist as an admin or a client
        else if(admin_result.statusCode == 404){
          Get.back();
          snackbarResponse("${admin_result.message}, user does not exist");
          print("404 User does not exist client value: $client_result and $admin_result ");
        }
      }
      
    }
  }

  // switch () {
  //   case :
      
  //     break;
  //   default:
  // }

  


  @override
  void onInit() {}

  @override
  void onReady() {

  }

  @override
  void onClose() {}

}
