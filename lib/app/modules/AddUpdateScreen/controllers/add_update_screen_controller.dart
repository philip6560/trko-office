import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:trko_official/app/models/project_update.dart';
import 'package:trko_official/app/models/user_model.dart';
import 'package:trko_official/app/modules/LoginScreen/controllers/login_screen_controller.dart';
import 'package:trko_official/app/modules/UpdatesScreen/controllers/updates_screen_controller.dart';
import 'package:trko_official/app/services/api/dio_api.dart';
import 'package:trko_official/app/widgets/loading_widget.dart';
import 'package:trko_official/app/widgets/snackbar.dart';

class AddUpdateScreenController extends GetxController {
  //TODO: Implement AddUpdateScreenController


  final field1 = ValueKey('1');
  final field2 = ValueKey('2');
  final field3 = ValueKey('3');
  final field4 = ValueKey('4');
  var currentItem = 0.obs;
  final formkey = GlobalKey<FormState>().obs;
  var result;
  TrkoRepository trkoRepository = TrkoRepository();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController link1Controller = TextEditingController();
  TextEditingController link2Controller = TextEditingController();
  TextEditingController link3Controller = TextEditingController();
  var milestone;

  selectedItem(value){

    milestone = Get.find<UpdatesScreenController>().milestoneList[value].keys;

    milestone = milestone.toString().substring(1, (milestone.toString().length - 1));

    currentItem.value = value;

  }


  validate() async{
    if(formkey.value.currentState.validate()) {
      formkey.value.currentState.save();

      loading(context: Get.context);

      Map<String, dynamic> updateData = {
        "milestone": milestone.toString(),
        "description": descriptionController.text,
        "link1": link1Controller.text,
        "link2": link2Controller.text,
        "link3": link3Controller.text,
        "project": Get
            .find<UpdatesScreenController>()
            .projectId,
        "client": Get
            .find<UpdatesScreenController>()
            .clientId
      };

      result = await trkoRepository.addUpdate(updateData: updateData, token: Get.find<LoginScreenController>().token);

      print("$result");

      if(result["status"] == 201){

        print("saving....");

        await Get.find<UpdatesScreenController>().onReady();

        descriptionController.clear();
        link2Controller.clear();
        link1Controller.clear();
        link3Controller.clear();

        Get.back();

        snackbarResponse("Milestone has been successfuly added");
      }
      else{
        return result;
      }

    }
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
