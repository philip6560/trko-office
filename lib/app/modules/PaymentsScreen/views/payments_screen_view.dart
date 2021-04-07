import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trko_official/app/models/client_payment.dart';
import 'package:trko_official/app/modules/AddPaymentScreen/views/add_payment_screen_view.dart';
import 'package:trko_official/app/utils/responsive.dart';
import 'package:trko_official/app/utils/helper.dart';
import 'package:trko_official/app/widgets/appbar.dart';
import 'package:trko_official/app/widgets/cards.dart';
import 'package:trko_official/app/widgets/loading_widget.dart';

import '../../../models/user_model.dart';
import '../../HomeScreen/controllers/home_screen_controller.dart';
import '../controllers/payments_screen_controller.dart';

class PaymentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext payment_screen_context) {

    PaymentsScreenController controller = Get.put(PaymentsScreenController());

    HomeScreenController homeScreenController = Get.find();

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
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: EdgeInsets.only(left: width(10.0), top: height(25.0), right: width(10.0), bottom: height(60.0)),
              child: Obx(()=>
                Column(
                  children: [
                    // project name
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: width(7.0),),
                      child: Text(
                        homeScreenController.projectName,
                        style: GoogleFonts.poppins(fontSize: height(18.0), fontWeight: FontWeight.w700, color: Colors.black),
                      ),
                    ),

                    SizedBox(height: height(14.0), ),

                    // payments from the api
                    controller.paymentList.isEmpty ? // check if update's list is empty

                    Loading(isFullScreen: false ,) : // else

                    // if api call returns error
                    controller.paymentList[0].paymentId == null && controller.paymentList[0].message != null ?

                    refreshProjectScreen(
                      message: controller.paymentList[0].message,
                      label: "refresh",
                      onTap: (){
                        controller.onReady();
                      },
                      statusCode: controller.paymentList[0].statusCode,
                      isFullScreen: false,
                    )

                    : // else

                    // if project has no updates
                    controller.paymentList[0].paymentId == null && controller.paymentList[0].note == null ?

                    Container(
                      margin: EdgeInsets.only(top: height(270.0)),
                      alignment: Alignment.center,
                      child: Text("You have not made any payment.", style: GoogleFonts.poppins(fontSize: height(17.0), color: Colors.black,)),
                    )

                    : // else

                    // payment payment List were gotten display them
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(right: width(1.0),),
                          child: Text(
                            "${controller.total.value}/ ${homeScreenController.budget}",
                            style: GoogleFonts.poppins(fontSize: width(18.0), fontWeight: FontWeight.w500, color: MyColor.dark_blue),
                          ),
                        ),

                        SizedBox(height: height(12.0),),

                        ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.paymentList.length,
                          itemBuilder: (context,index){
                            Payment payment = controller.paymentList[index];
                            return Column(
                              children: [
                                SlidableCardTemplate(
                                  key: ValueKey(payment.paymentId),
                                  dateTime: convertDateTime(payment.date),
                                  note: payment.note,
                                  amount: payment.amount,
                                  paymentId: payment.paymentId,
                                  slidableController: controller.slidableController,
                                ),

                                SizedBox(height: height(19.0),),
                              ],
                            );
                          }
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        floatingActionButton: Obx(()=>
          Visibility( 
            visible: controller.is_button_visible.value == true && User.admin == homeScreenController.groupId.value? true : false,
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
