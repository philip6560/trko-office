import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:trko_official/app/models/client_payment.dart';
import 'package:trko_official/app/modules/LoginScreen/controllers/login_screen_controller.dart';
import 'package:trko_official/app/services/api/dio_api.dart';

class PaymentsScreenController extends GetxController {
  //TODO: Implement PaymentsScreenController

  var slidableController = SlidableController().obs;
  var scrollController = ScrollController().obs;
  RxBool is_button_visible = true.obs;
  var showRadius = false.obs;
  int admin = 1;
  int client = 2;
  var paymentList = List<Payment>().obs;
  bool notApproved = false;
  String budget, projectName;
  int clientId, projectId;
  TrkoRepository trkoRepository = TrkoRepository();
  var total = 0.obs;



  totalPaid(int value){
     total.value = total.value + value;

  }



  // get payment
  Future<List<Payment>> getPayment()async{

    print("called project $projectId");

    var result= await trkoRepository.getPayment(token: Get.find<LoginScreenController>().token,
       clientId: clientId, projectId: projectId);

    print("$result");

    if(result.isNotEmpty){

      paymentList.assignAll(result);

      print("I got ClientId: $paymentList");

      return paymentList;
    }
    if(result == null){
      result.add(Payment(note: "Oops! check your internet connection", paymentId: null));
      paymentList.assignAll(result);
      return result;
    }
    if(result.isEmpty){
      result.add(Payment(paymentId: null));
      paymentList.assignAll(result);
      return result;
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
    getPayment();
    scrollController.value.addListener(()=> hideButton());
    super.onReady();
  }

  @override
  void onClose() {}
}
