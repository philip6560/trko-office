import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trko_official/app/models/client_payment.dart';
import 'package:trko_official/app/modules/AddPaymentScreen/views/add_payment_screen_view.dart';
import 'package:trko_official/app/modules/LoginScreen/controllers/login_screen_controller.dart';
import 'package:trko_official/app/utils/responsive.dart';
import 'package:trko_official/app/utils/helper.dart';
import 'package:trko_official/app/widgets/appbar.dart';
import 'package:trko_official/app/widgets/cards.dart';
import 'package:trko_official/app/widgets/loading_widget.dart';

import '../controllers/payments_screen_controller.dart';

class PaymentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext payment_screen_context) {

    PaymentsScreenController controller = Get.put(PaymentsScreenController());

    controller.projectName = Get.arguments["projectName"];
    controller.budget = Get.arguments["budget"];
    controller.clientId = Get.arguments["clientId"];
    controller.projectId = Get.arguments["projectId"];

    LoginScreenController loginScreenController = Get.find();

    return MediaQuery(
      data: myTextScaleFactor(payment_screen_context),
      child: Scaffold(
        appBar: AppBar(
          leading: NavbackButton(),
          leadingWidth: NavbackButton.leading_width,
          title: ScreenName(screen_name: "Payments",),
          titleSpacing: NavbackButton.titlespacing,
          centerTitle: false,
        ),
        body: Obx(()=>
          Center(
            child: Container(
              height: height(799.0),
              padding: EdgeInsets.only(left: width(10.0), top: height(25.0), right: width(10.0)),
              child: Column(
                children: [

                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: width(1.0),),
                    child: Text(
                      "Project XYZ an YZ",
                      style: GoogleFonts.poppins(fontSize: width(18.0), fontWeight: FontWeight.w700, color: Colors.black),
                    ),
                  ),

                  SizedBox(height: height(14.0),),

                  // Futurebuilder in conjuction with list view builder are to be utilized for the results.
                  // search results
                  controller.paymentList.isEmpty? Loading()
                      : controller.paymentList[0].paymentId != null && controller.paymentList[0].note == null

                      ? refreshProjectScreen(message: controller.paymentList[0].note, label: "refresh", statusCode: null)

                      : controller.paymentList[0].paymentId == null

                      ? Column(
                        children: [

                          Container(
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(right: width(1.0),),
                            child: Text(
                              "${controller.total}/ ${controller.budget}",
                              style: GoogleFonts.poppins(fontSize: width(18.0), fontWeight: FontWeight.w500, color: MyColor.dark_blue),
                            ),
                          ),

                          SizedBox(height: height(12.0),),

                          Container(
                    margin: EdgeInsets.only(top: height(270.0)),
                    alignment: Alignment.center,

                    child: Text("You have not made any payment.", style: GoogleFonts.poppins(fontSize: height(17.0), color: MyColor.dark_blue,)),
                  ),
                        ],
                      )
                      :ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.paymentList.length,
                      itemBuilder: (context,index){
                        Payment payment = controller.paymentList[index];
                        controller.convertDateTime(payment.date);// check clientId is gotten
                        return Column(
                          children: [
                            SlidableCardTemplate(

                            ),

                            SizedBox(height: height(19.0),),
                          ],
                        );
                      }
                  ),
                ],
              ),
            ),
          ),
        ),

              floatingActionButton: Obx(()=>
          Visibility( 
            visible: controller.is_button_visible.value == true && controller.admin == loginScreenController.group_id? true : false,
            child: FloatingActionButton(
              backgroundColor: MyColor.dark_cyan,
              onPressed: (){  Get.to(AddPaymentScreen());  },
              child: Icon(Icons.add, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
