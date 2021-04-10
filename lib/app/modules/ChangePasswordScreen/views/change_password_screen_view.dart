import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:trko_official/app/utils/responsive.dart';
import 'package:trko_official/app/widgets/appbar.dart';
import 'package:trko_official/app/widgets/buttons.dart';
import 'package:trko_official/app/widgets/text_fields.dart';

import '../controllers/change_password_screen_controller.dart';

class ChangePasswordScreen extends  StatelessWidget {


  @override
  Widget build(BuildContext context) {

    height(double value)=> scale_height(value, context); 

    width(double value)=> scale_height(value, context); 

    ChangePasswordScreenController controller = Get.put(ChangePasswordScreenController());

    print("I came to changePassword screen");

    return Obx(()=>
      Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Visibility(
            visible: controller.navBackButton.value == "true" ? true : false,
            child: NavbackButton()
            ),
          leadingWidth: controller.navBackButton.value == "false" ? 0.0 : NavbackButton.leading_width,
          title: ScreenName(screen_name: "Change Password"),
          titleSpacing: controller.navBackButton.value == "false" ? width(10.0) : NavbackButton.titlespacing,
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: height(25.0), left: width(10.0), right: width(10.0), bottom: height(60.0)),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: height(32.0),),

                  // old password field label
                  FieldLabel(
                    labelname: 'Old Password',
                  ),

                  SizedBox(height: height(13.0),),

                  // old password field
                  MyFormField(
                    key: controller.field1,
                    textEditingController: controller.oldPasswordController,
                    textInputAction: TextInputAction.next,
                    validator: (String val)=> val.isEmpty ? "please enter your old password" : null,
                    onSaved: (String val)=> controller.oldPasswordController.text = val,
                  ),

                  SizedBox(height: height(26.0),),

                  // new password field label
                  FieldLabel(
                    labelname: 'New Password',
                  ),

                  SizedBox(height: height(12.0),),

                  // new password field
                  MyFormField(
                    key: controller.field2,
                    textEditingController: controller.newPasswordController,
                    textInputAction: TextInputAction.next,
                    validator: (String val){
                      if(val.isNotEmpty){
                        if(controller.oldPasswordController.text == controller.newPasswordController.text){
                          return "please enter a new password";
                        }
                        else{
                          return null;
                        }
                      }
                      else{
                        return "please enter your new password";
                      }
                    },
                    onSaved: (String val)=> controller.newPasswordController.text = val,
                  ),

                  SizedBox(height: height(26.0),),

                  // confirm password field label
                  FieldLabel(
                    labelname: 'Retype Password',
                  ),

                  SizedBox(height: height(12.0),),

                  // confirm password field
                  MyFormField(
                    key: controller.field3,
                    textEditingController: controller.confirmPasswordController,
                    textInputAction: TextInputAction.done,
                    validator: (String val){

                      if(val.isNotEmpty){
                        if(controller.confirmPasswordController.text == controller.newPasswordController.text){
                          return null;
                        }
                        else{
                          return "passwords do not match";
                        }
                      }
                      else{
                        return "please confirm your new password";
                      }
                    },
                    onSaved: (String val)=> controller.confirmPasswordController.text = val,
                  ),

                  SizedBox(height: height(46.0),),

                  // save button
                  Center(
                    child: PrimaryButton(
                      label: "Save", margin: EdgeInsets.only(left: width(54.0), right: width(40.0),), onPressed: (){ controller.changePassword();  },
                    )
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
