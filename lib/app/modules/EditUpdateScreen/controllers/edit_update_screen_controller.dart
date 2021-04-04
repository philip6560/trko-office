import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:trko_official/app/models/user_model.dart';
import 'package:trko_official/app/modules/HomeScreen/controllers/home_screen_controller.dart';
import 'package:trko_official/app/modules/LoginScreen/controllers/login_screen_controller.dart';
import 'package:trko_official/app/modules/UpdatesScreen/controllers/updates_screen_controller.dart';
import 'package:trko_official/app/services/api/dio_api.dart';
import 'package:trko_official/app/widgets/loading_widget.dart';
import 'package:trko_official/app/widgets/snackbar.dart';

class EditUpdateScreenController extends GetxController {
  //TODO: Implement EditUpdateScreenController
  
  final field1 = ValueKey('editfield1');
  final field2 = ValueKey('editfield2');
  final field3 = ValueKey('editfield3');
  final field4 = ValueKey('editfield4');
  var currentItem = RxInt();
  CallResponse result;
  final formkey = GlobalKey<FormState>().obs;
  TrkoRepository trkoRepository = TrkoRepository();

  UpdatesScreenController updatesScreenController = Get.find();

  // map milestone to be edited to its corresponding index from the milestone list 
  getMilestoneId(var value){

    print("value was gotten: $value");

    for(int i = 0; i < Get.find<UpdatesScreenController>().milestoneList.length; i++){

      var element = Get.find<UpdatesScreenController>().milestoneList[i].keys;
      if(value ==  element.toString().substring(1, (element.toString().length - 1))){
        currentItem.value = i;
        print("we got currentItem: ${currentItem.value}");
      }
    }
  }

  // updates the drop down menu with every new milestone selected
  selectedItem(value){

    updatesScreenController.milestone = Get.find<UpdatesScreenController>().milestoneList[value].keys;

    updatesScreenController.milestone = updatesScreenController.milestone.toString().substring(1, (updatesScreenController.milestone.toString().length - 1));

    currentItem.value = value;

  }


  validate() async{
    if(formkey.value.currentState.validate()) {
      formkey.value.currentState.save();

      loading(context: Get.context);

      List<Map<String, dynamic>> updateData = [
        {"key": "milestone", "value": updatesScreenController.milestone.toString()},
        {"key": "description","value": updatesScreenController.descriptionController.text},
        {"key": "link1", "value": updatesScreenController.link1Controller.text},
        {"key": "link2", "value": updatesScreenController.link2Controller.text},
        {"key": "link3", "value": updatesScreenController.link3Controller.text},
        {"key": "project", "value": Get.find<HomeScreenController>()
            .projectId},
        {"key": "client", "value": Get
            .find<HomeScreenController>()
            .clientId}
            ];

      result = await trkoRepository.editUpdate(updateData: updateData, token: Get.find<LoginScreenController>().token,
          updateId: updatesScreenController.updateId);

      print("$result");

      if(result.statusCode == 200){

        print("saving....");

        await Get.find<UpdatesScreenController>().getUpdates();// check out

        Get.back(); Get.back();

        snackbarResponse("changes were successfully made.");

      }
      else{

        Get.back();

        String statusCode = result.statusCode == null ? "" : ": ${result.statusCode}";

        snackbarResponse("${result.message}$statusCode");
      }

    }
  }

  @override
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
