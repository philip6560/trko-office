import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../../models/client_project_model.dart';
import '../../../services/api/dio_api.dart';
import '../../LoginScreen/controllers/login_screen_controller.dart';


class HomeScreenController extends GetxController {

  var scrollController = ScrollController().obs;
  RxBool is_button_visible = true.obs;
  int client = 2;
  int admin = 1;
  int clientId;
  TrkoRepository trkoRepository = TrkoRepository();
  List<Project> result;
  String projectCompeleted = "1";
  String projectNotCompeleted = "0";



    Future<List<Project>> getClientProjects()async{

      result = await trkoRepository.clientProject(token: Get.find<LoginScreenController>().token, clientId: clientId);

      return result;


    }
  
    hideButton(){
      if(scrollController.value.hasClients){
        if (scrollController.value.position.userScrollDirection == ScrollDirection.reverse){
          if(is_button_visible.value == true){
            is_button_visible.value = false;
          }
        }else if(scrollController.value.position.userScrollDirection == ScrollDirection.forward){
          if(is_button_visible.value == false){
            is_button_visible.value = true;
          }
        }
      }
    }
  

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    scrollController.value.addListener(()=> hideButton);
    super.onReady();
  }

  @override
  void onClose() {}

}
