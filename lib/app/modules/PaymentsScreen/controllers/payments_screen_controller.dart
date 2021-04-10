import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:trko_official/app/models/client_payment.dart';
import 'package:trko_official/app/models/user_model.dart';
import 'package:trko_official/app/services/api/dio_api.dart';
import 'package:trko_official/app/widgets/loading_widget.dart';
import 'package:trko_official/app/widgets/snackbar.dart';

import '../../../models/client_payment.dart';
import '../../HomeScreen/controllers/home_screen_controller.dart';

class PaymentsScreenController extends GetxController {
  //TODO: Implement PaymentsScreenController

  var slidableController = SlidableController();
  var scrollController = ScrollController().obs;
  RxBool is_button_visible = true.obs;
  var showRadius = false.obs;
  var paymentList = List<Payment>().obs;
  bool notApproved = false;
  TrkoRepository trkoRepository = TrkoRepository();
  var total = 0.obs;
  String paymentId;
  HomeScreenController _homeScreenController = Get.find();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();
  TextEditingController noteController = TextEditingController();



  totalPaid(int value){

     total.value = total.value + value;

  }


  // get payment
  Future<List<Payment>> getPayments()async{

    print("called project ${_homeScreenController.projectId}");

    List<Payment> result= await trkoRepository.projectPayment(token: _homeScreenController.token.value,
      clientId: _homeScreenController.clientId.value, projectId: _homeScreenController.projectId.toString()
    );

    print("$result");

    if(result.isNotEmpty && result[0].paymentId != null){

      paymentList.assignAll(result);

      print("I got ClientId: $paymentList");

      total.value = 0;

      // sum up payments made so far
      paymentList.forEach((element) {
        totalPaid(element.amount);
      });

      return paymentList;
    }
    if(result.isEmpty){
      paymentList.add(Payment(paymentId: null, note: null,)); 
      return paymentList;
    }
    else{

      paymentList.assignAll(result);
      return paymentList;
    }

  }


  // delete payment
  Future<CallResponse> deletePayment(String paymentId)async{

    //loader
    loading(context: Get.context);

    print("called paymentId $paymentId");

    CallResponse result = await trkoRepository.deletePayment(token: Get.find<HomeScreenController>().token.value, paymentId: paymentId);

    print("$result");

    if(result.statusCode != null){

      // refresh screen
      await Get.find<PaymentsScreenController>().getPayments();

      // remove loader
      Get.back();

      // success response
      snackbarResponse("Payment has been ${result.message.toLowerCase()}");

    }
    else{

      // remove loader
      Get.back();

      snackbarResponse("${result.message}");

    }

  }



  bool transformRadius(bool value){
    print('i was here$showRadius');
    showRadius.value = value;
    return showRadius.value;
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
    getPayments();
    scrollController.value.addListener(()=> hideButton());
    super.onReady();
  }

  @override
  void onClose() {}
}
