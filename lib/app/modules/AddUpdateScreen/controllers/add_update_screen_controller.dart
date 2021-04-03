import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:trko_official/app/modules/HomeScreen/controllers/home_screen_controller.dart';
import 'package:trko_official/app/modules/LoginScreen/controllers/login_screen_controller.dart';
import 'package:trko_official/app/modules/UpdatesScreen/controllers/updates_screen_controller.dart';
import 'package:trko_official/app/services/api/dio_api.dart';
import 'package:trko_official/app/widgets/loading_widget.dart';
import 'package:trko_official/app/widgets/snackbar.dart';

class AddUpdateScreenController extends GetxController {
  //TODO: Implement AddUpdateScreenController


  final field1 = ValueKey('addfield1');
  final field2 = ValueKey('addfield2');
  final field3 = ValueKey('addfield3');
  final field4 = ValueKey('addfield4');
  RxInt currentItem = RxInt();
  var formkey = GlobalKey<FormState>().obs;
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
            .find<HomeScreenController>()
            .projectId,
        "client": Get
            .find<HomeScreenController>()
            .clientId
      };

      result = await trkoRepository.addUpdate(updateData: updateData, token: Get.find<LoginScreenController>().token);

      print("$result");

      if(result["status"] == 201){

        print("saving....");

        currentItem.value = null;
        descriptionController.clear();
        link1Controller.clear();
        link2Controller.clear();
        link3Controller.clear();


        // Get.find<ProjectScreenController>().onReady();
        Get.find<UpdatesScreenController>().getUpdates(); // test this 

        Get.back();

        snackbarResponse("Milestone has been successfuly added");
      }
      else{
        return result;
      }

    }
  }

  // // validate link field 1
  // link1FieldValidator({var val}){

  //   AddUpdateScreenController controller = Get.find();

  //   if(val.isNotEmpty && GetUtils.isURL(val)){
  //     return null;
  //   }
  //   else if(val.isEmpty){
  //     if(controller.link2Controller.text.isNotEmpty && controller.link3Controller.text.isNotEmpty){
  //     return "link 1 field cannot be empty";
  //     }
  //     else if(controller.link3Controller.text.isNotEmpty){
  //       return "link 1 field cannot be empty";
  //     }
  //     else if(controller.link2Controller.text.isNotEmpty){
  //       return "link 1 field cannot be empty";
  //     }
  //   }
  //   else{
  //     return "please enter a valid url";
  //   }

  // }


  // // validate link field 2
  // link2FieldValidator({AddUpdateScreenController controller, String val}){

  //   if(val.isNotEmpty && GetUtils.isURL(val)){
  //     return null;
  //   }
  //   else if(val.isEmpty){
  //     if(controller.link1Controller.text.isNotEmpty && link3Controller.text.isNotEmpty){
  //     return "link 2 field cannot be empty";
  //     }
  //     else if(controller.link3Controller.text.isNotEmpty){
  //       return "link 2 field cannot be empty";
  //     }
  //   }
  //   else{
  //     return "please enter a valid url";
  //   }
  // }


  // // validate link field 3
  // link3FieldValidator({AddUpdateScreenController controller, String val}){

  //   if(val.isNotEmpty & GetUtils.isURL(val)){
  //     return null;
  //   }
  //   else if(val.isEmpty){
  //     return null;
  //   }
  //   else{
  //     return "please enter a valid url";
  //   }
  // }


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
