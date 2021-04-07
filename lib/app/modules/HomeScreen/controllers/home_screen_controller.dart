import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../../models/client_project_model.dart';
import '../../../services/api/dio_api.dart';
import '../../../utils/helper.dart';
import '../../LoginScreen/controllers/login_screen_controller.dart';


class HomeScreenController extends GetxController {

  var scrollController = ScrollController().obs;
  RxBool is_button_visible = true.obs;
  TrkoRepository trkoRepository = TrkoRepository();
  List<Project> result;
  String projectCompeleted = "1";
  String projectNotCompeleted = "0";
  var clientProject = List<Project>().obs;
  String description, startDate, budget, projectName;
  int projectId;
  RxString groupId = "".obs;
  RxString clientId = "".obs;
  RxString token = "".obs;


  getCredentials()async{
    token.value = await Storage.read(key: "token");
    groupId.value = await Storage.read(key: "groupId");
    clientId.value = await Storage.read(key: "clientId");

    print("$token, $groupId, $clientId");
  }


  Future<List<Project>> getClientProjects()async{

    result = await trkoRepository.clientProject(token: token.value, clientId: clientId.value);

    clientProject.assignAll(result);

    return clientProject;


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
  void onInit() async{
    await getCredentials();
    super.onInit();
  }

  @override
  void onReady() {
    getClientProjects();
    scrollController.value.addListener(()=> hideButton);
    super.onReady();
  }

  @override
  void onClose() {}

}
