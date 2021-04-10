import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trko_official/app/modules/HomeScreen/controllers/home_screen_controller.dart';
import 'package:trko_official/app/modules/PaymentsScreen/controllers/payments_screen_controller.dart';
import 'package:trko_official/app/utils/responsive.dart';
import 'package:trko_official/app/widgets/appbar.dart';
import 'package:trko_official/app/widgets/buttons.dart';
import 'package:trko_official/app/widgets/text.dart';
import 'package:trko_official/app/widgets/text_fields.dart';

import '../controllers/edit_payment_screen_controller.dart';

class EditPaymentScreen extends  StatelessWidget {
  @override
  Widget build(BuildContext context) {

    height(double value)=> scale_height(value, context); 

    width(double value)=> scale_height(value, context); 

    EditPaymentScreenController controller = Get.put(EditPaymentScreenController());

    HomeScreenController homeScreenController = Get.find();

    PaymentsScreenController paymentsScreenController = Get.find();

    print("I came to edit screen");

    return Scaffold(
      appBar: AppBar(
        leading: NavbackButton(),
        leadingWidth: NavbackButton.leading_width,
        title: ScreenName(screen_name: "Edit Payment"),
        titleSpacing: NavbackButton.titlespacing,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: height(25.0), left: width(10.0), right: width(10.0), bottom: height(60.0)),
          child: Form(
            key: controller.formkey.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Project title
                ProjectName(projectName: homeScreenController.projectName,),

                SizedBox(height: height(32.0),),

                // amount field label
                FieldLabel(
                  labelname: 'Amount',
                ),

                SizedBox(height: height(13.0),),

                // amount field
                MyFormField(
                  key: controller.field1,
                  textInputType: TextInputType.number,
                  textEditingController: paymentsScreenController.amountController,
                  textInputAction: TextInputAction.next,
                  validator: (val)=> val.isEmpty ? "please enter amount" : null,
                  onSaved: (val)=> paymentsScreenController.amountController.text = val,
                ),

                SizedBox(height: height(26.0),),

                // date field label
                FieldLabel(
                  labelname: 'Date',
                ),

                SizedBox(height: height(12.0),),

                // date field
                MyFormField(
                  key: controller.field2,
                  textEditingController: paymentsScreenController.dateTimeController,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.datetime,
                  validator: (val)=> val.isEmpty ? "please enter date and time" : null,
                  onSaved: (val)=> paymentsScreenController.dateTimeController.text = val,
                ),

                SizedBox(height: height(26.0),),

                // note field label
                FieldLabel(
                  labelname: 'Note',
                ),

                SizedBox(height: height(12.0),),

                // note field
                MyFormField(
                  key: controller.field3,
                  textEditingController: paymentsScreenController.noteController,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.multiline,
                  validator: (val)=> val.isEmpty ? "please enter payment description" : null,
                  onSaved: (val)=> paymentsScreenController.noteController.text = val,
                ),

                SizedBox(height: height(46.0),),

                // save button
                Center(
                  child: PrimaryButton(
                    label: "Save", margin: EdgeInsets.only(left: width(54.0), right: width(40.0),), onPressed: (){  controller.validate();  },
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
