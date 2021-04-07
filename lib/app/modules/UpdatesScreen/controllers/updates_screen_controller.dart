import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:trko_official/app/models/project_update.dart';
import 'package:trko_official/app/models/user_model.dart';
import 'package:trko_official/app/modules/HomeScreen/controllers/home_screen_controller.dart';
import 'package:trko_official/app/modules/LoginScreen/controllers/login_screen_controller.dart';
import 'package:trko_official/app/services/api/dio_api.dart';
import 'package:trko_official/app/widgets/loading_widget.dart';
import 'package:trko_official/app/widgets/snackbar.dart';

class UpdatesScreenController extends GetxController {
  //TODO: Implement UpdatesScreenController

  var scrollController = ScrollController().obs;
  RxBool is_button_visible = true.obs;
  TrkoRepository trkoRepository = TrkoRepository();
  bool notApproved = false;
  int projectId, clientId;
  String projectName;
  String approvedAt;
  var updatesList = List<Update>().obs;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController link1Controller = TextEditingController();
  TextEditingController link2Controller = TextEditingController();
  TextEditingController link3Controller = TextEditingController();
  String updateId;
  var milestone;
  HomeScreenController homeScreenController = Get.find();



  List<Map<String, String>> milestoneList = [
    {"Prototyping":"Prototyping"},
    {"Design":"Design"},
    {"Development": "Development"},
    {"Testing": "Testing"},
    {"Staging": "Staging"},
    {"Deployment": "Deployment"},
    {"Support": "Support"},
  ];

  // get updates
  Future<List<Update>> getUpdates()async{

    List<Update> sorted = [];

    List<Update> approvedList = [];
    List<Update> unApprovedList = [];




    List<Update> result= await trkoRepository.projectUpdate(
      token: homeScreenController.token.value,
      projectId: homeScreenController.projectId,
    );

    print("$result");

    if(result.isNotEmpty && result[0].updateId != null){

      for (Update update in result){
        if(update.isApproved == false){
          unApprovedList.add(update);
        }else{
          approvedList.add(update);
        }
      }
      // add all unapproved items first
      unApprovedList.forEach((element) {
        sorted.add(element);
      });

      print("First $sorted");

      // add all approved items lastly
      approvedList.forEach((element) {
        sorted.add(element);
      });

      print("Second $sorted");

      updatesList.assignAll(sorted);

      return updatesList;
    }
    if(result.isEmpty){
      updatesList.add(Update(updateId: null, description: null,));
      return updatesList;
    }
    else{
      
      updatesList.assignAll(result);
      return updatesList;
    }

  }


  // delete update
  Future<CallResponse> deleteUpdate(String updateId)async{

    //loader
    loading(context: Get.context);

    print("called updateId $updateId");

    CallResponse result = await trkoRepository.deleteUpdate(token: homeScreenController.token.value, updateId: updateId);

    print("$result");

    if(result.statusCode != null){

      // refresh screen
      await Get.find<UpdatesScreenController>().getUpdates();
      
      // remove loader
      Get.back();

      // success response
      snackbarResponse("Update has been ${result.message.toLowerCase()}");

    }
    else{
      
      // remove loader
      Get.back();

      snackbarResponse("${result.message}");

    }

  }


  // approve update
  Future<CallResponse> approveUpdate(String updateId)async{

    // loader
    loading(context: Get.context);

    print("called approving updateId $updateId");

    CallResponse result = await trkoRepository.approveUpdate(token: homeScreenController.token.value, updateId: updateId);

    print("$result");

    if(result.statusCode != null){

      // refresh screen
      await Get.find<UpdatesScreenController>().getUpdates();
      
      // remove loader
      Get.back();

      // success response
      snackbarResponse("Update has been ${result.message.toLowerCase()}fully approved");

    }
    else{
      
      // remove loader
      Get.back();

      snackbarResponse("${result.message}");

    }
  }
  
  hideButton(){
    if(scrollController.value.hasClients ){
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


  // determines who sees un-approved updates
  showUpdate(String groupId, bool isApproved){

    if(groupId == User.client && isApproved == notApproved){

      return false;
    }else{

      return true;
    }
  }




  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getUpdates();
    scrollController.value.addListener(()=> hideButton());
    super.onReady();
  }

  @override
  void onClose() {}
}
