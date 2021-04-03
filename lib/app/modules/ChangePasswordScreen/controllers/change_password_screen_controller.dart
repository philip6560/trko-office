import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trko_official/app/modules/HomeScreen/views/home_screen_view.dart';
import 'package:trko_official/app/widgets/loading_widget.dart';

import '../../LoginScreen/controllers/login_screen_controller.dart';

class ChangePasswordScreenController extends GetxController {

  //TODO: Implement AddPaymentScreenController

  final ratio1 = 1;
  final field1 = ValueKey('changePasswordField1');
  final field2 = ValueKey('changePasswordField2');
  final field3 = ValueKey('changePasswordField3');
  String token;
  int group_id;
  bool navBackButton;


  changePassword()async{

    loading(context: Get.context);

    await Future.delayed(Duration(seconds: 1));

    Get.offAll(HomeScreen(), arguments: {"client_id": Get.find<LoginScreenController>().clientId});
  }
  
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  
}
