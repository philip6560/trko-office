import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:trko_official/app/modules/HomeScreen/controllers/home_screen_controller.dart';
import 'package:trko_official/app/utils/responsive.dart';
import 'package:trko_official/app/widgets/appbar.dart';
import 'package:trko_official/app/widgets/buttons.dart';
import 'package:trko_official/app/widgets/text.dart';
import 'package:trko_official/app/widgets/text_fields.dart';

import '../controllers/add_payment_screen_controller.dart';

class AddPaymentScreen extends  StatelessWidget {
  @override
  Widget build(BuildContext context) {

    height(double value)=> scale_height(value, context); 

    width(double value)=> scale_height(value, context); 

    AddPaymentScreenController controller = Get.put(AddPaymentScreenController());

    HomeScreenController homeScreenController = Get.find();

    return Scaffold(
      appBar: AppBar(
        leading: NavbackButton(),
        leadingWidth: NavbackButton.leading_width,
        title: ScreenName(screen_name: "Add Payment"),
        titleSpacing: NavbackButton.titlespacing,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.only(top: height(25.0), left: width(10.0), right: width(10.0), bottom: height(60.0)),
            child: Column(
              children: [

                // Project title
                ProjectName(projectName: homeScreenController.projectName),

                SizedBox(height: height(32.0),),

                Obx(()=>
                  Form(
                    key: controller.formkey.value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // amount field label
                        FieldLabel(
                          labelname: 'Amount',
                        ),

                        SizedBox(height: height(13.0),),

                        // amount field
                        MyFormField(
                          key: controller.field1,
                          textEditingController: controller.amountController,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.number,
                          validator: (val)=> val.isEmpty ? "please enter amount" : null,
                          onSaved: (val)=> controller.amountController.text = val,
                        ),

                        SizedBox(height: height(26.0),),

                        // date field label
                        FieldLabel(
                          labelname: 'Date    Format: YYYY-MM-DD, HH:MM:SS',
                        ),

                        SizedBox(height: height(12.0),),

                        // date field
                        MyFormField(
                          key: controller.field2,
                          textEditingController: controller.dateTimeController,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.datetime,
                          validator: (val)=> val.isEmpty ? "please enter date and time" : null,
                          onSaved: (val)=> controller.dateTimeController.text = val,
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
                          textEditingController: controller.noteController,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.multiline,
                          validator: (val)=> val.isEmpty ? "please enter payment description" : null,
                          onSaved: (val)=> controller.noteController.text = val,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
