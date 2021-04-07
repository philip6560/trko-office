import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:trko_official/app/modules/LoginScreen/views/login_screen_view.dart';

import '../../../models/user_model.dart';
import '../../../utils/helper.dart';
import '../../ClientsScreen/views/clients_screen_view.dart';
import '../../HomeScreen/views/home_screen_view.dart';

class SplashScreenController extends GetxController {

  String persistLogin, groupId;

  // i'm yet to implement a technique to refresh or renew user token
  goto_next_screen () async{
    // cache svg picture
    await loadSvg(Get.context, "assets/svg/login.svg");

    persistLogin = await Storage.read(key: "persistLogin");

    groupId = await Storage.read(key: "groupId");

    await Future.delayed(Duration(seconds: 1));

    // brief imposed delay before switching screen
    if(persistLogin == "true" && groupId == User.client){

      print("i am a user $persistLogin and $groupId");

      Get.offAll(HomeScreen());
    }
    else if(persistLogin == "true" && groupId == User.admin){

      print("i am an admin $persistLogin and $groupId");

      Get.offAll(ClientsScreen());
    }
    else{

      print("i am a newUser $persistLogin and $groupId");

      Get.offAll(LoginScreen());
    }


  }

  loadSvg(BuildContext context, String path)async{

    // var that store the svg's directory
    var picture = SvgPicture.asset(path);

    // this svg is cache here
    await precachePicture(picture.pictureProvider, context);
    return picture;
  }

  @override
  void onInit() async{
    await goto_next_screen();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
