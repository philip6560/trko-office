import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trko_official/app/models/user_model.dart';
import 'package:trko_official/app/modules/HomeScreen/views/home_screen_view.dart';
import 'package:trko_official/app/modules/LoginScreen/views/login_screen_view.dart';
import 'package:trko_official/app/services/api/dio_api.dart';
import 'package:trko_official/app/widgets/loading_widget.dart';
import 'package:trko_official/app/widgets/snackbar.dart';

import '../../../utils/helper.dart';
import '../../HomeScreen/controllers/home_screen_controller.dart';

class ChangePasswordScreenController extends GetxController {

  //TODO: Implement AddPaymentScreenController

  var formKey = GlobalKey<FormState>();
  final field1 = ValueKey('changePasswordField1');
  final field2 = ValueKey('changePasswordField2');
  final field3 = ValueKey('changePasswordField3');
  String token;
  int group_id;
  RxString navBackButton = "".obs;
  CallResponse result;
  TrkoRepository trkoRepository = TrkoRepository();
  Map<String, dynamic> passwordData;
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


  changePassword()async{
    if(formKey.currentState.validate()){
      formKey.currentState.save();

      loading(context: Get.context);  

      passwordData = {
      "old_pass": oldPasswordController.text,
      "new_pass1": newPasswordController.text,
      "new_pass2": confirmPasswordController.text,
      };

      result = await trkoRepository.changePassword(token: token, passwordData: passwordData);

      if(result.statusCode == 200){

        oldPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();

        Get.offAll(LoginScreen(),);

        snackbarResponse("Password updated successfully");
      }
      else{

        Get.back();

        String statusCode = result.statusCode == null ? "" : ": ${result.statusCode}";

        snackbarResponse("${result.message}$statusCode");
      }

    }

  }
  
  @override
  void onInit() async{
    navBackButton.value = await Storage.read(key: "navBack");
    token = await Storage.read(key: "token");
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  
}
