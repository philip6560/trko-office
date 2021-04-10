import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trko_official/app/models/user_model.dart';
import 'package:trko_official/app/modules/HomeScreen/controllers/home_screen_controller.dart';
import 'package:trko_official/app/modules/PaymentsScreen/controllers/payments_screen_controller.dart';
import 'package:trko_official/app/services/api/dio_api.dart';
import 'package:trko_official/app/widgets/loading_widget.dart';
import 'package:trko_official/app/widgets/snackbar.dart';

class EditPaymentScreenController extends GetxController {

  //TODO: Implement EditPaymentScreenController

  final ratio1 = 1;
  final field1 = ValueKey('editPaymentField1');
  final field2 = ValueKey('editPaymentField2');
  final field3 = ValueKey('editPaymentField3');
  CallResponse result;
  final formkey = GlobalKey<FormState>().obs;
  TrkoRepository trkoRepository = TrkoRepository();
  PaymentsScreenController paymentsScreenController = Get.find();


  validate() async{
    if(formkey.value.currentState.validate()) {
      formkey.value.currentState.save();

      loading(context: Get.context);

      List<Map<String, dynamic>> paymentData = [
        {"key": "amount", "value": paymentsScreenController.amountController.text},
        {"key": "note", "value": paymentsScreenController.noteController.text},
        {"key": "date", "value": paymentsScreenController.dateTimeController.text},
        {"key": "project", "value": Get.find<HomeScreenController>()
            .projectId},
        {"key": "client", "value": Get
            .find<HomeScreenController>()
            .clientId}
      ];

      result = await trkoRepository.editPayment(paymentData: paymentData, token: Get.find<HomeScreenController>().token.value,
          paymentId: paymentsScreenController.paymentId);

      print("$result");

      if(result.statusCode == 200){

        print("saving....");

        await Get.find<PaymentsScreenController>().getPayments();// check out

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
