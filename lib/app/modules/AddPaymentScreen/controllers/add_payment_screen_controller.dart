import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trko_official/app/models/user_model.dart';
import 'package:trko_official/app/modules/HomeScreen/controllers/home_screen_controller.dart';
import 'package:trko_official/app/modules/PaymentsScreen/controllers/payments_screen_controller.dart';
import 'package:trko_official/app/services/api/dio_api.dart';
import 'package:trko_official/app/widgets/loading_widget.dart';
import 'package:trko_official/app/widgets/snackbar.dart';

class AddPaymentScreenController extends GetxController {

  //TODO: Implement AddPaymentScreenController
  
  final field1 = ValueKey('addPaymentfield1');
  final field2 = ValueKey('addPaymentfield2');
  final field3 = ValueKey('addPaymentfield3');
  var formkey = GlobalKey<FormState>().obs;
  CallResponse result;
  TrkoRepository trkoRepository = TrkoRepository();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  validate() async{
    if(formkey.value.currentState.validate()) {
      formkey.value.currentState.save();

      loading(context: Get.context);

      Map<String, dynamic> paymentData = {
        "amount": amountController.text,
        "note": noteController.text,
        "date": dateTimeController.text.toString(),
        "project": Get
            .find<HomeScreenController>()
            .projectId,
        "client": Get
            .find<HomeScreenController>()
            .clientId
      };

      result = await trkoRepository.addPayment(paymentData: paymentData, token: Get.find<HomeScreenController>().token.value);

      print("$result");

      if(result.statusCode == 201){

        print("saving....");

        amountController.clear();
        dateTimeController.clear();
        noteController.clear();

        Get.find<PaymentsScreenController>().getPayments(); // test this

        Get.back();

        snackbarResponse(result.message);
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
