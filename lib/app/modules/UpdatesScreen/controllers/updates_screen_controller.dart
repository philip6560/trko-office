import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:trko_official/app/models/project_update.dart';
import 'package:trko_official/app/models/user_model.dart';
import 'package:trko_official/app/modules/LoginScreen/controllers/login_screen_controller.dart';
import 'package:trko_official/app/services/api/dio_api.dart';

class UpdatesScreenController extends GetxController {
  //TODO: Implement UpdatesScreenController

  var scrollController = ScrollController().obs;
  RxBool is_button_visible = true.obs;
  int admin = 1;
  int client = 2;
  TrkoRepository trkoRepository = TrkoRepository();
  bool notApproved = false;
  int projectId;
  int clientId;
  RxString milestone;
  String projectName;
  var updatesList = List<Update>().obs;

  cleanMilestone(var milestoneValue){

    milestoneValue = milestoneValue.toString().substring(1, (milestoneValue.toString().length -1));

    return milestoneValue;

  }


  List<Map<String, String>> milestoneList = [
    {"Development": "Development"},
    {"Testing": "Testing"},
    {"Staging": "Staging"},
    {"Deployment": "Deployment"},
  ];

  // get updates
  Future<List<Update>> getUpdates()async{

    List<Update> sorted = [];

    List<Update> approvedList = [];
    List<Update> unApprovedList = [];



    print("called project $projectId");

    List<Update> result= await trkoRepository.projectUpdate(token: Get.find<LoginScreenController>().token, projectId: projectId);

    print("$result");

    if(result.isNotEmpty){
      print("I got ClientId: $clientId");

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
    if(result == null){
      result.add(Update(description: "Oops! check your internet connection", updateId: null));
      updatesList.assignAll(result);
      return result;
    }
    if(result.isEmpty){
      result.add(Update(updateId: null));
      updatesList.assignAll(result);
      return result;
    }

  }


  // delete update
  Future<CallResponse> deleteUpdate(String updateId)async{


    print("called updateId $updateId");

    CallResponse result = await trkoRepository.deleteUpdate(token: Get.find<LoginScreenController>().token, updateId: updateId);

    print("$result");

    return result;

  }

  // approve update
  Future<CallResponse> approveUpdate(String updateId)async{


    print("called approving updateId $updateId");

    CallResponse result = await trkoRepository.approveUpdate(token: Get.find<LoginScreenController>().token, updateId: updateId);

    print("$result");

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



  showUpdate(int groupId, bool isApproved){
    if(groupId == client && isApproved == notApproved){

      return false;
    }else{

      return true;
    }
  }



  convertDateTime(String dateTime){

    String pattern = "T";    String pattern2 = "Z";
    List temp = [];
    String converted = "";

    dateTime.split(pattern).forEach((element) {
      temp.add(element);
    });


    converted = temp[0] + " " ;
    String tempString  = temp[1];

    tempString.split(pattern2).forEach((element){
      if(element != ""){
        converted = converted + element;
      };
    });

    print("Converted date and time newly $converted");

    return converted;
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
