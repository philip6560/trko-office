import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:trko_official/app/modules/LoginScreen/controllers/login_screen_controller.dart';
import 'package:trko_official/app/modules/UpdatesScreen/controllers/updates_screen_controller.dart';
import 'package:trko_official/app/services/api/dio_api.dart';
import 'package:trko_official/app/widgets/loading_widget.dart';
import 'package:trko_official/app/widgets/snackbar.dart';

class EditUpdateScreenController extends GetxController {
  //TODO: Implement EditUpdateScreenController

  final ratio1 = 5;
  final ratio2 = 1;
  final field1 = ValueKey('1');
  final field2 = ValueKey('2');
  final field3 = ValueKey('3');
  final field4 = ValueKey('4');
  var currentItem = 0.obs;
  var result;
  final formkey = GlobalKey<FormState>().obs;
  TrkoRepository trkoRepository = TrkoRepository();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController link1Controller = TextEditingController();
  TextEditingController link2Controller = TextEditingController();
  TextEditingController link3Controller = TextEditingController();
  var milestone;
  String updateId;

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

  selectedItem(value){

    milestone = Get.find<UpdatesScreenController>().milestoneList[value].keys;

    milestone = milestone.toString().substring(1, (milestone.toString().length - 1));

    currentItem.value = value;

  }


  validate() async{
    if(formkey.value.currentState.validate()) {
      formkey.value.currentState.save();

      loading(context: Get.context);

      List<Map<String, dynamic>> updateData = [
        {"key": "milestone", "value": milestone.toString()},
        {"key": "description","value": descriptionController.text},
        {"key": "link1", "value": link1Controller.text},
        {"key": "link2", "value": link2Controller.text},
        {"key": "link3", "value": link3Controller.text},
        {"key": "project", "value": Get.find<UpdatesScreenController>()
            .projectId},
        {"key": "client", "value": Get
            .find<UpdatesScreenController>()
            .clientId}
            ];

      result = await trkoRepository.editUpdate(updateData: updateData, token: Get.find<LoginScreenController>().token,
          updateId: updateId);

      print("$result");

      if(result["status"] == 200){

        print("saving....");

        await Get.find<UpdatesScreenController>().onReady();

        Get.back();

        snackbarResponse("changes were successfully made.");
      }
      else{
        return result;
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
